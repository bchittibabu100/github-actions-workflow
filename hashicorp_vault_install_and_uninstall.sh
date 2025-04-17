mo066inflrun01 helm-gen # cat templates/_bootstrap.tpl
{{- define "vpay.bootstrap" -}}
  {{- include "vpay.bootstrap.apphost" . }}
  {{- include "vpay.bootstrap.service" . }}
  {{- include "vpay.bootstrap.ingress" . }}
  {{- include "vpay.bootstrap.secret.opaque" . }}
  {{- include "vpay.bootstrap.secret.tls" . }}
  {{- include "vpay.bootstrap.configmap.filemount" . }}
  {{- include "vpay.bootstrap.pv.nfs" . }}
  {{- include "vpay.bootstrap.pvc.nfs" . }}
  {{- include "vpay.bootstrap.pv.smb" . }}
  {{- include "vpay.bootstrap.pvc.smb" . }}
  {{- include "vpay.bootstrap.secret.smb" . }}
{{- end -}}

{{- define "vpay.bootstrap.apphost" -}}
{{- $dataVirtualize := (set . "template" "vpay.apphost.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "deployment")}}
{{- end -}}

{{- define "vpay.bootstrap.ingress" -}}
{{- $dataVirtualize := (set . "template" "vpay.ingress.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "ingress")}}
{{- end -}}

{{- define "vpay.bootstrap.secret.tls" -}}
{{- $dataVirtualize := (set . "template" "vpay.secret.tls.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "secret")}}
{{- end -}}

{{- define "vpay.bootstrap.secret.opaque" -}}
{{- $dataVirtualize := (set . "template" "vpay.secret.opaque.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "secret")}}
{{- end -}}

{{- define "vpay.bootstrap.secret.smb" -}}
{{ include "vpay.secret.smb.basicAuth.tpl" .}}
{{- end -}}

{{- define "vpay.bootstrap.configmap.filemount" -}}
{{- $dataVirtualize := (set . "template" "vpay.configmap.filemount.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "configmap")}}
{{- end -}}

{{- define "vpay.bootstrap.service" -}}
{{- $dataVirtualize := (set . "template" "vpay.service.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "service") }}
{{- end -}}

{{- define "vpay.bootstrap.pv.nfs" -}}
{{ include "vpay.pv.nfs.tpl" . }}
{{- end -}}

{{- define "vpay.bootstrap.pvc.nfs" -}}
{{ include "vpay.pvc.nfs.tpl" . }}
{{- end -}}

{{- define "vpay.bootstrap.pv.smb" -}}
{{ include "vpay.pv.smb.tpl" . }}
{{- end -}}

{{- define "vpay.bootstrap.pvc.smb" -}}
{{ include "vpay.pvc.smb.tpl" . }}
{{- end -}}
mo066inflrun01 helm-gen #
mo066inflrun01 helm-gen # cat templates/_apphost.tpl


{{- define "vpay.apphost.tpl" -}}
  {{- if (include "vpay.util.trueenabled" .Values.enabled) -}}

  {{- $hasMountedSecrets := false -}}
  {{- range $key, $value := default (dict) .Values.secrets -}}
    {{- if (include "vpay.util.trueenabled" $value.mount) -}}
      {{- $hasMountedSecrets = true -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedConfigMaps := false -}}
  {{- range $key, $value := default (dict) .Values.configMaps -}}
    {{- if (include "vpay.util.trueenabled" $value.mount) -}}
      {{- $hasMountedConfigMaps = true -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedNfs := false -}}
  {{- range $key, $value := default (dict) .Values.mountNfs -}}
    {{- if (not (dig $key ("") (default (dict) $.__GlobalValues.nfsShares))) -}}
      {{- fail (printf "nfsMounts key does not exist for mountNfs mount with name \"%s\"" $key) }}
    {{- end -}}
    {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $.__GlobalValues.nfsShares))) }}
      {{- range $volumeMount := default (list) $value -}}
        {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
          {{- $hasMountedNfs = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedSmb := false -}}
  {{- range $key, $value := default (dict) .Values.mountSmb -}}
    {{- if (not (dig $key ("") (default (dict) $.__GlobalValues.smbShares))) -}}
      {{- fail (printf "nfsMounts key does not exist for mountSmb mount with name \"%s\"" $key) }}
    {{- end -}}
    {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $.__GlobalValues.smbShares))) }}
      {{- range $volumeMount := default (list) $value -}}
        {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
          {{- $hasMountedSmb = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedEmptyDir := false -}}
  {{- range $key, $value := default (dict) .Values.mountEmptyDir -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
        {{- $hasMountedEmptyDir = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedPvc := false -}}
  {{- range $key, $value := default (dict) .Values.mountPersistentVolumeClaims -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
        {{- $hasMountedPvc = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $_ := set . "hasMountedVolumes" (or $hasMountedSecrets $hasMountedConfigMaps $hasMountedNfs $hasMountedSmb $hasMountedEmptyDir $hasMountedPvc) }}

  {{- $appKind := default ("Deployment") .Values.kind -}}

  {{- if (eq $appKind "Deployment") -}}
    {{- include "vpay.deployment.tpl" $ -}}
  {{- else if (eq $appKind "CronJob") -}}
    {{- include "vpay.cronjob.tpl" $ -}}
  {{- else -}}
    {{- $failMsg := printf "Unknown application host kind: %s" $appKind -}}
    {{- fail $failMsg -}}
  {{- end -}}

  {{- if (.Values.secretEnv) }}
    {{- include "vpay.secret.secretEnv.tpl" $ }}
  {{- end }}

  {{- end -}}
{{- end -}}
mo066inflrun01 helm-gen # cat templates/_deployment.tpl
{{- define "vpay.deployment.tpl" }}
---
apiVersion: apps/v1
kind: Deployment
{{ template "vpay.metadata" . }}
spec:
  revisionHistoryLimit: {{ default (4) .Values.revisionHistoryLimit }}
  {{- if (dig "experimentalFeatures" "omitReplicaCount" "enabled" (false) .Values) }}
    {{- if (.Values.replicas) }}
      {{- fail "When 'omitReplicaCount' is enabled, you can't provide '.Values.replicas'" }}
    {{- end }}
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: {{ default ("100%") .Values.maxSurge }}
      maxUnavailable: {{ default ("0%") .Values.maxUnavailable }}
  {{- else }}
    {{- $replicas := ternary (1) (default (0) (int .Values.replicas)) (eq (.Values.replicas | toString) "<nil>") }}
    {{- $maxSurge := ternary "100%" "50%" (eq $replicas 1) }}
    {{- $maxUnavailable := ternary "0%" "50%" (eq $replicas 1) }}
  replicas: {{ $replicas }}
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: {{ default ($maxSurge) .Values.maxSurge }}
      maxUnavailable: {{ default ($maxUnavailable) .Values.maxUnavailable }}
  {{- end }}
  selector:
    matchLabels:
      {{ template "vpay.labels.name" . }}
      {{ template "vpay.labels.instance" . }}
  template:
    {{ include "vpay.podmetaspec.tpl" $ | indent 4 | trim }}

  {{- if (dig "experimentalFeatures" "horizontalPodAutoscaler" "enabled" (false) .Values) }}
    {{- include "vpay.horizontalpodautoscaler.tpl" . }}
  {{- end }}
{{- end -}}
mo066inflrun01 helm-gen # cat templates/_metadata.tpl
{{- /*
Creates a standard metadata header with name and labels.
A suffix can be passed in to adjust the name.
*/ -}}
{{- define "vpay.metadata" -}}
  {{- $base := include "vpay.name" . -}}
  {{- $suf := default "" .suffix -}}
  {{- $name := printf "%s-%s" $base $suf -}}
metadata:
  name: {{ $name | lower | trimSuffix "-" }}
  labels: {{ include "vpay.labels.standard" . | nindent 4 -}}
{{- end -}}
mo066inflrun01 helm-gen # cat templates/_labels.tpl
{{- define "vpay.labels.standard" -}}
{{ template "vpay.labels.app" . }}
{{ template "vpay.labels.name" . }}
{{ template "vpay.labels.instance" . }}
{{ template "vpay.labels.partof" . }}
{{ template "vpay.labels.chart" . }}
{{ template "vpay.labels.managed-by" . }}
{{ template "vpay.labels.cluster-domain" . }}
{{- end -}}

{{- define "vpay.labels.app" -}}
  {{- $fullname := include "vpay.name.full" . -}}
  {{- $environment := include "vpay.environment.name" . -}}
app: {{ printf "%s-%s" $fullname $environment | lower | trimAll "-" }}
{{- end -}}

{{- define "vpay.labels.name" -}}
app.kubernetes.io/name: {{ template "vpay.name" . }}
{{- end -}}

{{- define "vpay.labels.instance" -}}
app.kubernetes.io/instance: {{ include "vpay.name.full" . }}
{{- end -}}

{{- define "vpay.labels.partof" -}}
  {{- $gpre := include "vpay.optional.global.prefix" . -}}
  {{- $name := include "vpay.name" . -}}
app.kubernetes.io/part-of: {{ default $name $gpre }}
{{- end -}}

{{- define "vpay.labels.chart" -}}
  {{- $gpre := include "vpay.optional.global.prefix" . -}}
  {{- $base := printf "%s-%s" .Chart.Name .Chart.Version -}}
helm.sh/chart: {{ printf "%s-%s" $gpre $base | lower | trimAll "-" }}
{{- end -}}

{{- define "vpay.labels.managed-by" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "vpay.labels.cluster-domain" -}}
app.kubernetes.io/cluster-domain: {{ template "vpay.environment.ingressSubdomain" . }}
{{- end -}}
mo066inflrun01 helm-gen #
