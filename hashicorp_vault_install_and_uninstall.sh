ended up getting container env as mentioned below in the pod.

    - name: PARTNER_B2B_SEND_INDICATOR
      value: |2

        valueFrom:
          configMapKeyRef:
            name: remittance-partner-network-configmap
            key: remittance-configs.partner.b2bSendIndicator
