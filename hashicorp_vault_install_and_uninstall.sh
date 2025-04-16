apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: gateway-redis-master
  namespace: "test"
  labels:
    app: redis
    release: gateway-api
spec:
  selector:
    matchLabels:
      app: redis
      release: gateway-api
      role: master
  serviceName: gateway-redis-headless
  template:
    metadata:
      labels:
        app: redis
        release: gateway-api
        role: master
    spec:
      serviceAccountName: default
      containers:
        - name: redis
          image: redis:7.2-alpine
          imagePullPolicy: IfNotPresent
          command: ["redis-server", "/usr/local/etc/redis/redis.conf"]
          env:
            - name: REDIS_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: gateway-redis
                  key: redis-password
          ports:
            - name: redis
              containerPort: 6379
          livenessProbe:
            exec:
              command:
                - sh
                - -c
                - "redis-cli -a $REDIS_PASSWORD ping | grep PONG"
            initialDelaySeconds: 5
            periodSeconds: 5
          readinessProbe:
            exec:
              command:
                - sh
                - -c
                - "redis-cli -a $REDIS_PASSWORD ping | grep PONG"
            initialDelaySeconds: 5
            periodSeconds: 5
          volumeMounts:
            - name: redis-data
              mountPath: /data
            - name: redis-config
              mountPath: /usr/local/etc/redis
      volumes:
        - name: redis-config
          configMap:
            name: gateway-redis
        - name: redis-data
          emptyDir: {}
  updateStrategy:
    type: RollingUpdate
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: gateway-redis
  namespace: test
data:
  redis.conf: |
    port 6379
    requirepass ${REDIS_PASSWORD}
    appendonly yes
    save ""
    dir /data
    rename-command FLUSHDB ""
    rename-command FLUSHALL ""
---
