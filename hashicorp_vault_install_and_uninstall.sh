kubectl create secret generic mssql-secret \
  --from-literal=SA_PASSWORD='YourStrong!Passw0rd'

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mssql-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi


apiVersion: apps/v1
kind: Deployment
metadata:
  name: mssql-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mssql
  template:
    metadata:
      labels:
        app: mssql
    spec:
      containers:
      - name: mssql
        image: mcr.microsoft.com/mssql/server:2022-latest
        ports:
        - containerPort: 1433
        env:
        - name: ACCEPT_EULA
          value: "Y"
        - name: SA_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mssql-secret
              key: SA_PASSWORD
        volumeMounts:
        - name: mssql-data
          mountPath: /var/opt/mssql
      volumes:
      - name: mssql-data
        persistentVolumeClaim:
          claimName: mssql-pvc


apiVersion: v1
kind: Service
metadata:
  name: mssql-service
spec:
  type: ClusterIP
  ports:
    - port: 1433
      targetPort: 1433
  selector:
    app: mssql

kubectl apply -f mssql-pvc.yaml
kubectl apply -f mssql-deployment.yaml
kubectl apply -f mssql-service.yaml
sqlcmd -S <host>,1433 -U sa -P 'YourStrong!Passw0rd'
