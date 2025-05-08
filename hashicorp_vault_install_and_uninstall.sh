env:
  graylog_level: debug
  winston_silent_console: 'false'
  graylog_handle_exceptions: 'true'
  graylog_facility: remittance-partner-network
  graylog_servers: '[{"host": "nonprod-syslog.vpayusa.net", "port": 5555}]'
  PARTNER_SERVICEENDPOINT: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.serviceEndpoint
  PARTNER_SEND_INDICATOR: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.sendIndicator
  PARTNER_B2B_SEND_INDICATOR: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.b2bSendIndicator
  PARTNER_CLIENTKEY: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.clientKey
  PARTNER_CLIENTKEYVALUE: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.clientKeyValue
  PARTNER_CLIENTSECRETKEY: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.clientSecretKey
  PARTNER_CLIENTSECRETKEYVALUE: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.clientSecretKeyValue
  PARTNER_CLIENTAPIKEY: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.clientApiKey
  PARTNER_CLIENTAUTHENDPOINT: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.clientAuthEndpoint
  PARTNER_SCOPEVALUE: |
    {{- printf "" }}
    valueFrom:
      configMapKeyRef:
        name: remittance-partner-network-configmap
        key: remittance-configs.partner.scopeValue
