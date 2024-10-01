# github-actions-workflow
Github action's workflows to provision AWS resources with the help of terraform, AWS CLI, AWS Cloudformation templates and with the python boto3

#!/bin/bash
usage() {
  echo "Usage: $0 <install/uninstall> [version]"
  echo "For install: $0 install <vault_version>"
  echo "For uninstall: $0 uninstall"
  exit 1
}


install_vault() {
  local VAULT_VERSION=$1
  local VAULT_URL="https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip"
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
  sudo mkdir -p /opt/vault/data
  sudo mkdir -p /etc/vault.d
  sudo touch /etc/vault.d/vault.hcl

  echo "Creating vault user..."
  if ! id -u vault &>/dev/null; then
    sudo useradd --system --home /opt/vault/data --shell /sbin/nologin vault
  fi

  sudo chmod +x /usr/local/bin/vault
  sudo chown -R vault:vault /etc/vault.d
  sudo chmod -R 750 /etc/vault.d
  sudo chown -R vault:vault /opt/vault/data
  sudo chmod -R 750 /opt/vault/data

  echo "Creating /etc/vault.d/vault.hcl configuration file..."
  sudo bash -c 'cat > /etc/vault.d/vault.hcl <<EOF
# Storage backend
storage "file" {
  path = "/opt/vault/data"
}

# Listener
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

disable_mlock = true
api_addr      =  "http://127.0.0.1:8200"
EOF'

  sudo chown vault:vault /etc/vault.d/vault.hcl

  echo "Setting up systemd service for vault..."
  sudo bash -c 'cat > /etc/systemd/system/vault.service <<EOF
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
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
#AmbientCapabilities=CAP_IPC_LOCK
#Capabilities=CAP_IPC_LOCK+ep
#CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
#Restart=on-failure
#RestartSec=5
#TimeoutStopSec=30
#StartLimitInterval=60
#StartLimitIntervalSec=60
#StartLimitBurst=3
LimitNOFILE=65536
LimitMEMLOCK=infinity
[Install]
WantedBy=multi-user.target
EOF'

  sudo systemctl enable vault.service
  sudo systemctl start vault.service

  echo "Vault version installed:"
  vault --version
  rm -f vault_${VAULT_VERSION}_linux_amd64.zip
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
  sudo rm -rf /opt/vault/data
  sudo rm -rf /etc/vault.d
  sudo rm -rf /etc/systemd/system/vault.service

  echo "Removing vault user..."
  sudo userdel -r vault 2>/dev/null
  sudo systemctl daemon-reload
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
