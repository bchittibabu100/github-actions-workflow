0600 [WARN]  unknown or unsupported field unauthenticated_metrics_access found in configuration at /etc/vault.d/dev/vault.hcl:15:3

pldevlvault1 vault.d # systemctl status vault-dev
● vault-dev.service - "HashiCorp Vault (dev instance) - A tool for managing secrets"
     Loaded: loaded (/etc/systemd/system/vault-dev.service; enabled; preset: disabled)
     Active: active (running) since Mon 2025-02-03 22:22:08 CST; 7min ago
       Docs: https://github.com/optum-financial/vpay-vault
   Main PID: 3956098 (vault-dev)
      Tasks: 10 (limit: 48923)
     Memory: 50.5M
        CPU: 1.396s
     CGroup: /system.slice/vault-dev.service
             └─3956098 /usr/local/bin/vault-dev server -config=/etc/vault.d/dev/vault.hcl

Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.392-0600 [INFO]  rollback: Starting the rollback manager with 256 workers
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.392-0600 [INFO]  rollback: starting rollback manager
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.392-0600 [INFO]  core: restoring leases
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.402-0600 [INFO]  expiration: lease restore complete
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.414-0600 [INFO]  identity: entities restored
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.414-0600 [INFO]  identity: groups restored
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.420-0600 [INFO]  core: starting raft active node
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.433-0600 [INFO]  storage.raft: starting autopilot: config="CleanupDeadServers:false LastC>
Feb 03 22:23:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:23:26.456-0600 [INFO]  core: post-unseal setup complete
Feb 03 22:24:26 pldevlvault1.test.net vault-dev[3956098]: 2025-02-03T22:24:26.445-0600 [WARN]  core.raft: skipping new raft TLS config creation, keys are pending
pldevlvault1 vault.d # cat /etc/vault.d/dev/vault.hcl
# Storage backend
disable_mlock = true
ui = true
cluster_addr  = "http://127.0.0.1:8201"
api_addr      = "http://127.0.0.1:8200"
storage "raft" {
  path = "/opt/data/vault/dev"
  node_id = "dev_node"
}
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}
telemetry {
  unauthenticated_metrics_access = true
  prometheus_retention_time = "15m"
}
