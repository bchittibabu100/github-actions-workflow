plprdlas-fax06 ~ # ps -ef | grep -Ei 'sssd|winbind'
root      45665      1  0 23:01 ?        00:00:00 /usr/sbin/sssd -i --logger=files
root      45666  45665  0 23:01 ?        00:00:00 /usr/libexec/sssd/sssd_be --domain kpay.net --uid 0 --gid 0 --logger=files
root      45669  45665  0 23:01 ?        00:00:00 /usr/libexec/sssd/sssd_nss --uid 0 --gid 0 --logger=files
root      45670  45665  0 23:01 ?        00:00:00 /usr/libexec/sssd/sssd_pam --uid 0 --gid 0 --logger=files

plprdlas-fax06 ~ # auth required pam_access.so
-bash: auth: command not found
