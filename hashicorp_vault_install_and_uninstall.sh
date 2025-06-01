cboya1@plinfldops02 ~/crushftp/redcard $ kubectl get pv red-card-watch-dog-crushftp
NAME                          CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                                 STORAGECLASS   REASON   AGE
red-card-watch-dog-crushftp   5000Gi     RWX            Retain           Bound    red-card-watch-dog-prod/red-card-watch-dog-crushftp   smb                     5m13s
cboya1@plinfldops02 ~/crushftp/redcard $
cboya1@plinfldops02 ~/crushftp/redcard $
cboya1@plinfldops02 ~/crushftp/redcard $
cboya1@plinfldops02 ~/crushftp/redcard $ kubectl get pvc -n red-card-watch-dog-prod red-card-watch-dog-crushftp
NAME                          STATUS   VOLUME                        CAPACITY   ACCESS MODES   STORAGECLASS   AGE
red-card-watch-dog-crushftp   Bound    red-card-watch-dog-crushftp   5000Gi     RWX            smb            5m20s
cboya1@plinfldops02 ~/crushftp/redcard $
cboya1@plinfldops02 ~/crushftp/redcard $
cboya1@plinfldops02 ~/crushftp/redcard $ kubectl describe po -n red-card-watch-dog-prod red-card-watch-dog-5f8c68977f-v7gbh
Name:           red-card-watch-dog-5f8c68977f-v7gbh
Namespace:      red-card-watch-dog-prod
Priority:       0
Node:           9af3d3fd-68df-4d13-ac95-c760af36d20b/172.57.0.37
Start Time:     Sun, 01 Jun 2025 00:18:40 -0500
Labels:         app=red-card-watch-dog-red-card-watch-dog-production
                app.kubernetes.io/cluster-domain=prod.pks.test.net
                app.kubernetes.io/instance=red-card-watch-dog-red-card-watch-dog
                app.kubernetes.io/managed-by=Helm
                app.kubernetes.io/name=red-card-watch-dog
                app.kubernetes.io/part-of=red-card-watch-dog
                helm.sh/chart=red-card-watch-dog-0.0.1
                pod-template-hash=5f8c68977f
Annotations:    app.gitlab.com/app: engineering-red-card-watch-dog-red-card-watch-dog
                app.gitlab.com/env: plprod
                checksum/appsettings.secure.json: e036f57cd760fcd8ad77bf93c0eba6d9bcb27a9227f72120740d4192dd83e35c
                kubectl.kubernetes.io/restartedAt: 2024-07-15T18:02:16-05:00
Status:         Pending
IP:
IPs:            <none>
Controlled By:  ReplicaSet/red-card-watch-dog-5f8c68977f
Containers:
  red-card-watch-dog:
    Container ID:
    Image:          plinfharbor.test.net/red-card-watch-dog/red-card-watch-dog:v0.1.2
    Image ID:
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     100m
      memory:  256Mi
    Requests:
      cpu:      10m
      memory:   128Mi
    Liveness:   http-get http://:primary-port/api/about delay=30s timeout=3s period=30s #success=1 #failure=5
    Readiness:  http-get http://:primary-port/api/about delay=0s timeout=3s period=10s #success=1 #failure=3
    Environment:
      K8S_NODE_NAME:                                             (v1:spec.nodeName)
      K8S_POD_NAME:                                             red-card-watch-dog-5f8c68977f-v7gbh (v1:metadata.name)
      ASPNETCORE_ENVIRONMENT:                                   Production
      ASPNETCORE_Logging__GELF__AdditionalFields__environment:  Production
      ASPNETCORE_Logging__GELF__AdditionalFields__namespace:    red-card-watch-dog-prod
      DEPLOYMENT_DATACENTER:                                    Plano
      DEPLOYMENT_TIME:                                          Thu, 07 Sep 2023 00:00:53 +0000
      DOTNET_ENVIRONMENT:                                       Production
      DOTNET_Logging__GELF__AdditionalFields__environment:      Production
      DOTNET_Logging__GELF__AdditionalFields__namespace:        red-card-watch-dog-prod
      RELEASE_COMMIT_SHA:                                       f420006add243a290054843b1f98af69270c683d
      RELEASE_TAG:                                              v0.1.2
    Mounts:
      /app/appsettings.secure.json from red-card-watch-dog-appsettings-secure-json (ro,path="appsettings.secure.json")
      /opt/watchdog/crushftp from red-card-watch-dog-crushftp-volume (rw)
      /opt/watchdog/ftp_temp from red-card-watch-dog-ftp-temp-volume (rw)
      /opt/watchdog/redcardreports from red-card-watch-dog-redcardreports-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-hq6b7 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  red-card-watch-dog-appsettings-secure-json:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  red-card-watch-dog-appsettings-secure-json
    Optional:    false
  red-card-watch-dog-crushftp-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  red-card-watch-dog-crushftp
    ReadOnly:   false
  red-card-watch-dog-ftp-temp-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  red-card-watch-dog-ftp-temp
    ReadOnly:   false
  red-card-watch-dog-redcardreports-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  red-card-watch-dog-redcardreports
    ReadOnly:   false
  kube-api-access-hq6b7:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason       Age    From               Message
  ----     ------       ----   ----               -------
  Normal   Scheduled    4m25s  default-scheduler  Successfully assigned red-card-watch-dog-prod/red-card-watch-dog-5f8c68977f-v7gbh to 9af3d3fd-68df-4d13-ac95-c760af36d20b
  Warning  FailedMount  2m23s  kubelet            Unable to attach or mount volumes: unmounted volumes=[red-card-watch-dog-crushftp-volume], unattached volumes=[red-card-watch-dog-crushftp-volume red-card-watch-dog-ftp-temp-volume red-card-watch-dog-redcardreports-volume kube-api-access-hq6b7 red-card-watch-dog-appsettings-secure-json]: timed out waiting for the condition
  Warning  FailedMount  5s     kubelet            Unable to attach or mount volumes: unmounted volumes=[red-card-watch-dog-crushftp-volume], unattached volumes=[red-card-watch-dog-ftp-temp-volume red-card-watch-dog-redcardreports-volume kube-api-access-hq6b7 red-card-watch-dog-appsettings-secure-json red-card-watch-dog-crushftp-volume]: timed out waiting for the condition
