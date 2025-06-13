#!/usr/bin/env bash
#
# Periodically restores the latest Vault snapshot on a standby node.
# Should be triggered via cron.
# -------------------------------------------------------------------

set -euo pipefail

# ─── CONFIG ─────────────────────────────────────────────────────────
SNAP_DIR="/backup/stg_vault/pl_stg_vault"
VAULT_BIN="/usr/local/bin/vault"
VAULT_SERVICE="vault"
LOG_TAG="vault-restore"
# ────────────────────────────────────────────────────────────────────

ts() { date '+%F %T'; }

echo "$(ts) [$LOG_TAG] Starting standby restore process" | systemd-cat -t "$LOG_TAG" || true

SNAP=$(ls -1t "${SNAP_DIR}"/vault_backup_*.snap 2>/dev/null | head -n1)

if [[ -z "${SNAP:-}" ]]; then
  echo "$(ts) [$LOG_TAG] No snapshot found in ${SNAP_DIR}" | systemd-cat -t "$LOG_TAG"
  exit 1
fi

echo "$(ts) [$LOG_TAG] Found snapshot: ${SNAP}" | systemd-cat -t "$LOG_TAG"

# Stop Vault on standby node
echo "$(ts) [$LOG_TAG] Stopping Vault service..." | systemd-cat -t "$LOG_TAG"
systemctl stop "${VAULT_SERVICE}"

# Restore the snapshot
echo "$(ts) [$LOG_TAG] Restoring snapshot: ${SNAP}" | systemd-cat -t "$LOG_TAG"
"${VAULT_BIN}" operator raft snapshot restore -force "${SNAP}"

# Restart Vault
echo "$(ts) [$LOG_TAG] Starting Vault service..." | systemd-cat -t "$LOG_TAG"
systemctl start "${VAULT_SERVICE}"

echo "$(ts) [$LOG_TAG] Restore completed successfully" | systemd-cat -t "$LOG_TAG"



# Restore snapshot every 4 hours at minute 5
MAILTO=""
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
5 */4 * * * /usr/local/bin/vault_restore.sh >> /var/log/vault_restore.log 2>&1
