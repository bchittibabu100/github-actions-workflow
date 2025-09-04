cat _labels.tpl

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



cat _podmetaspec.tpl 

{{- define "vpay.podmetaspec.tpl" -}}

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

metadata:
  labels: {{ include "vpay.labels.standard" . | nindent 4 }}
{{- if (or .Values.secretEnv $hasMountedSecrets $hasMountedConfigMaps) }}
  annotations:
  {{- if (.Values.secretEnv) }}
    {{ include "vpay.secret.secretEnv.checksums" . | indent 4 | trim }}
  {{- end }}
  {{- if $hasMountedSecrets }}
    {{ include "vpay.secret.checksums" . | indent 4 | trim }}
  {{- end }}
  {{- if $hasMountedConfigMaps }}
    {{ include "vpay.configmap.checksums" . | indent 4 | trim }}
  {{- end }}
{{- end }}
spec:
  containers:
    - {{ include "vpay.container.tpl" . | indent 6 | trim }}
      {{- range $key, $val := default (dict) .Values.sidecar }}
      {{- $r := deepCopy $ }}
      {{- $portName := printf "%s-port" $key -}}
      {{- $_ := unset (unset (unset (unset (unset $r.Values "resources") "secretEnv") "serviceExposePort") "listeningPort") "probes" -}}
      {{- if (.secretEnv) }}
        {{- fail "secretEnv can only be set on the primary container; it is not currently supported in sidecar containers." }}
      {{- end }}
      {{- $_ := mergeOverwrite $r (set (dict) "Values" (set (set . "portName" $portName) "containerName" $key)) }}
    - {{ include "vpay.container.tpl" $r | indent 6 | trim }}
      {{- end }}
  {{- if (dig "experimentalFeatures" "podAntiAffinity" "enabled" (true) .Values) }}
  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
        - weight: 100
          podAffinityTerm:
            labelSelector:
              matchExpressions:
                - key: "app.kubernetes.io/name"
                  operator: In
                  values:
                    - {{ template "vpay.name" . }}
                - key: "app.kubernetes.io/instance"
                  operator: In
                  values:
                    - {{ template "vpay.name.full" . }}
            topologyKey: "kubernetes.io/hostname"
  {{- end }}
  {{- if .hasMountedVolumes }}
  volumes:
    {{- if (include "vpay.util.anymounted.secret" .Values.secrets) }}
      {{- include "vpay.secret.volumes" . | trim | nindent 4 }}
    {{- end }}
    {{- if (include "vpay.util.anymounted.secret" .Values.configMaps) }}
      {{- include "vpay.configmap.volumes" . | trim | nindent 4 }}
    {{- end }}
    {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountNfs "shares" $.__GlobalValues.nfsShares)) }}
      {{- include "vpay.pvc.nfs.volumes" . | trim | nindent 4 }}
    {{- end }}
    {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountSmb "shares" $.__GlobalValues.smbShares)) }}
      {{- include "vpay.pvc.smb.volumes" . | trim | nindent 4 }}
    {{- end }}
    {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountEmptyDir "shares" (dict))) }}
      {{- include "vpay.emptyDir.volumes" . | trim | nindent 4 }}
    {{- end }}
    {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountPersistentVolumeClaims "shares" (dict))) }}
      {{- include "vpay.pvc-raw.volumes" . | trim | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if .Values.serviceAccountName }}
  serviceAccountName: {{ .Values.serviceAccountName }}
  {{- end }}
  {{- if not (eq (.Values.podActiveDeadlineSeconds | toString) "<nil>") }}
  activeDeadlineSeconds: {{ int .Values.podActiveDeadlineSeconds }}
  {{- end }}
  {{- if not (eq (.Values.restartPolicy | toString) "<nil>") }}
  restartPolicy: {{ .Values.restartPolicy }}
  {{- end }}
  {{- if not (eq (.Values.terminationGracePeriodSeconds | toString) "<nil>") }}
  terminationGracePeriodSeconds: {{ int .Values.terminationGracePeriodSeconds }}
  {{- end }}

{{- end -}}
