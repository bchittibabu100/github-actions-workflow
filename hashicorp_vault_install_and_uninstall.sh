why the environment variable name being sent as injectedvars. wanted to have proper key and value combination.

here is the pod yaml output of env section.
   - name: graylog_level
      value: debug
    - name: graylog_servers
      value: '[{"host": "nonprod-syslog.vpayusa.net", "port": 5555}]'
    - name: injectedVars
      value: |-
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
