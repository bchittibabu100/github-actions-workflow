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
  labels:
    {{ include "vpay.labels.standard" . | nindent 4 }}
    {{- with .Values.podLabels }}
    {{ toYaml . | nindent 4 }}
    {{- end }}

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
    {{- with .Values.podAnnotations }}
    {{ toYaml . | nindent 4 }}
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
