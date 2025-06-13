stlstglvault1 vault # echo "${VAULT_BIN}"
/usr/local/bin/vault
stlstglvault1 vault # echo "${SNAP}"
/backup/stg_vault/pl_stg_vault/vault_backup_20250612160001.snap
stlstglvault1 vault # /usr/local/bin/vault operator raft snapshot restore -force /backup/stg_vault/pl_stg_vault/vault_backup_20250612160001.snap
Error installing the snapshot: Post "http://10.140.112.100:8200/v1/sys/storage/raft/snapshot-force": dial tcp 10.140.112.100:8200: connect: connection refused
stlstglvault1 vault # systemctl status vault
○ vault.service - "HashiCorp Vault - A tool for managing secrets"
     Loaded: loaded (/etc/systemd/system/vault.service; enabled; preset: disabled)
     Active: inactive (dead) since Fri 2025-06-13 00:03:04 CDT; 2min 45s ago
   Duration: 4min 35.103s
       Docs: https://github.com/optum-financial/vpay-vault
    Process: 114999 ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl (code=exited, status=0/SUCCESS)
   Main PID: 114999 (code=exited, status=0/SUCCESS)
        CPU: 914ms

Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.633-0500 [INFO]  core: pre-seal teardown complete
Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.640-0500 [ERROR] core: unlocking HA lock failed: error="cannot find peer"
Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.640-0500 [ERROR] storage.raft.raft-net: failed to accept connection: error="Raft RPC layer cl>
Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.640-0500 [INFO]  core: stopping cluster listeners
Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.640-0500 [INFO]  core.cluster-listener: forwarding rpc listeners stopped
Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.700-0500 [INFO]  core.cluster-listener: rpc listeners successfully shut down
Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.700-0500 [INFO]  core: cluster listeners successfully shut down
Jun 13 00:03:04 stlstglvault1.vpayusa.net vault[114999]: 2025-06-13T00:03:04.700-0500 [INFO]  core: vault is sealed
Jun 13 00:03:04 stlstglvault1.vpayusa.net systemd[1]: vault.service: Deactivated successfully.
Jun 13 00:03:04 stlstglvault1.vpayusa.net systemd[1]: Stopped "HashiCorp Vault - A tool for managing secrets".
stlstglvault1 vault # pgrep -x vault
