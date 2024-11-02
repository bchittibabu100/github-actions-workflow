#!/bin/bash

# Define the instances and their corresponding Vault addresses and key files
declare -A instances=(
  ["dev"]="http://127.0.0.1:8200"
  ["stage"]="http://127.0.0.1:8300"
  ["prod"]="http://127.0.0.1:8400"
)

for instance in "${!instances[@]}"; do
  export VAULT_ADDR="${instances[$instance]}"
  key_file="vault-init-keys-${instance}.txt"

  echo "Checking Vault instance: $instance at $VAULT_ADDR"

  # Check if Vault is sealed
  if /usr/local/bin/vault status -format json | jq ".sealed" | grep -q "false"; then
    echo "$instance Vault is not sealed"
  else
    echo "$instance Vault is sealed, unsealing now"
    
    # Read the unseal keys from the respective key file
    key1=$(awk '/Unseal Key 1/{print $NF}' $key_file)
    key2=$(awk '/Unseal Key 2/{print $NF}' $key_file)
    key3=$(awk '/Unseal Key 3/{print $NF}' $key_file)
    
    # Unseal the Vault instance with each key
    /usr/local/bin/vault operator unseal $key1
    /usr/local/bin/vault operator unseal $key2
    /usr/local/bin/vault operator unseal $key3
    
    echo "$instance Vault unsealed."
  fi
done
