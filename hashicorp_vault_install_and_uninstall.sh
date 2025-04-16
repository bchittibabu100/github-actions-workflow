---
# Source: gateway/charts/redis/templates/secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: gateway-redis
  namespace: "test"
  labels:
    app: redis
    chart: redis-12.4.0
    release: "gateway-api"
    heritage: "Helm"
type: Opaque
data:
  redis-password: "dflsjejroew32432809842="
---
# Source: gateway/charts/redis/templates/configmap-scripts.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: gateway-redis-scripts
  namespace: "test"
  labels:
    app: redis
    chart: redis-12.4.0
    heritage: Helm
    release: gateway-api
data:
  start-master.sh: |
    #!/bin/bash
    if [[ -n $REDIS_PASSWORD_FILE ]]; then
      password_aux=`cat ${REDIS_PASSWORD_FILE}`
      export REDIS_PASSWORD=$password_aux
    fi
    if [[ ! -f /opt/bitnami/redis/etc/master.conf ]];then
      cp /opt/bitnami/redis/mounted-etc/master.conf /opt/bitnami/redis/etc/master.conf
    fi
    if [[ ! -f /opt/bitnami/redis/etc/redis.conf ]];then
      cp /opt/bitnami/redis/mounted-etc/redis.conf /opt/bitnami/redis/etc/redis.conf
    fi
    ARGS=("--port" "${REDIS_PORT}")
    ARGS+=("--requirepass" "${REDIS_PASSWORD}")
    ARGS+=("--masterauth" "${REDIS_PASSWORD}")
    ARGS+=("--include" "/opt/bitnami/redis/etc/redis.conf")
    ARGS+=("--include" "/opt/bitnami/redis/etc/master.conf")
    exec /run.sh "${ARGS[@]}"
---
# Source: gateway/charts/redis/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: gateway-redis
  namespace: "test"
  labels:
    app: redis
    chart: redis-12.4.0
    heritage: Helm
    release: gateway-api
data:
  redis.conf: |-
    # User-supplied configuration:
    # Enable AOF https://redis.io/topics/persistence#append-only-file
    appendonly yes
    # Disable RDB persistence, AOF persistence already enabled.
    save ""
  master.conf: |-
    dir /data
    rename-command FLUSHDB ""
    rename-command FLUSHALL ""
  replica.conf: |-
    dir /data
    slave-read-only yes
    rename-command FLUSHDB ""
    rename-command FLUSHALL ""
---
# Source: gateway/charts/redis/templates/health-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: gateway-redis-health
  namespace: "test"
  labels:
    app: redis
    chart: redis-12.4.0
    heritage: Helm
    release: gateway-api
data:
  ping_readiness_local.sh: |-
    #!/bin/bash
    export REDISCLI_AUTH="$REDIS_PASSWORD"
    response=$(
      timeout -s 3 $1 \
      redis-cli \
        -h localhost \
        -p $REDIS_PORT \
        ping
    )
    if [ "$response" != "PONG" ]; then
      echo "$response"
      exit 1
    fi
  ping_liveness_local.sh: |-
    #!/bin/bash
    export REDISCLI_AUTH="$REDIS_PASSWORD"
    response=$(
      timeout -s 3 $1 \
      redis-cli \
        -h localhost \
        -p $REDIS_PORT \
        ping
    )
    if [ "$response" != "PONG" ] && [ "$response" != "LOADING Redis is loading the dataset in memory" ]; then
      echo "$response"
      exit 1
    fi
  ping_readiness_master.sh: |-
    #!/bin/bash
    export REDISCLI_AUTH="$REDIS_MASTER_PASSWORD"
    response=$(
      timeout -s 3 $1 \
      redis-cli \
        -h $REDIS_MASTER_HOST \
        -p $REDIS_MASTER_PORT_NUMBER \
        ping
    )
    if [ "$response" != "PONG" ]; then
      echo "$response"
      exit 1
    fi
  ping_liveness_master.sh: |-
    #!/bin/bash
    export REDISCLI_AUTH="$REDIS_MASTER_PASSWORD"
    response=$(
      timeout -s 3 $1 \
      redis-cli \
        -h $REDIS_MASTER_HOST \
        -p $REDIS_MASTER_PORT_NUMBER \
        ping
    )
    if [ "$response" != "PONG" ] && [ "$response" != "LOADING Redis is loading the dataset in memory" ]; then
      echo "$response"
      exit 1
    fi
  ping_readiness_local_and_master.sh: |-
    script_dir="$(dirname "$0")"
    exit_status=0
    "$script_dir/ping_readiness_local.sh" $1 || exit_status=$?
    "$script_dir/ping_readiness_master.sh" $1 || exit_status=$?
    exit $exit_status
  ping_liveness_local_and_master.sh: |-
    script_dir="$(dirname "$0")"
    exit_status=0
    "$script_dir/ping_liveness_local.sh" $1 || exit_status=$?
    "$script_dir/ping_liveness_master.sh" $1 || exit_status=$?
    exit $exit_status
---
# Source: gateway/charts/redis/templates/headless-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: gateway-redis-headless
  namespace: "test"
  labels:
    app: redis
    chart: redis-12.4.0
    release: gateway-api
    heritage: Helm
spec:
  type: ClusterIP
  clusterIP: None
  ports:
    - name: redis
      port: 6379
      targetPort: redis
  selector:
    app: redis
    release: gateway-api
---
# Source: gateway/charts/redis/templates/redis-master-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: gateway-redis-master
  namespace: "test"
  labels:
    app: redis
    chart: redis-12.4.0
    release: gateway-api
    heritage: Helm
spec:
  type: LoadBalancer

  externalTrafficPolicy: Cluster
  ports:
    - name: redis
      port: 6379
      targetPort: redis
  selector:
    app: redis
    release: gateway-api
    role: master
---
# Source: gateway/charts/redis/templates/redis-master-statefulset.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: gateway-redis-master
  namespace: "test"
  labels:
    app: redis
    chart: redis-12.4.0
    release: gateway-api
    heritage: Helm
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
        chart: redis-12.4.0
        release: gateway-api
        role: master
      annotations:
        checksum/health: 2032f47a6ba6fdd25ddadcdbf3a6b57fc0b3db2757fe3a7a3ecc0ad3ca61b260
        checksum/configmap: 847104b20d79bb4d8dd63d06df835d9b5e629d91696cb917f0e4fdc88755ab30
        checksum/secret: 78d7b10b0700beb7be3817d07cad5833cd07c60ea87cde278ca67b6cd2524c2a
    spec:
      securityContext:
        fsGroup: 1001
      serviceAccountName: default
      containers:
        - name: redis
          image: redis-alpine:7.4.2
          imagePullPolicy: "IfNotPresent"
          securityContext:
            runAsUser: 1001
          command:
            - /bin/bash
            - -c
            - /opt/bitnami/scripts/start-scripts/start-master.sh
          env:
            - name: REDIS_REPLICATION_MODE
              value: master
            - name: REDIS_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: gateway-redis
                  key: redis-password
            - name: REDIS_TLS_ENABLED
              value: "no"
            - name: REDIS_PORT
              value: "6379"
          ports:
            - name: redis
              containerPort: 6379
          livenessProbe:
            initialDelaySeconds: 5
            periodSeconds: 5
            # One second longer than command timeout should prevent generation of zombie processes.
            timeoutSeconds: 6
            successThreshold: 1
            failureThreshold: 5
            exec:
              command:
                - sh
                - -c
                - /health/ping_liveness_local.sh 5
          readinessProbe:
            initialDelaySeconds: 5
            periodSeconds: 5
            timeoutSeconds: 2
            successThreshold: 1
            failureThreshold: 5
            exec:
              command:
                - sh
                - -c
                - /health/ping_readiness_local.sh 1
          resources:
            null
          volumeMounts:
            - name: start-scripts
              mountPath: /opt/bitnami/scripts/start-scripts
            - name: health
              mountPath: /health
            - name: redis-data
              mountPath: /data
              subPath:
            - name: config
              mountPath: /opt/bitnami/redis/mounted-etc
            - name: redis-tmp-conf
              mountPath: /opt/bitnami/redis/etc/
      volumes:
        - name: start-scripts
          configMap:
            name: gateway-redis-scripts
            defaultMode: 0755
        - name: health
          configMap:
            name: gateway-redis-health
            defaultMode: 0755
        - name: config
          configMap:
            name: gateway-redis
        - name: "redis-data"
          emptyDir: {}
        - name: redis-tmp-conf
          emptyDir: {}
  updateStrategy:
    type: RollingUpdate
