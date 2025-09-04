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
    DD_LOGS_INJECTION: "true"

  podAnnotations:
    admission.datadoghq.com/dotnet-lib.version: v3.24.1

  podLabels:
    admission.datadoghq.com/enabled: "true"

  # ➕ Init containers
  initContainers:
    - name: init-wait-for-db
      image: busybox:1.36
      command: ['sh', '-c', 'until nc -z db-service 5432; do echo waiting for db; sleep 2; done;']
    - name: init-permissions
      image: alpine:3.20
      command: ['sh', '-c', 'chown -R 1000:1000 /app/data']
      volumeMounts:
        - name: app-data
          mountPath: /app/data
