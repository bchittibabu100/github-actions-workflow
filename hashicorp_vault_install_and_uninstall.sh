#!/bin/bash
backup_path=/mnt/vault_backup
RETENTION_DAYS=14
usage() {
  echo "Usage: $0 <install/uninstall> [version]"
  echo "For install: $0 install <vault_version>"
  echo "For uninstall: $0 uninstall"
  exit 1
}


install_vault() {
  local VAULT_VERSION=$1
  local VAULT_URL="https://repo1.xyz.com:443/artifactory/hashicorp-releases-cache/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip"
  echo "Downloading Vault version $VAULT_VERSION..."
  curl -O $VAULT_URL

  if [ $? -ne 0 ]; then
    echo "Error: Failed to download Vault version $VAULT_VERSION. Please check the version number."
    exit 1
  fi

  echo "Extracting Vault..."
  unzip vault_${VAULT_VERSION}_linux_amd64.zip
  echo "Installing Vault..."
  sudo mv vault /usr/local/bin/

  echo "Setting up Vault directories and permissions..."
  sudo mkdir -p /opt/data/vault
  sudo mkdir -p /etc/vault.d
  sudo mkdir -p $backup_path
  sudo mkdir -p /opt/vault_cron_logs
  sudo touch /etc/vault.d/vault.hcl

  echo "Creating vault user..."
  if ! id -u vault &>/dev/null; then
    sudo useradd --system --home /opt/data/vault --shell /sbin/nologin vault
  fi

  sudo chmod +x /usr/local/bin/vault
  sudo chown -R vault:vault /etc/vault.d
  sudo chmod -R 750 /etc/vault.d
  sudo chown -R vault:vault /opt/data/vault
  sudo chmod -R 750 /opt/data/vault $backup_path /opt/vault_cron_logs

  echo "Creating /etc/vault.d/vault.hcl configuration file..."
  sudo bash -c 'cat > /etc/vault.d/vault.hcl <<EOF
# Storage backend
disable_mlock = true
ui = true
cluster_addr  = "http://127.0.0.1:8201"
api_addr      = "http://127.0.0.1:8200"
storage "raft" {
  path = "/opt/data/vault"
  node_id = "node_1"
}
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}
EOF'

  sudo chown vault:vault /etc/vault.d/vault.hcl

  echo "Setting up systemd service for vault..."
  sudo bash -c 'cat > /etc/systemd/system/vault.service <<EOF
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://github.com/xyz
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault.d/vault.hcl
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read-only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
StartLimitInterval=60
StartLimitIntervalSec=60
StartLimitBurst=3
LimitNOFILE=65536
LimitMEMLOCK=infinity
[Install]
WantedBy=multi-user.target
EOF'

  sudo systemctl enable vault.service
  sudo systemctl start vault.service

  echo "Vault service with version:${VAULT_VERSION} installed:"
  echo "Please wait..."
  sleep 10
  vault --version
  rm -f vault_${VAULT_VERSION}_linux_amd64.zip

  export VAULT_ADDR=http://127.0.0.1:8200
  echo "Initializing Vault and storing keys..."
  sudo /usr/local/bin/vault operator init -address=http://127.0.0.1:8200 -key-shares=5 -key-threshold=3 > vault-init-keys.txt

  if [ $? -ne 0 ]; then
    echo "Error: Failed to inialize Vault."
    exit 1
  fi

  echo "Vault initialized. Keys and root token are stored in vault-init-keys.txt"
  echo "Initialization complete."

  echo "Unsealing vault..."
  bash vault-auto-unseal.sh

  echo "Scheduling job to auto unseal ..."
  autounsealcmd="bash vault-auto-unseal.sh > /opt/vault_cron_logs/auto_unseal.log 2>&1"
  autounsealcronjob="*/2 * * * * $autounsealcmd"
  ( crontab -l | grep -v -F "$autounsealcmd" || : ; echo "$autounsealcronjob" ) | crontab -

  echo "Scheduling cron for automated backups once in every 8 hours..."
  croncmd="vault operator raft snapshot save $backup_path/vault_backup_`$(date +\%Y\%m\%d\%H\%M\%S)`.snap >> /opt/vault_cron_logs/vault_backup.log 2>&1"
  cronjob="0 */8 * * * $croncmd"
  ( crontab -l | grep -v -F "$croncmd" || : ; echo "$cronjob" ) | crontab -

  echo "Scheduling cron for cleaning up snapshots older than $RETENTION_DAYS ..."
  cleanupcmd="find $backup_path -type f -name 'vault_backup_*.snap' -mtime +$RETENTION_DAYS -exec rm -f {} \; >> /opt/vault_cron_logs/vault_cleanup.log 2>&1"
  cleanupjob="* 4 * * * $cleanupcmd"
  ( crontab -l | grep -v -F "$cleanupcmd" || : ; echo "$cleanupjob" ) | crontab -
}


uninstall_vault() {
  if ! command -v vault &> /dev/null; then
    echo "Error: Vault is not installed."
    exit 1
  fi

  echo "Stopping and disabling Vault service..."
  sudo systemctl stop vault.service
  sudo systemctl disable vault.service

  echo "Removing vault installation..."
  sudo rm -f /usr/local/bin/vault
  sudo rm -rf /opt/data/vault
  sudo rm -rf /etc/vault.d
  sudo rm -rf /etc/systemd/system/vault.service
  sudo rm -rf LICENSE.txt
  sudo rm -rf vault-init-keys.txt

  echo "Removing vault user..."
  sudo userdel -r vault 2>/dev/null
  sudo systemctl daemon-reload
  echo "Removing crontab entry"
  ( crontab -l | grep -v -F "$croncmd" ) | crontab -
  ( crontab -l | grep -v -F "$cleanupjob" ) | crontab -
  ( crontab -l | grep -v -F "$autounsealcronjob" ) | crontab -
  echo "Vault uninstalled successfully."
}

if [ $# -lt 1 ]; then
  echo "Error: Command argument (install or uninstall) is required."
  usage
fi

COMMAND=$1

case $COMMAND in
  install)
    if [ $# -ne 2 ]; then
      echo "Error: Vault version argument is required for installation."
      usage
    fi
    VAULT_VERSION=$2
    install_vault $VAULT_VERSION
    ;;
  uninstall)
    uninstall_vault
    ;;
  *)
    echo "Error: Invalid command. Use either 'install' or 'uninstall'."
    usage
    ;;
esac
