kubectl delete awx awx-demo -n awx --ignore-not-found
kubectl delete ns awx --grace-period=0 --force
kubectl delete crd awxs.awx.ansible.com --ignore-not-found

kubectl get all -n awx

git clone https://github.com/ansible/awx-operator.git
cd awx-operator
git checkout tags/2.19.1 -b awx-2.19.1
make deploy NAMESPACE=awx

kubectl create namespace awx
kubectl apply -n awx -f https://raw.githubusercontent.com/ansible/awx-operator/2.19.1/deploy/awx-operator.yaml
kubectl get pods -n awx

kubectl -n awx patch deploy awx-operator-controller-manager \
  --type=json \
  -p='[{"op": "add", "path": "/spec/template/spec/tolerations", "value": [{"key": "awx", "operator": "Equal", "value": "true", "effect": "NoSchedule"}]}]'

apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx-ansible
  namespace: awx
spec:
  service_type: ClusterIP
  ingress_type: none
  postgres_storage_class: managed-premium
  redis_image: redis:7.0

  task_node_selector: '{"workload":"awx"}'
  web_node_selector: '{"workload":"awx"}'
  task_tolerations: '[{"key":"awx","operator":"Equal","value":"true","effect":"NoSchedule"}]'
  web_tolerations: '[{"key":"awx","operator":"Equal","value":"true","effect":"NoSchedule"}]'

  pod_spec_override: |
    securityContext:
      fsGroup: 26


kubectl apply -f awx-deploy.yaml

kubectl get pods -n awx -w

Wait for these pods to come up:

awx-demo-web
awx-demo-task
awx-demo-postgres-15-0
awx-demo-redis
awx-operator-controller-manager

kubectl port-forward svc/awx-demo-service -n awx 8043:80
Visit http://localhost:8043
Username: admin
Password: (retrieved via)

kubectl get secret awx-demo-admin-password -n awx -o jsonpath="{.data.password}" | base64 -d
