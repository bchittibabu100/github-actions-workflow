╰─ kubectl get awx -n awx                                                                                                                                               ─╯
NAME   AGE
awx    12s

╭─    ~/Documents/awx-operator   #2.17.0 *1 !1 ?3 ───────────────────────────────────────────────────────────────────────────────────── ✔  hub-aks ⎈  18:30:14  ─╮
╰─ kubectl get awx -n awx -o yaml                                                                                                                                       ─╯
apiVersion: v1
items:
- apiVersion: awx.ansible.com/v1beta1
  kind: AWX
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"awx.ansible.com/v1beta1","kind":"AWX","metadata":{"annotations":{},"name":"awx","namespace":"awx"},"spec":{"ingress_type":"none","postgres_storage_class":"managed-premium","redis_image":"redis:7.0","service_type":"ClusterIP","task_node_selector":"{\"workload\":\"awx\"}","task_tolerations":"[{\"key\":\"awx\",\"operator\":\"Equal\",\"value\":\"true\",\"effect\":\"NoSchedule\"}]","web_node_selector":"{\"workload\":\"awx\"}","web_tolerations":"[{\"key\":\"awx\",\"operator\":\"Equal\",\"value\":\"true\",\"effect\":\"NoSchedule\"}]"}}
    creationTimestamp: "2025-07-08T01:30:03Z"
    generation: 1
    name: awx
    namespace: awx
    resourceVersion: "1463844054"
    uid: c344dfd7-ac0e-4515-a99a-bae9af7943ac
  spec:
    admin_user: admin
    auto_upgrade: true
    create_preload_data: true
    garbage_collect_secrets: false
    image_pull_policy: IfNotPresent
    ingress_type: none
    ipv6_disabled: false
    loadbalancer_class: ""
    loadbalancer_ip: ""
    loadbalancer_port: 80
    loadbalancer_protocol: http
    metrics_utility_console_enabled: false
    metrics_utility_cronjob_gather_schedule: '@hourly'
    metrics_utility_cronjob_report_schedule: '@monthly'
    metrics_utility_enabled: false
    metrics_utility_pvc_claim_size: 5Gi
    no_log: true
    postgres_keepalives: true
    postgres_keepalives_count: 5
    postgres_keepalives_idle: 5
    postgres_keepalives_interval: 5
    postgres_storage_class: managed-premium
    projects_persistence: false
    projects_storage_access_mode: ReadWriteMany
    projects_storage_size: 8Gi
    redis_image: redis:7.0
    replicas: 1
    route_tls_termination_mechanism: Edge
    service_type: ClusterIP
    set_self_labels: true
    task_liveness_failure_threshold: 3
    task_liveness_initial_delay: 5
    task_liveness_period: 0
    task_liveness_timeout: 1
    task_node_selector: '{"workload":"awx"}'
    task_privileged: false
    task_readiness_failure_threshold: 3
    task_readiness_initial_delay: 20
    task_readiness_period: 0
    task_readiness_timeout: 1
    task_tolerations: '[{"key":"awx","operator":"Equal","value":"true","effect":"NoSchedule"}]'
    web_liveness_failure_threshold: 3
    web_liveness_initial_delay: 5
    web_liveness_period: 0
    web_liveness_timeout: 1
    web_node_selector: '{"workload":"awx"}'
    web_readiness_failure_threshold: 3
    web_readiness_initial_delay: 20
    web_readiness_period: 0
    web_readiness_timeout: 1
    web_tolerations: '[{"key":"awx","operator":"Equal","value":"true","effect":"NoSchedule"}]'
kind: List
metadata:
  resourceVersion: ""

╭─    ~/Documents/awx-operator   #2.17.0 *1 !1 ?3 ───────────────────────────────────────────────────────────────────────────────────── ✔  hub-aks ⎈  18:30:38  ─╮
╰─ kubectl get po -n awx                                                                                                                                                ─╯
NAME                                              READY   STATUS    RESTARTS   AGE
awx-operator-controller-manager-8d74c66f4-btfr8   0/2     Pending   0          16m

╭─    ~/Documents/awx-operator   #2.17.0 *1 !1 ?3 ───────────────────────────────────────────────────────────────────────────────────── ✔  hub-aks ⎈  18:30:59  ─╮
╰─ kubectl get events -n awx                                                                                                                                            ─╯
LAST SEEN   TYPE      REASON              OBJECT                                                 MESSAGE
59m         Warning   FailedScheduling    pod/awx-operator-controller-manager-8d74c66f4-bjvhd    0/49 nodes are available: 1 node(s) had untolerated taint {awx: true}, 1 node(s) had untolerated taint {label: airflow}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {label: jenkins}, 32 node(s) had untolerated taint {label: default}, 4 node(s) had untolerated taint {CriticalAddonsOnly: true}, 4 node(s) had untolerated taint {label: elastic}, 5 node(s) had untolerated taint {label: portal}. preemption: 0/49 nodes are available: 49 Preemption is not helpful for scheduling.
59m         Normal    NotTriggerScaleUp   pod/awx-operator-controller-manager-8d74c66f4-bjvhd    pod didn't trigger scale-up: 1 node(s) had untolerated taint {awx: true}, 4 node(s) had untolerated taint {label: default}, 1 node(s) had untolerated taint {label: elastic}, 1 node(s) had untolerated taint {label: airflow}, 1 node(s) had untolerated taint {label: portal}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {label: jenkins}, 2 node(s) had untolerated taint {CriticalAddonsOnly: true}
19m         Normal    NotTriggerScaleUp   pod/awx-operator-controller-manager-8d74c66f4-bjvhd    (combined from similar events): pod didn't trigger scale-up: 4 node(s) had untolerated taint {label: default}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {awx: true}, 1 node(s) had untolerated taint {label: elastic}, 1 node(s) had untolerated taint {label: portal}, 1 node(s) had untolerated taint {label: jenkins}, 2 node(s) had untolerated taint {CriticalAddonsOnly: true}, 1 node(s) had untolerated taint {label: airflow}
19m         Warning   FailedScheduling    pod/awx-operator-controller-manager-8d74c66f4-bjvhd    0/49 nodes are available: 1 node(s) had untolerated taint {awx: true}, 1 node(s) had untolerated taint {label: airflow}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {label: jenkins}, 32 node(s) had untolerated taint {label: default}, 4 node(s) had untolerated taint {CriticalAddonsOnly: true}, 4 node(s) had untolerated taint {label: elastic}, 5 node(s) had untolerated taint {label: portal}. preemption: 0/49 nodes are available: 49 Preemption is not helpful for scheduling.
16m         Warning   FailedScheduling    pod/awx-operator-controller-manager-8d74c66f4-bjvhd    skip schedule deleting pod: awx/awx-operator-controller-manager-8d74c66f4-bjvhd
16m         Warning   FailedScheduling    pod/awx-operator-controller-manager-8d74c66f4-btfr8    0/49 nodes are available: 1 node(s) had untolerated taint {awx: true}, 1 node(s) had untolerated taint {label: airflow}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {label: jenkins}, 32 node(s) had untolerated taint {label: default}, 4 node(s) had untolerated taint {CriticalAddonsOnly: true}, 4 node(s) had untolerated taint {label: elastic}, 5 node(s) had untolerated taint {label: portal}. preemption: 0/49 nodes are available: 49 Preemption is not helpful for scheduling.
16m         Normal    NotTriggerScaleUp   pod/awx-operator-controller-manager-8d74c66f4-btfr8    pod didn't trigger scale-up: 1 node(s) had untolerated taint {label: airflow}, 1 node(s) had untolerated taint {label: elastic}, 2 node(s) had untolerated taint {CriticalAddonsOnly: true}, 4 node(s) had untolerated taint {label: default}, 1 node(s) had untolerated taint {label: portal}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {label: jenkins}, 1 node(s) had untolerated taint {awx: true}
83s         Normal    NotTriggerScaleUp   pod/awx-operator-controller-manager-8d74c66f4-btfr8    (combined from similar events): pod didn't trigger scale-up: 1 node(s) had untolerated taint {label: portal}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {label: jenkins}, 2 node(s) had untolerated taint {CriticalAddonsOnly: true}, 4 node(s) had untolerated taint {label: default}, 1 node(s) had untolerated taint {awx: true}, 1 node(s) had untolerated taint {label: airflow}, 1 node(s) had untolerated taint {label: elastic}
6m31s       Warning   FailedScheduling    pod/awx-operator-controller-manager-8d74c66f4-btfr8    0/49 nodes are available: 1 node(s) had untolerated taint {awx: true}, 1 node(s) had untolerated taint {label: airflow}, 1 node(s) had untolerated taint {label: gen835}, 1 node(s) had untolerated taint {label: jenkins}, 32 node(s) had untolerated taint {label: default}, 4 node(s) had untolerated taint {CriticalAddonsOnly: true}, 4 node(s) had untolerated taint {label: elastic}, 5 node(s) had untolerated taint {label: portal}. preemption: 0/49 nodes are available: 49 Preemption is not helpful for scheduling.
59m         Normal    SuccessfulCreate    replicaset/awx-operator-controller-manager-8d74c66f4   Created pod: awx-operator-controller-manager-8d74c66f4-bjvhd
16m         Normal    SuccessfulCreate    replicaset/awx-operator-controller-manager-8d74c66f4   Created pod: awx-operator-controller-manager-8d74c66f4-btfr8
59m         Normal    ScalingReplicaSet   deployment/awx-operator-controller-manager             Scaled up replica set awx-operator-controller-manager-8d74c66f4 to 1
