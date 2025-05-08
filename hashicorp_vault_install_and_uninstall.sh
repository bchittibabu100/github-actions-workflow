I structured like this but it failing to parse.

Error: cannot load values.yaml: error converting YAML to JSON: yaml: line 60: did not find expected key

  env:
    NODE_ENV: '{{ .Values.global.environment.name | lower }}'
    server_environment: '{{ .Values.global.environment.name }}'
    graylog_level: 'debug'
    winston_silent_console: 'false'
    graylog_handle_exceptions: 'true'
    graylog_facility: remittance-partner-network
    graylog_servers: '[{"host": "nonprod-syslog.vpayusa.net", "port": 5555}]'
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
