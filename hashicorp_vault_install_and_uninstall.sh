az aks nodepool add \
  --resource-group rg-nonprod-hub-centralus \
  --cluster-name hub-aks \
  --name awxpool \
  --node-count 2 \
  --node-vm-size Standard_E4s_v5 \
  --labels workload=awx \
  --node-taints awx=true:NoSchedule \
  --mode User \
  --zones 1 \
  --os-sku Ubuntu \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 4 \
  --node-osdisk-type Managed \
  --node-osdisk-size 100

  kubectl create namespace awx
  helm repo add awx-operator https://ansible.github.io/awx-operator/
helm repo update
helm install awx-operator awx-operator/awx-operator \
  --namespace awx \
  --create-namespace \
  --set installCRDs=true
kubectl get pods -n awx


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
  web_extra_volume_mounts: []
  task_extra_volume_mounts: []


kubectl apply -f awx-cr.yaml

kubectl get pods -n awx
kubectl get svc -n awx
kubectl get secret awx-admin-password -n awx -o jsonpath="{.data.password}" | base64 -d
