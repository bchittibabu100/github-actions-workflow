#!/bin/bash
if /usr/local/bin/vault status -format json | jq ".sealed" | grep -q "false"
then
  echo "Vault is not sealed"
else
  export VAULT_ADDR=http://127.0.0.1:8200
  echo "Vault is sealed, unsealing now"
  key1=`awk '/Unseal Key 1/{print $NF}' vault-init-keys.txt`
  key2=`awk '/Unseal Key 2/{print $NF}' vault-init-keys.txt`
  key3=`awk '/Unseal Key 3/{print $NF}' vault-init-keys.txt`
  /usr/local/bin/vault operator unseal $key1
  /usr/local/bin/vault operator unseal $key2
  /usr/local/bin/vault operator unseal $key3
fi
