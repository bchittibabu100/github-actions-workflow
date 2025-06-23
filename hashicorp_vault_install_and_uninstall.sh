nfsShares:
  eft-upload-rw-share:
    server: plprdlnfs22.test.net
    path: /nfsshare/nfsvol01/eft-upload
    capacity: 5000Gi
    enabled: true
  eft-submit-rw-share:
    enabled: false
  bogner-rw-share:
    enabled: false

smbShares:
  bogner-rw:
    enabled: true
  dcrushftp-rw:
    enabled: true
    source: //plprdwsmb03.test.net/scrushftp
    username: <replaced in vault>
    password: <replaced in vault>

eftfeepull-api:
  replicas: 1
  mountNfs:
    eft-upload-rw-share:
      - mount: true
        path: /SRVFS/eft-upload
    eft-submit-rw-share: []  # disable or omit this if not needed
    bogner-rw-share: []       # disabled anyway
  mountSmb:
    bogner-rw:
      - path: /SRVFS/bogner/uploadFiles/VPFEE
        volumeSubPath: uploadFiles/VPFEE
    dcrushftp-rw:
      - mount: true
        path: /SRVFS/vpfee-inbound
        volumeSubPath: vpfee/vpfee/inbound
