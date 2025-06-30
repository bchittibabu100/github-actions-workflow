apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx
  namespace: awx
spec:
  service_type: LoadBalancer
  ingress_type: none

  # Ensure pods run on the correct node pool
  node_selector:
    nodepool: awx

  # Tolerate the taint applied to awx-only nodes
  tolerations:
    - key: "nodepool"
      operator: "Equal"
      value: "awx"
      effect: "NoSchedule"

  # Embedded PostgreSQL settings
  postgresql:
    enabled: true
    volume_size: 8Gi
    storage_class: default

    node_selector:
      nodepool: awx

    tolerations:
      - key: "nodepool"
        operator: "Equal"
        value: "awx"
        effect: "NoSchedule"
