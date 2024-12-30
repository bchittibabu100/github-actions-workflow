vault auth enable kubernetes
vault write auth/kubernetes/config \
    token_reviewer_jwt="<JWT from Kubernetes>" \
    kubernetes_host="https://<KUBERNETES_API_SERVER>" \
    kubernetes_ca_cert="<path/to/ca.crt>"
kubectl create serviceaccount vault-reviewer -n kube-system
kubectl create clusterrolebinding vault-reviewer-binding --clusterrole=system:auth-delegator --serviceaccount=kube-system:vault-reviewer
kubectl get secret $(kubectl get serviceaccount vault-reviewer -n kube-system -o jsonpath='{.secrets[0].name}') -n kube-system -o jsonpath='{.data.token}' | base64 --decode
https://<KUBERNETES_SERVICE_HOST>:<KUBERNETES_SERVICE_PORT>
kubectl get configmap -n kube-system kube-root-ca.crt -o jsonpath='{.data.ca\.crt}'
vault write auth/kubernetes/role/my-role \
    bound_service_account_names=my-service-account \
    bound_service_account_namespaces=my-namespace \
    policies=my-policy \
    ttl=24h

apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-service-account
  namespace: my-namespace

kubectl apply -f service-account.yaml

apiVersion: v1
kind: Pod
metadata:
  name: vault-integrated-pod
  annotations:
    vault.hashicorp.com/agent-inject: "true"
    vault.hashicorp.com/role: "my-role"
    vault.hashicorp.com/agent-inject-token: "true"
spec:
  serviceAccountName: my-service-account
  containers:
  - name: app
    image: your-app-image

kubectl apply -f vault-integrated-pod.yaml

kubectl logs vault-integrated-pod
