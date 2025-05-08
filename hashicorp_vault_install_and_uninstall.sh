here is the deployment.tpl file for reference.

test@plinfldops02 ~/defaul_helm_templates/helm-gen/templates $ cat _deployment.tpl
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
