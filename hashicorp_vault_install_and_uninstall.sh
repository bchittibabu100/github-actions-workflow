Here is the pv manifest

apiVersion: v1
kind: PersistentVolume
metadata:
  annotations:
    meta.helm.sh/release-name: eftfeepull
    meta.helm.sh/release-namespace: eftfeepull-smb-test
  finalizers:
  - kubernetes.io/pv-protection
  labels:
    app: eftfeepull-eftfeepull-api-production
    app.kubernetes.io/cluster-domain: prod.pks.test.net
    app.kubernetes.io/instance: eftfeepull-eftfeepull-api
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: eftfeepull-api
    app.kubernetes.io/part-of: eftfeepull-api
    app.vpayusa.com/smb-name: eftfeepull-smb-test
    app.vpayusa.com/type: smb-server
    helm.sh/chart: eftfeepull-api-0.0.1
  name: eftfeepull-smb-test
spec:
  accessModes:
  - ReadWriteMany
  capacity:
    storage: 5000Gi
  claimRef:
    apiVersion: v1
    kind: PersistentVolumeClaim
    name: eftfeepull-pvc-test
    namespace: eftfeepull-smb-test
  csi:
    driver: smb.csi.k8s.io
    nodeStageSecretRef:
      name: eftfeepull-api-bogner-rw
      namespace: eftfeepull-smb-test
    volumeAttributes:
      source: //plprdwsmb03.test.net/scrushftp
    volumeHandle: eftfeepull-api-bogner-rw-v1
  mountOptions:
  - dir_mode=0777
  - file_mode=0777
  - vers=3.0
  - noperm
  - mfsymlinks
  persistentVolumeReclaimPolicy: Retain
  storageClassName: smb
  volumeMode: Filesystem
  
  
Here is the pvc manifest

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    meta.helm.sh/release-name: eftfeepull-pvc-test
    meta.helm.sh/release-namespace: eftfeepull-test-crushftp
  finalizers:
  - kubernetes.io/pvc-protection
  labels:
    app: eftfeepull-eftfeepull-api-production
    app.kubernetes.io/cluster-domain: prod.pks.test.net
    app.kubernetes.io/instance: eftfeepull-smb-test
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: eftfeepull-api
    app.kubernetes.io/part-of: eftfeepull-api
    app.vpayusa.com/smb-name: eftfeepull-smb-test
    app.vpayusa.com/type: smb-server
    helm.sh/chart: eftfeepull-api-0.0.1
  name: eftfeepull-pvc-test
  namespace: eftfeepull-test-crushftp
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 5000Gi
  selector:
    matchLabels:
      app.vpayusa.com/smb-name: eftfeepull-api-eft-submit-rw-share
      app.vpayusa.com/type: smb-server
  storageClassName: smb
  volumeMode: Filesystem
  volumeName: eftfeepull-smb-test
  
Here is the events of pvc
12s         Warning   FailedBinding   persistentvolumeclaim/eftfeepull-pvc-test                  volume "eftfeepull-smb-test" already bound to a different claim.
