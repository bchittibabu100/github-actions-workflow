apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: awx-operator-extra
rules:
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["create", "get", "list", "update", "patch", "delete"]

kubectl apply -f awx-operator-extra-role.yaml

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: awx-operator-extra-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: awx-operator-extra
subjects:
- kind: ServiceAccount
  name: awx-operator-controller-manager
  namespace: awx

kubectl apply -f awx-operator-extra-binding.yaml

kubectl auth can-i create secret --as=system:serviceaccount:awx:awx-operator-controller-manager
kubectl delete pod -n awx -l control-plane=controller-manager

kubectl delete awx awx-demo -n awx
kubectl apply -f awx-deploy.yaml
