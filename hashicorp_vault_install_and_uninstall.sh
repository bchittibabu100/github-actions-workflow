stlstglvault1 vault # ll /backup/stg_vault/pl_stg_vault/
total 1920
-rwxrwxrwx. 1 smbstgpks smb_stg_service_rw 467031 Jun 11 16:00 vault_backup_20250611160001.snap
-rwxrwxrwx. 1 smbstgpks smb_stg_service_rw 467034 Jun 12 00:00 vault_backup_20250612000001.snap
-rwxrwxrwx. 1 smbstgpks smb_stg_service_rw 467037 Jun 12 08:00 vault_backup_20250612080001.snap
-rwxrwxrwx. 1 smbstgpks smb_stg_service_rw 467032 Jun 12 16:00 vault_backup_20250612160001.snap


There will be hashicorp vault backup will be created once in every 4 hours. we will have to create a bash script to restore snapshot and schedule it via cron.
