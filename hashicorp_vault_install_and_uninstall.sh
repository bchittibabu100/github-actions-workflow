Here is the deployment template.

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

Here is the values file
chart:
  virtual:
    charts:
      - remittance-partner-network
    shared:
      generate:
        deployment: true
        service: true
        ingress: true
        secret: true
        configmap: true
      image:
        registry: docker.repo1.uhc.com/vpay-docker
        tag: latest
        pullPolicy: Always

global:
  environment:
    name: dev
    ingress:
      subdomain: dev.pks.vpayusa.net
      
remittance-partner-network:
  replicas: 1
  enabled: true
  contentRoot: /app
  image:
    name: optum/opay-remittance-partner-network
  listeningPort: 8080
  probes:
    readiness:
      endpoint: /actuator/health
    liveness:
      endpoint: /actuator/health
  resources:
    requests:
      cpu: 1000m
      memory: 2560Mi
    limits:
      cpu: 1000m
      memory: 2560Mi
  secrets:
    appsettings.secure.json:
      mount: true
      data:
        b2bSendIndicator:
          PARTNER_B2B_SEND_INDICATOR: ["salucro=false", "patientpay=true"]
        clientAuthEndpoint:
          PARTNER_CLIENTAUTHENDPOINT: ["salucro=https://cognito.salucro-qa.net/oauth2/token", "patientpay=https://optum-dev.patientpay.net/token"]
        clientKey:
          PARTNER_CLIENTKEY: ["salucro=client_id", "patientpay=client_id"]
        clientSecretKey:
          PARTNER_CLIENTSECRETKEY: ["salucro=client_secret", "patientpay=client_secret"]
        scopeValue:
          PARTNER_SCOPEVALUE: ["salucro=app/vcard_stp.api.vpay", "patientpay=openid"]
        sendIndicator:
          PARTNER_SEND_INDICATOR: ["salucro=true", "patientpay=true"]
        serviceEndpoint:
          PARTNER_SERVICEENDPOINT: ["salucro=https://pti-api.salucro-qa.net/vcard/vpay/c2b", "patientpay=https://optum-dev.patientpay.net/transaction"]
  env:
    graylog_level: debug
    winston_silent_console: 'false'
    graylog_handle_exceptions: 'true'
    graylog_facility: remittance-partner-network
    graylog_servers: "nonprod-syslog.vpayusa.net"

give me udpated values file to have datadog related annotation, label and env's
