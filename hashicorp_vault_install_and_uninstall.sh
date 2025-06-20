1. Here is the pv template as part of the helm chart.
{{- define "vpay.pv.nfs" }}
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ template "vpay.pv.name" . }}
  labels: {{- include "vpay.labels.standard" . | nindent 4 }}
    app.vpayusa.com/type: nfs-server
    app.vpayusa.com/nfs-name: {{ template "vpay.pv.name" . }}
  {{- if (.helmResourcePolicy) }}
  annotations:
    "helm.sh/resource-policy": {{ .helmResourcePolicy }}
  {{- end }}
spec:
  accessModes:
    - {{ (default (false) .readOnly) | ternary "ReadOnlyMany" "ReadWriteMany" }}
  storageClassName: nfs
  mountOptions:
    - hard
    - timeo=50
    - retrans=2
    - sec=sys
    - {{ (default (false) .readOnly) | ternary "ro" "rw" }}
    {{- if (default (false) .legacy) }}
    - noresvport
    - async
    {{- end }}
  capacity:
    storage: {{ required (printf "No capacity specified for NFS share %s" .name) .capacity }}
  nfs:
    server: {{ (required (printf "No server specified for NFS share %s" .name) .server) | quote }}
    path: {{ (required (printf "No path specified for NFS share %s" .name) .path) | quote }}
    readOnly: {{ default (false) .readOnly }}
{{- end -}}

{{- define "vpay.pv.smb" -}}
{{- $readOnly := default (false) .readOnly }}
---
apiVersion: v1
kind: PersistentVolume
metadata:
{{- $r := deepCopy . }}
  name: {{ template "vpay.pv.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
  labels: {{ include "vpay.labels.standard" . | nindent 4 }}
    app.vpayusa.com/type: smb-server
    app.vpayusa.com/smb-name: {{ template "vpay.pv.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
  {{- if (.helmResourcePolicy) }}
  annotations:
    "helm.sh/resource-policy": {{ .helmResourcePolicy }}
  {{- end }}
spec:
  capacity:
    storage: 500Gi
  accessModes:
    - {{ $readOnly | ternary "ReadOnlyMany" "ReadWriteMany" }}
  storageClassName: smb
  persistentVolumeReclaimPolicy: Retain
  mountOptions:
  {{- if (default (false) .anonymous) }}
    - guest
    - sec=none
  {{- end }}
    - dir_mode=0777
    - file_mode=0777
    - vers=3.0
    - noperm
    - mfsymlinks
  csi:
    driver: smb.csi.k8s.io
    readOnly: {{ $readOnly }}
    volumeHandle: {{ template "vpay.pv.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
    volumeAttributes:
      source: {{ required (printf "No source specified for SMB share %s" .name) .source | quote }}
    nodeStageSecretRef:
      name: {{ template "vpay.name" . }}-{{ .name }}
      namespace: {{ .Release.Namespace }}
{{- end -}}

{{- define "vpay.pv.nfs.tpl" -}}
  {{- range $key, $val := .Values.nfsShares }}
    {{- $r := deepCopy $ }}
  {{- if (include "vpay.util.trueenabled" $val.enabled) -}}
    {{- $_ := merge $r (set . "name" $key) }}
{{ template "vpay.pv.nfs" $r -}}
  {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "vpay.pv.smb.tpl" -}}
  {{- range $key, $val := .Values.smbShares }}
    {{- $r := deepCopy $ }}
    {{- $_ := merge $r (set . "name" $key) }}
  {{- if (include "vpay.util.trueenabled" $val.enabled) }}
{{ template "vpay.pv.smb" $r -}}
  {{- end -}}
  {{- end -}}
{{- end -}}


{{- define "vpay.pv.name" -}}
  {{- $base := include "vpay.name.global" . -}}
  {{- $suf := default "" .name -}}
  {{- $name := (printf "%s-%s" $base $suf) | lower | trimSuffix "-" -}}
  {{- $name -}}
{{- end -}}


2. Here is the pvc template as part of helm-chart
{{- define "vpay.pvc.nfs" }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ template "vpay.pvc.name" . }}
  labels: {{- include "vpay.labels.standard" . | nindent 4 }}
    app.vpayusa.com/type: nfs-server
    app.vpayusa.com/nfs-name: {{ template "vpay.pvc.name" . }}
  {{- if (.helmResourcePolicy) }}
  annotations:
    "helm.sh/resource-policy": {{ .helmResourcePolicy }}
  {{- end }}
spec:
  accessModes:
    - {{ (default (false) .readOnly) | ternary "ReadOnlyMany" "ReadWriteMany" }}
  storageClassName: nfs
  selector:
    matchLabels:
      app.vpayusa.com/type: nfs-server
      app.vpayusa.com/nfs-name: {{ template "vpay.pvc.name" . }}
  resources:
    requests:
      storage: {{ required (printf "No capacity specified for NFS share %s" .name) .capacity }}
{{- end -}}

{{- define "vpay.pvc.smb" }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
{{- $r := deepCopy . }}
  name: {{ template "vpay.pvc.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
  labels: {{- include "vpay.labels.standard" . | nindent 4 }}
    app.vpayusa.com/type: smb-server
    app.vpayusa.com/smb-name: {{ template "vpay.pvc.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
  {{- if (.helmResourcePolicy) }}
  annotations:
    "helm.sh/resource-policy": {{ .helmResourcePolicy }}
  {{- end }}
spec:
  accessModes:
    - {{ (default (false) .readOnly) | ternary "ReadOnlyMany" "ReadWriteMany" }}
  selector:
    matchLabels:
      app.vpayusa.com/type: smb-server
      app.vpayusa.com/smb-name: {{ template "vpay.pvc.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
  resources:
    requests:
      storage: 10Gi
  volumeName: {{ template "vpay.pvc.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
  storageClassName: smb
{{- end -}}

{{- define "vpay.pvc.nfs.tpl" -}}
  {{- range $key, $val := .Values.nfsShares }}
    {{- $r := deepCopy $ }}
    {{- $_ := merge $r (set . "name" $key) }}
  {{- if (include "vpay.util.trueenabled" $val.enabled) }}
{{ template "vpay.pvc.nfs" $r -}}
  {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "vpay.pvc.smb.tpl" -}}
  {{- range $key, $val := .Values.smbShares }}
    {{- $r := deepCopy $ }}
    {{- $_ := merge $r (set . "name" $key) }}
  {{- if (include "vpay.util.trueenabled" $val.enabled) }}
{{ template "vpay.pvc.smb" $r -}}
  {{- end -}}
  {{- end -}}
{{- end -}}


{{- define "vpay.pvc.name" -}}
  {{- $base := include "vpay.name.global" . -}}
  {{- $suf := default "" .name -}}
  {{- $name := (printf "%s-%s" $base $suf) | lower | trimSuffix "-" -}}
  {{- $name -}}
{{- end -}}



{{- define "vpay.pvc.volume.name" -}}
  {{- $base := include "vpay.name" . -}}
  {{- $suf := include "vpay.pvc.volume.name.suffix" . -}}
  {{- printf "%s-%s-volume" $base $suf -}}
{{- end -}}

{{- define "vpay.pvc.volume.name.suffix" -}}
  {{- .name | replace "." "-" | lower -}}
{{- end -}}



{{- define "vpay.pvc.nfs.volume" -}}
- {{ include "vpay.volume.pvc" . | indent 2 | trim }}
{{- end -}}

{{- define "vpay.pvc.nfs.volumeMount" -}}
- {{ include "vpay.volume.mount.pvc" . | indent 2 | trim }}
{{- end -}}

{{- define  "vpay.pvc.nfs.volumeMounts" -}}
  {{- $shares := $.__GlobalValues.nfsShares -}}
  {{- range $key, $value := default (dict) .Values.mountNfs -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $shares))) -}}
        {{- if (include "vpay.util.trueenabled" .mount) -}}
          {{- $r := deepCopy $ -}}
          {{- $_ := merge $r (set . "name" $key) }}
{{ include "vpay.pvc.nfs.volumeMount" $r }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define  "vpay.pvc.nfs.volumes" -}}
  {{- $shares := $.__GlobalValues.nfsShares -}}
  {{- range $key, $value := default (dict) .Values.mountNfs -}}
    {{- $isMounted := false -}}
    {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $shares))) -}}
      {{- range $volumeMount := default (list) $value -}}
        {{- if (include "vpay.util.trueenabled" .mount) -}}
          {{- $isMounted = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if $isMounted -}}
      {{- $r := deepCopy $ -}}
      {{- $_ := merge $r (set (index . 0) "name" $key) }}
{{ include "vpay.pvc.nfs.volume" $r }}
    {{- end -}}
  {{- end -}}
{{- end -}}



{{- define "vpay.pvc.smb.volume" }}
- name: {{ template "vpay.pvc.volume.name" . }}
  persistentVolumeClaim:
  {{- $r := deepCopy . }}
    claimName: {{ template "vpay.pvc.name" (set $r "name" (printf "%s-%s" .name "v1")) }}
{{- end -}}

{{- define "vpay.pvc.smb.volumeMount" -}}
- {{ include "vpay.volume.mount.pvc" . | indent 2 | trim }}
{{- end -}}

{{- define  "vpay.pvc.smb.volumeMounts" -}}
  {{- $shares := $.__GlobalValues.smbShares -}}
  {{- range $key, $value := default (dict) .Values.mountSmb -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $shares))) -}}
        {{- if (include "vpay.util.trueenabled" .mount) -}}
          {{- $r := deepCopy $ -}}
          {{- $_ := merge $r (set . "name" $key) }}
{{ include "vpay.pvc.smb.volumeMount" $r }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define  "vpay.pvc.smb.volumes" -}}
  {{- $shares := $.__GlobalValues.smbShares -}}
  {{- range $key, $value := default (dict) .Values.mountSmb -}}
    {{- $isMounted := false -}}
    {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $shares))) -}}
      {{- range $volumeMount := default (list) $value -}}
        {{- if (include "vpay.util.trueenabled" .mount) -}}
          {{- $isMounted = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if $isMounted -}}
      {{- $r := deepCopy $ -}}
      {{- $_ := merge $r (set (index . 0) "name" $key) }}
{{ include "vpay.pvc.smb.volume" $r }}
    {{- end -}}
  {{- end -}}
{{- end -}}




{{- define "vpay.emptyDir.volume" -}}
- {{ include "vpay.volume.emptyDir" . | indent 2 | trim }}
{{- end -}}

{{- define "vpay.emptyDir.volumeMount" -}}
- {{ include "vpay.volume.mount.emptyDir" . | indent 2 | trim }}
{{- end -}}

{{- define  "vpay.emptyDir.volumeMounts" -}}
  {{- range $key, $value := default (dict) .Values.mountEmptyDir -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" .mount) -}}
      {{- $r := deepCopy $ -}}
      {{- $_ := merge $r (set . "name" $key) }}
{{ include "vpay.emptyDir.volumeMount" $r }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define  "vpay.emptyDir.volumes" -}}
  {{- range $key, $value := default (dict) .Values.mountEmptyDir -}}
    {{- $isMounted := false -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" .mount) -}}
        {{- $isMounted = true -}}
      {{- end -}}
    {{- end -}}
    {{- if $isMounted -}}
      {{- $r := deepCopy $ -}}
      {{- $_ := merge $r (set (index . 0) "name" $key) }}
{{ include "vpay.emptyDir.volume" $r }}
    {{- end -}}
  {{- end -}}
{{- end -}}



{{- define "vpay.pvc-raw.volume" -}}
- {{ include "vpay.volume.pvc" . | indent 2 | trim }}
{{- end -}}

{{- define "vpay.pvc-raw.volumeMount" -}}
- {{ include "vpay.volume.mount.pvc" . | indent 2 | trim }}
{{- end -}}

{{- define  "vpay.pvc-raw.volumeMounts" -}}
  {{- range $key, $value := default (dict) .Values.mountPersistentVolumeClaims -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" .mount) -}}
      {{- $r := deepCopy $ -}}
      {{- $_ := merge $r (set . "name" $key) }}
{{ include "vpay.pvc-raw.volumeMount" $r }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define  "vpay.pvc-raw.volumes" -}}
  {{- range $key, $value := default (dict) .Values.mountPersistentVolumeClaims -}}
    {{- $isMounted := false -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" .mount) -}}
        {{- $isMounted = true -}}
      {{- end -}}
    {{- end -}}
    {{- if $isMounted -}}
      {{- $r := deepCopy $ -}}
      {{- $_ := merge $r (set (index . 0) "name" $key) }}
{{ include "vpay.pvc-raw.volume" $r }}
    {{- end -}}
  {{- end -}}
{{- end -}}


3. Here is the values.yml file contents
chart:
  virtual:
    shared:
      generate:
        deployment: true
        service: true
        ingress: true
        secret: true
      image:
        registry: plinfharbor.test.net
        tag: latest
        pullPolicy: Always
      env:
        ASPNETCORE_ENVIRONMENT: '{{ .Values.global.environment.name }}'
        DOTNET_ENVIRONMENT: '{{ .Values.global.environment.name }}'
        ASPNETCORE_Logging__GELF__AdditionalFields__environment: '{{ .Values.global.environment.name }}'
        ASPNETCORE_Logging__GELF__AdditionalFields__namespace: '{{ .Release.Namespace }}'
        DOTNET_Logging__GELF__AdditionalFields__environment: '{{ .Values.global.environment.name }}'
        DOTNET_Logging__GELF__AdditionalFields__namespace: '{{ .Release.Namespace }}'
    charts:
      - eftfeepull-api

global:
  environment:
    name: Development
    ingress:
      subdomain: dev.pks.vpayusa.net

nfsShares:
  eft-upload-rw-share:
    server: <replaced in env-specific file>
    path: <replaced in env-specific file>
    capacity: <replaced in env-specific file>
  eft-submit-rw-share:
    server: <replaced in env-specific file>
    path: <replaced in env-specific file>
    capacity: <replaced in env-specific file>
  bogner-rw-share:
    server: <replaced in env-specific file>
    path: <replaced in env-specific file>
    capacity: <replaced in env-specific file>
    # This NFS share is a legacy share in NetApps; need to set mount options to support it
    legacy: true

smbShares:
  bogner-rw:
    enabled: false
    source: <replaced in vault>
    username: <replaced in vault>
    password: <replaced in vault>
  dcrushftp-rw:
    enabled: false
    source: <replaced in vault>
    username: <replaced in vault>
    password: <replaced in vault>

eftfeepull-api:
  enabled: true
  image:
    name: eftfeepull/eftfeepull-api
  listeningPort: 80
  contentRoot: /app
  probes:
    readiness:
      endpoint: /api/about
    liveness:
      endpoint: /api/about
  secrets:
    appsettings.secure.json:
      mount: true
      data: {}
  resources:
    limits:
      memory: "2Gi"
      cpu: "1000m"
    requests:
      memory: "1Gi"
      cpu: "1000m"
  mountNfs:
    eft-upload-rw-share:
      - mount: true
        path: /SRVFS/eft-upload
    eft-submit-rw-share:
      - path: /SRVFS/vpfee-inbound
        volumeSubPath: vpfee/vpfee/inbound # overridden for dev in specific values-dev-<dc>.yaml files
    bogner-rw-share:
      - path: /SRVFS/bogner/uploadFiles/VPFEE
        volumeSubPath: uploadFiles/VPFEE
  mountSmb:
    bogner-rw:
      - path: /SRVFS/bogner/uploadFiles/VPFEE
        volumeSubPath: uploadFiles/VPFEE
    dcrushftp-rw:
      - path: /SRVFS/vpfee-inbound
        volumeSubPath: vpfee/vpfee/inbound 

4. Here the contents of prod-values.yml
nfsShares:
  eft-upload-rw-share:
    server: plprdlnfs22.test.net
    path: /nfsshare/nfsvol01/eft-upload
    capacity: 5000Gi
  eft-submit-rw-share:
    server: plprdxnfs01.test.net
    path: /PROD_FILE_SERVER_NFS_VOL_01/crushftp
    capacity: 5000Gi
    # This NFS share is a legacy share in NetApps; need to set mount options to support it
    legacy: true
    enabled: true
  bogner-rw-share:
    enabled: false

smbShares:
  bogner-rw:
    enabled: true
  dcrushftp-rw:
    enabled: false

eftfeepull-api:
  replicas: 1        

 eft-submit-rw-share nfsShare has been moved to smb from nfs only on prod environment with smb server as "plprdwsmb03.test.net/scrushftp". Now give me updated values files which should change only the prod pv
