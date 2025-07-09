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

kubectl patch sts awx-ansible-postgres-15 \
  -n awx \
  --type='merge' \
  -p '{"spec": {"template": {"spec": {"securityContext": {"fsGroup": 26}}}}}'


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



*********************\r\ntask path: /opt/ansible/roles/installer/tasks/resources_configuration.yml:233\nok: [localhost] => {\"ansible_facts\": {\"_default_redis_image\": \"docker.io/redis:7\"}, \"changed\": false}\n\r\nTASK [installer : Set user provided redis image] *******************************\r\ntask path: /opt/ansible/roles/installer/tasks/resources_configuration.yml:237\nfatal: [localhost]: FAILED! => {\"msg\": \"The conditional check 'redis_image_version is defined or redis_image_version != ''' failed. The error was: error while evaluating conditional (redis_image_version is defined or redis_image_version != ''): 'redis_image_version' is undefined. 'redis_image_version' is undefined\\n\\nThe error appears to be in '/opt/ansible/roles/installer/tasks/resources_configuration.yml': line 237, column 3, but may\\nbe elsewhere in the file depending on the exact syntax problem.\\n\\nThe offending line appears to be:\\n\\n\\n- name: Set user provided redis image\\n  ^ here\\n\"}\n\r\nPLAY RECAP *********************************************************************\r\nlocalhost                  : ok=61   changed=0    unreachable=0    failed=1    skipped=68   rescued=0    ignored=0   \n","job":"3334994276792168154","name":"awx-ansible","namespace":"awx","error":"exit status 2","stacktrace":"github.com/operator-framework/ansible-operator-plugins/internal/ansible/runner.(*runner).Run.func1\n\tansible-operator-plugins/internal/ansible/runner/runner.go:269"}

----- Ansible Task Status Event StdOut (awx.ansible.com/v1beta1, Kind=AWX, awx-ansible/awx) -----


PLAY RECAP *********************************************************************
localhost                  : ok=61   changed=0    unreachable=0    failed=1    skipped=68   rescued=0    ignored=0

----------
{"level":"error","ts":"2025-07-09T18:21:55Z","msg":"Reconciler error","controller":"awx-controller","object":{"name":"awx-ansible","namespace":"awx"},"namespace":"awx","name":"awx-ansible","reconcileID":"81f7aa03-c744-4db6-ac8a-99b78c656a7f","error":"event runner on failed","stacktrace":"sigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).reconcileHandler\n\t/home/runner/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.16.3/pkg/internal/controller/controller.go:329\nsigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).processNextWorkItem\n\t/home/runner/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.16.3/pkg/internal/controller/controller.go:266\nsigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).Start.func2.2\n\t/home/runner/go/pkg/mod/sigs.k8s.io/controller-runtime@v0.16.3/pkg/internal/controller/controller.go:227"}
