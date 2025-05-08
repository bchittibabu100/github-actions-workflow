Here is the content of values.yaml

chart:
  virtual:
    charts:
      - remittance-partner-network
    shared:
      generate:
        deployment: true
        service: true
        ingress: false
        secret: true
        configmap: true
      image:
        registry: docker.repo1.hello.com/vpay-docker
        tag: latest
        pullPolicy: Always

global:
  environment:
    name: dev

rpn-api:
  enabled: true
  resources:
    requests:
      cpu: 1000m
      memory: 2560Mi
    limits:
      cpu: 1000m
      memory: 2560Mi
  listeningPort: 8080
  probes:
    readiness:
      endpoint: /actuator/health
    livesness:
      endpoint: /actuator/health
  image:
    name: optum/opay-remittance-partner-network
  configMaps:
    configmap:
      mount: false
      type: raw
      data: |
        remittance-configs.partner.serviceEndpoint: "one"
        remittance-configs.partner.sendIndicator: "two"
        remittance-configs.partner.b2bSendIndicator: "three"
        remittance-configs.partner.clientKey: "four"
        remittance-configs.partner.clientKeyValue: "five"
        remittance-configs.partner.clientSecretKey: "six"
        remittance-configs.partner.clientSecretKeyValue: "seven"
        remittance-configs.partner.clientApiKey: "eight"
        remittance-configs.partner.clientAuthEndpoint: "nine"
        remittance-configs.partner.scopeValue: "ten"
  env:
    NODE_ENV: '{{ .Values.global.environment.name | lower }}'
    server_environment: '{{ .Values.global.environment.name }}'
    graylog_level: 'debug'
    winston_silent_console: 'false'
    graylog_handle_exceptions: 'true'
    graylog_facility: remittance-partner-network
    graylog_servers: '[{"host": "nonprod-syslog.vpayusa.net", "port": 5555}]'
    injectedVars: |
      - name: PARTNER_SERVICEENDPOINT
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.serviceEndpoint
      - name: PARTNER_SEND_INDICATOR
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.sendIndicator
      - name: PARTNER_B2B_SEND_INDICATOR
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.b2bSendIndicator
      - name: PARTNER_CLIENTKEY
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.clientKey
      - name: PARTNER_CLIENTKEYVALUE
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.clientKeyValue
      - name: PARTNER_CLIENTSECRETKEY
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.clientSecretKey
      - name: PARTNER_CLIENTSECRETKEYVALUE
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.clientSecretKeyValue
      - name: PARTNER_CLIENTAPIKEY
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.clientApiKey
      - name: PARTNER_CLIENTAUTHENDPOINT
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.clientAuthEndpoint
      - name: PARTNER_SCOPEVALUE
        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.scopeValue
