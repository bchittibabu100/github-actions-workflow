test@plinfldops02 ~/defaul_helm_templates/helm-gen/templates $ cat _configmap.tpl
{{- define "vpay.configmap.tpl" -}}
{{ template "vpay.metadata" (set . "suffix" (include "vpay.configmap.name.suffix" .)) }}
data: {}
{{- end -}}

{{- define "vpay.configmap" -}}
{{- template "vpay.util.merge" (append . "vpay.configmap.tpl") -}}
{{- end -}}

{{- /* Parameters: .name for suffix */ -}}
{{- define "vpay.configmap.name" -}}
  {{- $base := include "vpay.name" . -}}
  {{- $suf := include "vpay.configmap.name.suffix" . -}}
  {{- printf "%s-%s" $base $suf -}}
{{- end -}}

{{- define "vpay.configmap.name.suffix" -}}
  {{- .name | replace "." "-" | replace "_" "-" | lower -}}
{{- end -}}

{{- define "vpay.configmap.iterate" -}}
  {{- range $key, $_ := .Values.configMaps -}}
    {{- if (include "vpay.util.trueenabled" .mount) -}}
    {{- $r := deepCopy $ -}}
    {{- $_ := merge $r (set . "name" $key) }}
{{ include $.template $r }}
    {{- end -}}
  {{- end -}}
{{- end -}}



{{- define "vpay.configmap.checksums.tpl" -}}
{{ template "vpay.checksum" (set . "name" .name) }}
{{- end -}}
{{- define  "vpay.configmap.checksums" -}}
{{ include "vpay.configmap.iterate" (set . "template" "vpay.configmap.checksums.tpl") }}
{{- end -}}



{{- define "vpay.configmap.volumes.tpl" -}}
- {{ include "vpay.volume.configmap" . | indent 2 | trim }}
{{- end -}}
{{- define  "vpay.configmap.volumes" -}}
{{ include "vpay.configmap.iterate" (set . "template" "vpay.configmap.volumes.tpl") }}
{{- end -}}

{{- define "vpay.configmap.volumeMounts.tpl" -}}
- {{ include "vpay.volume.mount.configmap" . | indent 2 | trim }}
{{- end -}}
{{- define  "vpay.configmap.volumeMounts" -}}
{{ include "vpay.configmap.iterate" (set . "template" "vpay.configmap.volumeMounts.tpl") }}
{{- end -}}



{{- define "vpay.configmap.filemount.tpl" -}}
  {{- range $key, $_ := .Values.configMaps }}
---
apiVersion: v1
kind: ConfigMap
    {{- $r := deepCopy $ }}
    {{- $_ := merge $r (set . "name" $key) }}
{{ template "vpay.configmap" (list $r "vpay.configmap.filemount") -}}
  {{- end -}}
{{- end -}}

{{- define "vpay.configmap.filemount" -}}
data:
  {{ .name }}: |
{{- if (eq (default ("json") .type) "json") }}
  {{- (toPrettyJson .data) | nindent 4 }}
{{- else if (eq .type "raw") }}
  {{- (.data) | nindent 4 }}
{{- else }}
  {{- $failMsg := printf "Unknown configMap type: %s" .type -}}
  {{- fail $failMsg -}}
{{- end }}
{{- end -}}
