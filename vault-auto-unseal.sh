#!/bin/bash

# Define the instances and their corresponding addresses and key files
declare -A instance_addresses=(
  ["dev"]="http://127.0.0.1:8200"
  ["stage"]="http://127.0.0.1:8300"
  ["prod"]="http://127.0.0.1:8400"
)
declare -A key_files=(
  ["dev"]="vault-init-keys-dev.txt"
  ["stage"]="vault-init-keys-stage.txt"
  ["prod"]="vault-init-keys-prod.txt"
)

# Check if instance name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <instance_name>"
  echo "Available instances: ${!instance_addresses[@]}"
  exit 1
fi

# Get the instance name from input parameter
instance=$1

# Validate instance name
if [ -z "${instance_addresses[$instance]}" ]; then
  echo "Error: Invalid instance name '$instance'."
  echo "Available instances: ${!instance_addresses[@]}"
  exit 1
fi

# Set Vault address and key file based on instance
export VAULT_ADDR="${instance_addresses[$instance]}"
key_file="${key_files[$instance]}"

echo "Checking Vault instance: $instance at $VAULT_ADDR"

# Check if the instance is reachable
if ! curl -s --connect-timeout 5 "${VAULT_ADDR}/v1/sys/health" &>/dev/null; then
  echo "Warning: $instance Vault instance at $VAULT_ADDR is not reachable. Exiting."
  exit 1
fi

# Check if Vault is sealed
if /usr/local/bin/vault status -format json | jq ".sealed" | grep -q "false"; then
  echo "$instance Vault is not sealed"
else
  echo "$instance Vault is sealed, unsealing now"
  
  # Check if key file exists
  if [ ! -f "$key_file" ]; then
    echo "Error: Unseal key file $key_file not found for $instance. Exiting."
    exit 1
  fi

  # Read the unseal keys from the respective key file
  key1=$(awk '/Unseal Key 1/{print $NF}' "$key_file")
  key2=$(awk '/Unseal Key 2/{print $NF}' "$key_file")
  key3=$(awk '/Unseal Key 3/{print $NF}' "$key_file")
  
  # Unseal the Vault instance with each key
  /usr/local/bin/vault operator unseal "$key1"
  /usr/local/bin/vault operator unseal "$key2"
  /usr/local/bin/vault operator unseal "$key3"
  
  echo "$instance Vault unsealed."
fi
