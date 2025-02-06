kyla@pldevlvault1 /opt/vault_cron_logs/dev $crontab -l
*/2 * * * * bash vault-auto-unseal.sh dev > /opt/vault_cron_logs/dev/auto_unseal.log 2>&1
0 */8 * * * ~/backup_vault_dev.sh > /opt/vault_cron_logs/dev/vault_backup.log 2>&1
* 4 * * * find /mnt/vault_backup/dev -type f -name 'vault_backup_*.snap' -mtime +14 -exec rm -f {} \; > /opt/vault_cron_logs/dev/snapshots_cleanup.log 2>&1
