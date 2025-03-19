Vault is reachable on vault.plpksprod.wayusa.net but not on vault.prod.pks.wayusa.net as i am getting bad gateway of 502 error


Info:
====
cboya1@plinfldops02 ~ $ kubectl get po -n vault-prod
NAME                                             READY   STATUS      RESTARTS   AGE
consul-consul-server-0                           1/1     Running     103        186d
consul-consul-server-1                           1/1     Running     333        146d
consul-consul-server-2                           1/1     Running     37         146d
vault-0                                          1/1     Running     1          162d
vault-1                                          1/1     Running     0          146d
vault-2                                          1/1     Running     0          29d
vault-injector-agent-injector-76965557bc-29sjf   1/1     Running     2          186d
vault-restore-l5wgx                              0/1     Completed   0          182d
cboya1@plinfldops02 ~ $ kubectl get svc -n vault-prod
NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                   AGE
consul-consul-dns                   ClusterIP   10.100.200.239   <none>        53/TCP,53/UDP                                                             186d
consul-consul-server                ClusterIP   None             <none>        8500/TCP,8301/TCP,8301/UDP,8302/TCP,8302/UDP,8300/TCP,8600/TCP,8600/UDP   186d
consul-consul-ui                    NodePort    10.100.200.97    <none>        80:30899/TCP                                                              186d
vault                               ClusterIP   10.100.200.177   <none>        8200/TCP,8201/TCP                                                         186d
vault-active                        ClusterIP   10.100.200.193   <none>        8200/TCP,8201/TCP                                                         186d
vault-injector-agent-injector-svc   ClusterIP   10.100.200.189   <none>        443/TCP                                                                   2y256d
vault-internal                      ClusterIP   None             <none>        8200/TCP,8201/TCP                                                         186d
vault-standby                       ClusterIP   10.100.200.190   <none>        8200/TCP,8201/TCP                                                         186d
cboya1@plinfldops02 ~ $ kubectl get ingress -n vault-prod
NAME            CLASS    HOSTS                                                                      ADDRESS         PORTS   AGE
consul-consul   <none>   consul.prod.pks.wayusa.net,consul.plpksprod.wayusa.net                   10.132.104.12   80      186d
vault           <none>   vault.prod.pks.wayusa.net,vault.plpksprod.wayusa.net,vault.wayusa.net   10.132.104.12   80      175d
cboya1@plinfldops02 ~ $ kubectl describe ingress -n vault-prod vault
Name:             vault
Namespace:        vault-prod
Address:          10.132.104.12
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
Rules:
  Host                         Path  Backends
  ----                         ----  --------
  vault.prod.pks.wayusa.net
                               /   vault-active:8200 (172.16.33.3:8200)
  vault.plpksprod.wayusa.net
                               /   vault-active:8200 (172.16.33.3:8200)
  vault.wayusa.net
                               /   vault-active:8200 (172.16.33.3:8200)
Annotations:                   meta.helm.sh/release-name: vault
                               meta.helm.sh/release-namespace: vault-prod
                               ncp/internal_ip_for_policy: 100.164.144.3
Events:                        <none>
