#!/bin/bash

backup_path=/mnt/vault_backup
RETENTION_DAYS=14
usage() {
  echo "Usage: $0 <install/uninstall> <dev/stage/prod> [version]"
  echo "For install: $0 install <instance> <vault_version>"
  echo "For uninstall: $0 uninstall <instance>"
  exit 1
}

install_vault() {
  local INSTANCE=$1
  local VAULT_VERSION=$2
  local VAULT_URL="https://repo1.xyz.com:443/artifactory/hashicorp-releases-cache/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip"
  local CONFIG_DIR="/etc/vault.d/${INSTANCE}"
  local DATA_DIR="/opt/data/vault/${INSTANCE}"
  local SERVICE_NAME="vault-${INSTANCE}.service"

  echo "Downloading Vault version $VAULT_VERSION for $INSTANCE instance..."
  curl -O $VAULT_URL

  if [ $? -ne 0 ]; then
    echo "Error: Failed to download Vault version $VAULT_VERSION. Please check the version number."
    exit 1
  fi

  echo "Extracting Vault..."
  unzip vault_${VAULT_VERSION}_linux_amd64.zip
  echo "Installing Vault..."
  sudo mv vault /usr/local/bin/

  echo "Setting up Vault directories and permissions for $INSTANCE instance..."
  sudo mkdir -p $DATA_DIR
  sudo mkdir -p $CONFIG_DIR
  sudo mkdir -p $backup_path/$INSTANCE
  sudo mkdir -p /opt/vault_cron_logs/$INSTANCE
  sudo touch $CONFIG_DIR/vault.hcl

  echo "Creating vault user..."
  if ! id -u vault &>/dev/null; then
    sudo useradd --system --home /opt/data/vault --shell /sbin/nologin vault
  fi

  sudo chmod +x /usr/local/bin/vault
  sudo chown -R vault:vault $CONFIG_DIR
  sudo chmod -R 750 $CONFIG_DIR
  sudo chown -R vault:vault $DATA_DIR
  sudo chmod -R 750 $DATA_DIR $backup_path/$INSTANCE /opt/vault_cron_logs/$INSTANCE

  echo "Creating $CONFIG_DIR/vault.hcl configuration file for $INSTANCE instance..."
  sudo bash -c "cat > $CONFIG_DIR/vault.hcl <<EOF
# Storage backend
disable_mlock = true
ui = true
cluster_addr  = \"http://127.0.0.1:82${INSTANCE}1\"
api_addr      = \"http://127.0.0.1:82${INSTANCE}0\"
storage \"raft\" {
  path = \"$DATA_DIR\"
  node_id = \"${INSTANCE}_node\"
}
listener \"tcp\" {
  address     = \"0.0.0.0:82${INSTANCE}0\"
  tls_disable = 1
}
EOF"

  sudo chown vault:vault $CONFIG_DIR/vault.hcl

  echo "Setting up systemd service for $INSTANCE instance..."
  sudo bash -c "cat > /etc/systemd/system/$SERVICE_NAME <<EOF
[Unit]
Description=\"HashiCorp Vault ($INSTANCE instance) - A tool for managing secrets\"
Documentation=https://github.com/xyz
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=$CONFIG_DIR/vault.hcl
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
ExecStart=/usr/local/bin/vault server -config=$CONFIG_DIR/vault.hcl
ExecReload=/bin/kill --signal HUP \$MAINPID
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
EOF"

  sudo systemctl enable $SERVICE_NAME
  sudo systemctl start $SERVICE_NAME

  echo "Vault service for $INSTANCE instance installed with version: ${VAULT_VERSION}."
  sleep 10
  vault --version
  rm -f vault_${VAULT_VERSION}_linux_amd64.zip

  export VAULT_ADDR=http://127.0.0.1:82${INSTANCE}0
  echo "Initializing Vault and storing keys for $INSTANCE instance..."
  sudo /usr/local/bin/vault operator init -address=http://127.0.0.1:82${INSTANCE}0 -key-shares=5 -key-threshold=3 > $CONFIG_DIR/vault-init-keys.txt

  if [ $? -ne 0 ]; then
    echo "Error: Failed to initialize Vault."
    exit 1
  fi

  echo "Vault initialized. Keys and root token are stored in $CONFIG_DIR/vault-init-keys.txt"
  echo "Initialization complete for $INSTANCE instance."

  echo "Unsealing vault..."
  bash vault-auto-unseal.sh

  echo "Scheduling job to auto unseal..."
  autounsealcmd="bash vault-auto-unseal.sh > /opt/vault_cron_logs/$INSTANCE/auto_unseal.log 2>&1"
  autounsealcronjob="*/2 * * * * $autounsealcmd"
  ( crontab -l | grep -v -F "$autounsealcmd" || : ; echo "$autounsealcronjob" ) | crontab -

  echo "Scheduling cron for automated backups for $INSTANCE instance every 8 hours..."
  croncmd="vault operator raft snapshot save $backup_path/$INSTANCE/vault_backup_\`date +\\%Y\\%m\\%d\\%H\\%M\\%S\`.snap >> /opt/vault_cron_logs/$INSTANCE/vault_backup.log 2>&1"
  cronjob="0 */8 * * * $croncmd"
  ( crontab -l | grep -v -F "$croncmd" || : ; echo "$cronjob" ) | crontab -

  echo "Scheduling cron for cleaning up snapshots older than $RETENTION_DAYS for $INSTANCE instance..."
  cleanupcmd="find $backup_path/$INSTANCE -type f -name 'vault_backup_*.snap' -mtime +$RETENTION_DAYS -exec rm -f {} \; >> /opt/vault_cron_logs/$INSTANCE/vault_cleanup.log 2>&1"
  cleanupjob="* 4 * * * $cleanupcmd"
  ( crontab -l | grep -v -F "$cleanupcmd" || : ; echo "$cleanupjob" ) | crontab -
}

uninstall_vault() {
  local INSTANCE=$1
  local SERVICE_NAME="vault-${INSTANCE}.service"
  local CONFIG_DIR="/etc/vault.d/${INSTANCE}"
  local DATA_DIR="/opt/data/vault/${INSTANCE}"

  if ! command -v vault &> /dev/null; then
    echo "Error: Vault is not installed."
    exit 1
  fi

  echo "Stopping and disabling Vault service for $INSTANCE instance..."
  sudo systemctl stop $SERVICE_NAME
  sudo systemctl disable $SERVICE_NAME

  echo "Removing vault installation for $INSTANCE instance..."
  sudo rm -f /usr/local/bin/vault
  sudo rm -rf $DATA_DIR
  sudo rm -rf $CONFIG_DIR
  sudo rm -f /etc/systemd/system/$SERVICE_NAME
  sudo rm -rf $CONFIG_DIR/vault-init-keys.txt

  echo "Removing crontab entries for $INSTANCE instance..."
  ( crontab -l | grep -v -F "$croncmd" ) | crontab -
  ( crontab -l | grep -v -F "$cleanupcmd" ) | crontab -
  ( crontab -l | grep -v -F "$autounsealcronjob" ) | crontab -

  sudo systemctl daemon-reload
  echo "Vault uninstalled successfully for $INSTANCE instance."
}

if [ $# -lt 2 ]; then
  echo "Error: Command arguments are required."
  usage
fi

COMMAND=$1
INSTANCE=$2

case $COMMAND in
  install)
    if [ $# -ne 3 ]; then
      echo "Error: Vault version argument is required for installation."
      usage
    fi
    VAULT_VERSION=$3
    install_vault $INSTANCE $VAULT_VERSION
    ;;
  uninstall)
    uninstall_vault $INSTANCE
    ;;
  *)
    echo "Error: Invalid command. Use either 'install' or 'uninstall'."
    usage
    ;;
esac
