OpenSSH_8.9p1 Ubuntu-3ubuntu0.13, OpenSSL 3.0.2 15 Mar 2022
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files
debug1: /etc/ssh/ssh_config line 21: Applying options for *
debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts' -> '/home/gitrunner/.ssh/known_hosts'
debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts2' -> '/home/gitrunner/.ssh/known_hosts2'
debug2: resolving "plprdlas-fax06.kpayusa.net" port 22
debug3: resolve_host: lookup plprdlas-fax06.kpayusa.net:22
debug3: ssh_connect_direct: entering
debug1: Connecting to plprdlas-fax06.kpayusa.net [10.130.100.223] port 22.
debug3: set_sock_tos: set socket 3 IP_TOS 0x10
debug1: Connection established.
debug1: identity file /home/gitrunner/.ssh/id_rsa type 0
debug1: identity file /home/gitrunner/.ssh/id_rsa-cert type -1
debug1: identity file /home/gitrunner/.ssh/id_ecdsa type -1
debug1: identity file /home/gitrunner/.ssh/id_ecdsa-cert type -1
debug1: identity file /home/gitrunner/.ssh/id_ecdsa_sk type -1
debug1: identity file /home/gitrunner/.ssh/id_ecdsa_sk-cert type -1
debug1: identity file /home/gitrunner/.ssh/id_ed25519 type -1
debug1: identity file /home/gitrunner/.ssh/id_ed25519-cert type -1
debug1: identity file /home/gitrunner/.ssh/id_ed25519_sk type -1
debug1: identity file /home/gitrunner/.ssh/id_ed25519_sk-cert type -1
debug1: identity file /home/gitrunner/.ssh/id_xmss type -1
debug1: identity file /home/gitrunner/.ssh/id_xmss-cert type -1
debug1: identity file /home/gitrunner/.ssh/id_dsa type -1
debug1: identity file /home/gitrunner/.ssh/id_dsa-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.13
debug1: Remote protocol version 2.0, remote software version OpenSSH_7.4
debug1: compat_banner: match: OpenSSH_7.4 pat OpenSSH_7.4* compat 0x04000006
debug2: fd 3 setting O_NONBLOCK
debug1: Authenticating to plprdlas-fax06.kpayusa.net:22 as 'bamboosa'
debug3: record_hostkey: found key type ED25519 in file /home/gitrunner/.ssh/known_hosts:32
debug3: record_hostkey: found key type ECDSA in file /home/gitrunner/.ssh/known_hosts:33
debug3: load_hostkeys_file: loaded 2 keys from plprdlas-fax06.kpayusa.net
debug1: load_hostkeys: fopen /home/gitrunner/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
debug3: order_hostkeyalgs: have matching best-preference key type ssh-ed25519-cert-v01@openssh.com, using HostkeyAlgorithms verbatim
debug3: send packet: type 20
debug1: SSH2_MSG_KEXINIT sent
debug3: receive packet: type 20
debug1: SSH2_MSG_KEXINIT received
debug2: local client KEXINIT proposal
debug2: KEX algorithms: curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,sntrup761x25519-sha512@openssh.com,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,ext-info-c,kex-strict-c-v00@openssh.com
debug2: host key algorithms: ssh-ed25519-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,sk-ecdsa-sha2-nistp256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-ed25519,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,sk-ssh-ed25519@openssh.com,sk-ecdsa-sha2-nistp256@openssh.com,rsa-sha2-512,rsa-sha2-256
debug2: ciphers ctos: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: ciphers stoc: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: MACs ctos: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: MACs stoc: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: compression ctos: none,zlib@openssh.com,zlib
debug2: compression stoc: none,zlib@openssh.com,zlib
debug2: languages ctos:
debug2: languages stoc:
debug2: first_kex_follows 0
debug2: reserved 0
debug2: peer server KEXINIT proposal
debug2: KEX algorithms: curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
debug2: host key algorithms: ssh-rsa,rsa-sha2-512,rsa-sha2-256,ecdsa-sha2-nistp256,ssh-ed25519
debug2: ciphers ctos: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com,aes128-cbc,aes192-cbc,aes256-cbc,blowfish-cbc,cast128-cbc,3des-cbc
debug2: ciphers stoc: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com,aes128-cbc,aes192-cbc,aes256-cbc,blowfish-cbc,cast128-cbc,3des-cbc
debug2: MACs ctos: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: MACs stoc: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: compression ctos: none,zlib@openssh.com
debug2: compression stoc: none,zlib@openssh.com
debug2: languages ctos:
debug2: languages stoc:
debug2: first_kex_follows 0
debug2: reserved 0
debug1: kex: algorithm: curve25519-sha256
debug1: kex: host key algorithm: ssh-ed25519
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug3: send packet: type 30
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug3: receive packet: type 31
debug1: SSH2_MSG_KEX_ECDH_REPLY received
debug1: Server host key: ssh-ed25519 SHA256:4krzbWKVM94XamuK2b3YlFXttV6bpZN7ajumuuvHHec
debug3: record_hostkey: found key type ED25519 in file /home/gitrunner/.ssh/known_hosts:32
debug3: record_hostkey: found key type ECDSA in file /home/gitrunner/.ssh/known_hosts:33
debug3: load_hostkeys_file: loaded 2 keys from plprdlas-fax06.kpayusa.net
debug1: load_hostkeys: fopen /home/gitrunner/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
debug1: Host 'plprdlas-fax06.kpayusa.net' is known and matches the ED25519 host key.
debug1: Found key in /home/gitrunner/.ssh/known_hosts:32
debug3: send packet: type 21
debug2: ssh_set_newkeys: mode 1
debug1: rekey out after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug3: receive packet: type 21
debug1: SSH2_MSG_NEWKEYS received
debug2: ssh_set_newkeys: mode 0
debug1: rekey in after 134217728 blocks
debug1: Will attempt key: /home/gitrunner/.ssh/id_rsa RSA SHA256:WEt9hsNZI3vrM/IpIKXsMgPUzHjYflcbj5Lme5cCtx0
debug1: Will attempt key: /home/gitrunner/.ssh/id_ecdsa
debug1: Will attempt key: /home/gitrunner/.ssh/id_ecdsa_sk
debug1: Will attempt key: /home/gitrunner/.ssh/id_ed25519
debug1: Will attempt key: /home/gitrunner/.ssh/id_ed25519_sk
debug1: Will attempt key: /home/gitrunner/.ssh/id_xmss
debug1: Will attempt key: /home/gitrunner/.ssh/id_dsa
debug2: pubkey_prepare: done
debug3: send packet: type 5
debug3: receive packet: type 7
debug1: SSH2_MSG_EXT_INFO received
debug1: kex_input_ext_info: server-sig-algs=<rsa-sha2-256,rsa-sha2-512>
debug3: receive packet: type 6
debug2: service_accept: ssh-userauth
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug3: send packet: type 50
debug3: receive packet: type 53
debug3: input_userauth_banner: entering

NOTICE TO USERS:

THIS IS A PRIVATE COMPUTER SYSTEM. It is for authorized use only. Users
(authorized or unauthorized) have no explicit or implicit expectation of
privacy.

Any or all uses of this system and all files on this system may be intercepted,
monitored, recorded, copied, audited, inspected, and disclosed to authorized
site personnel. By using this system, the user consents to such interception,
monitoring, recording, copying, auditing, inspection, and disclosure at the
discretion of authorized site personnel.

Unauthorized or improper use of this system may result in administrative
disciplinary action and civil and criminal penalties. By continuing to use this
system you indicate your awareness of and consent to these terms and conditions
of use.

LOG OFF IMMEDIATELY if you do not agree to the conditions stated in this
warning.

debug3: receive packet: type 51
debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
debug3: start over, passed a different list publickey,gssapi-keyex,gssapi-with-mic,password
debug3: preferred gssapi-with-mic,publickey,keyboard-interactive,password
debug3: authmethod_lookup gssapi-with-mic
debug3: remaining preferred: publickey,keyboard-interactive,password
debug3: authmethod_is_enabled gssapi-with-mic
debug1: Next authentication method: gssapi-with-mic
debug1: No credentials were supplied, or the credentials were unavailable or inaccessible
No Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1001)


debug1: No credentials were supplied, or the credentials were unavailable or inaccessible
No Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1001)


debug2: we did not send a packet, disable method
debug3: authmethod_lookup publickey
debug3: remaining preferred: keyboard-interactive,password
debug3: authmethod_is_enabled publickey
debug1: Next authentication method: publickey
debug1: Offering public key: /home/gitrunner/.ssh/id_rsa RSA SHA256:WEt9hsNZI3vrM/IpIKXsMgPUzHjYflcbj5Lme5cCtx0
debug3: send packet: type 50
debug2: we sent a publickey packet, wait for reply
debug3: receive packet: type 60
debug1: Server accepts key: /home/gitrunner/.ssh/id_rsa RSA SHA256:WEt9hsNZI3vrM/IpIKXsMgPUzHjYflcbj5Lme5cCtx0
debug3: sign_and_send_pubkey: using publickey with RSA SHA256:WEt9hsNZI3vrM/IpIKXsMgPUzHjYflcbj5Lme5cCtx0
debug3: sign_and_send_pubkey: signing using rsa-sha2-512 SHA256:WEt9hsNZI3vrM/IpIKXsMgPUzHjYflcbj5Lme5cCtx0
debug3: send packet: type 50
Connection closed by 10.10.10.23 port 22
