Wanted to have have env section inside container like below then how should be the entries defined inside values.yaml ?

  env:
    - name: graylog_level
      value: 'debug'
    - name: winston_silent_console
      value: 'false'
    - name: graylog_handle_exceptions
      value: 'true'
    - name: graylog_facility
      value: remittance-partner-network
    - name: graylog_servers
      value: '[{"host": "nonprod-syslog.vpayusa.net", "port": 5555}]'
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
