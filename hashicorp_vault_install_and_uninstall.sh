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
  postgres_storage_class: managed-premium
  redis_image: redis:7.0
  task_node_selector: '{"workload":"awx"}'
  web_node_selector: '{"workload":"awx"}'
  task_tolerations: '[{"key":"awx","operator":"Equal","value":"true","effect":"NoSchedule"}]'
  web_tolerations: '[{"key":"awx","operator":"Equal","value":"true","effect":"NoSchedule"}]'%


kubectl describe po -n awx awx-operator-controller-manager-8d74c66f4-btfr8 | grep -A4 Tolerations
Tolerations:                 node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason             Age                From                Message
