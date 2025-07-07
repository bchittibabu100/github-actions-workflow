cat awx-deploy.yaml                                                                                                                                                  ─╯
---
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx
  namespace: awx
spec:
  service_type: ClusterIP
  ingress_type: none
  node_selector:
    workload: awx
  tolerations:
    - key: "awx"
      operator: "Equal"
      value: "true"
      effect: "NoSchedule"
  postgres_storage_class: managed-premium
  redis_image: redis:7.0


kubectl apply -f awx-deploy.yaml
Error from server (BadRequest): error when creating "awx-deploy.yaml": AWX in version "v1beta1" cannot be handled as a AWX: strict decoding error: unknown field "spec.node_selector.workload", unknown field "spec.tolerations[0].effect", unknown field "spec.tolerations[0].key", unknown field "spec.tolerations[0].operator", unknown field "spec.tolerations[0].value"
