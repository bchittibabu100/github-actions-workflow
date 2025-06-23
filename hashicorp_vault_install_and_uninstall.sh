#!/usr/bin/env bash
#
# Restore latest Vault snapshot on standby node.
# Logs output to ./vault_restore_<timestamp>.log
# -------------------------------------------------------------------

set -euo pipefail

# ─── CONFIG ─────────────────────────────────────────────────────────
SNAP_DIR="/backup/stg_vault/pl_stg_vault"
VAULT_BIN="/usr/local/bin/vault"
VAULT_SERVICE="vault"
# ────────────────────────────────────────────────────────────────────

# Logging
TS_LOG=$(date '+%Y-%m-%d_%H%M')
LOG_FILE="./vault_restore_${TS_LOG}.log"

# Timestamp function
ts() { date '+%F %T'; }

{
  echo "$(ts) [vault-restore] Starting standby restore process"

  # Find latest snapshot
  SNAP=$(ls -1t "${SNAP_DIR}"/vault_backup_*.snap 2>/dev/null | head -n1)
  if [[ -z "${SNAP:-}" ]]; then
    echo "$(ts) [vault-restore] ERROR: No snapshot found in ${SNAP_DIR}"
    exit 1
  fi

  echo "$(ts) [vault-restore] Found snapshot: ${SNAP}"

  # Stop Vault
  echo "$(ts) [vault-restore] Stopping Vault service..."
  systemctl stop "${VAULT_SERVICE}"

  # Ensure process is stopped
  while pgrep -x vault >/dev/null; do
    echo "$(ts) [vault-restore] Waiting for Vault process to exit..."
    sleep 1
  done

  # Unset VAULT_ADDR to force local restore
  unset VAULT_ADDR VAULT_TOKEN VAULT_NAMESPACE VAULT_SKIP_VERIFY

  # Restore snapshot
  echo "$(ts) [vault-restore] Restoring snapshot..."
  "${VAULT_BIN}" operator raft snapshot restore -force "${SNAP}"

  # Restart Vault
  echo "$(ts) [vault-restore] Starting Vault service..."
  systemctl start "${VAULT_SERVICE}"

  echo "$(ts) [vault-restore] Restore completed successfully"
} | tee "${LOG_FILE}"
