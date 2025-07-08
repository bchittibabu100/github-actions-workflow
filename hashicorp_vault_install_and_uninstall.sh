Error from server (BadRequest): error when creating "awx-deploy.yaml": AWX in version "v1beta1" cannot be handled as a AWX: strict decoding error: unknown field "spec.task_node_selector.workload", unknown field "spec.task_tolerations[0].effect", unknown field "spec.task_tolerations[0].key", unknown field "spec.task_tolerations[0].operator", unknown field "spec.task_tolerations[0].value", unknown field "spec.web_node_selector.workload", unknown field "spec.web_tolerations[0].effect", unknown field "spec.web_tolerations[0].key", unknown field "spec.web_tolerations[0].operator", unknown field "spec.web_tolerations[0].value"

current tag:
2.16.0
cat awx-deploy.yaml
---
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx
  namespace: awx
spec:
  service_type: ClusterIP
  ingress_type: none
  postgres_storage_class: managed-premium
  redis_image: redis:7.0
  task_node_selector:
    workload: awx
  web_node_selector:
    workload: awx
  task_tolerations:
    - key: "awx"
      operator: "Equal"
      value: "true"
      effect: "NoSchedule"
  web_tolerations:
    - key: "awx"
      operator: "Equal"
      value: "true"
      effect: "NoSchedule"
