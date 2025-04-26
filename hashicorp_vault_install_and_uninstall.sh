Here is the config
==================
  3 # /etc/sssd/sssd.conf
  4 #
  5 # WARNING: This file is managed by Salt. Any changes you make WILL be erased!
  6 #
  7 [sssd]
  8 domains = kPayUSA.net
  9 config_file_version = 2
 10 services = nss, pam
 11
 12 [domain/kPayUSA.net]
 13 ad_domain = kPayUSA.net
 14 krb5_realm = kPAYUSA.NET
 15 realmd_tags = manages-system joined-with-samba
 16 cache_credentials = True
 17 id_provider = ad
 18 debug_level = 4
 19 krb5_store_password_if_offline = True
 20 default_shell = /bin/bash
 21 ldap_id_mapping = True
 22 use_fully_qualified_names = False
 23 fallback_homedir = /home/%u
 24 access_provider = simple
 25
 26 # Only select groups and/or users are allowed to connect to this system
 27 simple_allow_groups = role_it_linux_admin, role_prd_linux_admin, role_temp_prd_linux_admin, right_prd_linux_ssh
 28
 29 dyndns_update = true
 30 dyndns_refresh_interval = 43200
 31 dyndns_update_ptr = true
 32 dyndns_ttl = 3600
 33 simple_allow_users = ansibleprod@kpayusa.net, ansibledev@kpayusa.net, ansiblestg@kpayusa.net, abadmin@kpayusa.net
 34
 35 ### START Salt extra block
 36 ### END Salt extra block
 
 
 service status
 ==============
 plprdlas-fax06 ~ # systemctl status sssd.service
● sssd.service - System Security Services Daemon
   Loaded: loaded (/usr/lib/systemd/system/sssd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2025-04-25 23:36:14 CDT; 1s ago
 Main PID: 48008 (sssd)
   CGroup: /system.slice/sssd.service
           ├─48008 /usr/sbin/sssd -i --logger=files
           ├─48009 /usr/libexec/sssd/sssd_be --domain kPayUSA.net --uid 0 --gid 0 --logger=files
           ├─48010 /usr/libexec/sssd/sssd_nss --uid 0 --gid 0 --logger=files
           └─48011 /usr/libexec/sssd/sssd_pam --uid 0 --gid 0 --logger=files

Apr 25 23:36:14 plprdlas-fax06.kpayusa.net systemd[1]: Started System Security Services Daemon.
Apr 25 23:36:14 plprdlas-fax06.kpayusa.net sssd_be[48009]: GSSAPI client step 1
Apr 25 23:36:14 plprdlas-fax06.kpayusa.net sssd_be[48009]: GSSAPI client step 1
Apr 25 23:36:14 plprdlas-fax06.kpayusa.net sssd_be[48009]: GSSAPI client step 1
Apr 25 23:36:14 plprdlas-fax06.kpayusa.net sssd_be[48009]: GSSAPI client step 2
Apr 25 23:36:14 plprdlas-fax06.kpayusa.net sssd[48008]: ; TSIG error with server: tsig verify failure
Apr 25 23:36:14 plprdlas-fax06.kpayusa.net sssd[48008]: ; TSIG error with server: tsig verify failure
Apr 25 23:36:15 plprdlas-fax06.kpayusa.net sssd[48008]: ; TSIG error with server: tsig verify failure
Apr 25 23:36:15 plprdlas-fax06.kpayusa.net sssd[48008]: ; TSIG error with server: tsig verify failure
Apr 25 23:36:15 plprdlas-fax06.kpayusa.net sssd[48008]: ; TSIG error with server: tsig verify failure
plprdlas-fax06 ~ # vim /etc/sssd/sssd.conf
plprdlas-fax06 ~ # /usr/sbin/sssd --version
1.16.5
