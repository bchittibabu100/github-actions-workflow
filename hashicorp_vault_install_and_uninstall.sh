cboya1@plinfldops02 ~/crushftp/eftfeepull $ kubectl logs -n kube-system csi-smb-node-5cnfj -c smb
I0601 06:46:13.866991       1 main.go:86] set up prometheus server on 0.0.0.0:29645
I0601 06:46:13.892228       1 smb.go:65]
DRIVER INFORMATION:
-------------------
Build Date: "2021-11-26T08:38:35Z"
Compiler: gc
Driver Name: smb.csi.k8s.io
Driver Version: v1.4.0
Git Commit: 29491ec43ef0af0ce7cbf170656ed68163f123d0
Go Version: go1.16
Platform: linux/amd64

Streaming logs below:
I0601 06:46:13.892582       1 mount_linux.go:192] Detected OS without systemd
I0601 06:46:13.892620       1 driver.go:93] Enabling controller service capability: CREATE_DELETE_VOLUME
I0601 06:46:13.892626       1 driver.go:93] Enabling controller service capability: SINGLE_NODE_MULTI_WRITER
I0601 06:46:13.892638       1 driver.go:112] Enabling volume access mode: SINGLE_NODE_WRITER
I0601 06:46:13.892643       1 driver.go:112] Enabling volume access mode: SINGLE_NODE_READER_ONLY
I0601 06:46:13.892654       1 driver.go:112] Enabling volume access mode: SINGLE_NODE_SINGLE_WRITER
I0601 06:46:13.892659       1 driver.go:112] Enabling volume access mode: SINGLE_NODE_MULTI_WRITER
I0601 06:46:13.892663       1 driver.go:112] Enabling volume access mode: MULTI_NODE_READER_ONLY
I0601 06:46:13.892666       1 driver.go:112] Enabling volume access mode: MULTI_NODE_SINGLE_WRITER
I0601 06:46:13.892670       1 driver.go:112] Enabling volume access mode: MULTI_NODE_MULTI_WRITER
I0601 06:46:13.892674       1 driver.go:103] Enabling node service capability: STAGE_UNSTAGE_VOLUME
I0601 06:46:13.892681       1 driver.go:103] Enabling node service capability: SINGLE_NODE_MULTI_WRITER
I0601 06:46:13.892685       1 driver.go:103] Enabling node service capability: VOLUME_MOUNT_GROUP
I0601 06:46:13.900408       1 server.go:118] Listening for connections on address: &net.UnixAddr{Name:"//csi/csi.sock", Net:"unix"}
I0601 06:46:14.060315       1 utils.go:118] GRPC call: /csi.v1.Identity/GetPluginInfo
I0601 06:46:14.060338       1 utils.go:119] GRPC request: {}
I0601 06:46:14.063910       1 utils.go:125] GRPC response: {"name":"smb.csi.k8s.io","vendor_version":"v1.4.0"}
I0601 06:46:14.416031       1 utils.go:118] GRPC call: /csi.v1.Identity/GetPluginInfo
I0601 06:46:14.416048       1 utils.go:119] GRPC request: {}
I0601 06:46:14.416091       1 utils.go:125] GRPC response: {"name":"smb.csi.k8s.io","vendor_version":"v1.4.0"}
I0601 06:46:15.296090       1 utils.go:118] GRPC call: /csi.v1.Node/NodeGetInfo
I0601 06:46:15.296116       1 utils.go:119] GRPC request: {}
I0601 06:46:15.296299       1 utils.go:125] GRPC response: {"node_id":"9af3d3fd-68df-4d13-ac95-c760af36d20b"}
I0601 06:47:12.562311       1 utils.go:118] GRPC call: /csi.v1.Node/NodePublishVolume
I0601 06:47:12.562338       1 utils.go:119] GRPC request: {"staging_target_path":"/var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount","target_path":"/var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount","volume_capability":{"AccessType":{"Mount":{"mount_flags":["dir_mode=0777","file_mode=0777","vers=3.0","noperm","mfsymlinks"]}},"access_mode":{"mode":5}},"volume_context":{"csi.storage.k8s.io/ephemeral":"false","csi.storage.k8s.io/pod.name":"eftfeepull-api-85bffcdb-kzkcc","csi.storage.k8s.io/pod.namespace":"eftfeepull-prod","csi.storage.k8s.io/pod.uid":"4ed75eee-4284-463b-8759-a4ddc6ec5754","csi.storage.k8s.io/serviceAccount.name":"default","source":"//plprdwsmb03.vpayusa.net/scrushftp"},"volume_id":"PROD_FILE_SERVER_NFS_VOL_01"}
I0601 06:47:12.562679       1 nodeserver.go:85] NodePublishVolume: mounting /var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount at /var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount with mountOptions: [bind] volumeID(PROD_FILE_SERVER_NFS_VOL_01)
I0601 06:47:12.562706       1 mount_linux.go:175] Mounting cmd (mount) with arguments ( -o bind /var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount /var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount)
E0601 06:47:12.564751       1 mount_linux.go:179] Mount failed: exit status 32
Mounting command: mount
Mounting arguments:  -o bind /var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount /var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount
Output: mount: /var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount: special device /var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount does not exist.

E0601 06:47:12.566457       1 utils.go:123] GRPC error: rpc error: code = Internal desc = Could not mount "/var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount" at "/var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount": mount failed: exit status 32
Mounting command: mount
Mounting arguments:  -o bind /var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount /var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount
Output: mount: /var/vcap/data/kubelet/pods/4ed75eee-4284-463b-8759-a4ddc6ec5754/volumes/kubernetes.io~csi/eftfeepull-api-eft-submit-rw-share/mount: special device /var/vcap/data/kubelet/plugins/kubernetes.io/csi/pv/eftfeepull-api-eft-submit-rw-share/globalmount does not exist.
