{"level":"info","ts":"2025-07-09T04:56:08Z","logger":"KubeAPIWarningLogger","msg":"unknown field \"status.conditions[0].message\""}
{"level":"info","ts":"2025-07-09T04:56:09Z","logger":"logging_event_handler","msg":"[playbook task start]","name":"awx-demo","namespace":"awx","gvk":"awx.ansible.com/v1beta1, Kind=AWX","event_type":"playbook_on_task_start","job":"8942871570929849432","EventData.Name":"Verify imagePullSecrets"}

--------------------------- Ansible Task StdOut -------------------------------

TASK [Verify imagePullSecrets] *************************************************
task path: /opt/ansible/playbooks/awx.yml:10

-------------------------------------------------------------------------------
{"level":"error","ts":"2025-07-09T04:56:09Z","logger":"proxy","msg":"Unable to determine if virtual resource","gvk":"/v1, Kind=Secret","error":"unable to retrieve the complete list of server APIs: external.metrics.k8s.io/v1beta1: stale GroupVersion discovery: external.metrics.k8s.io/v1beta1","stacktrace":"github.com/operator-framework/ansible-operator-plugins/internal/ansible/proxy.(*cacheResponseHandler).ServeHTTP\n\tansible-operator-plugins/internal/ansible/proxy/cache_response.go:99\nnet/http.serverHandler.ServeHTTP\n\t/opt/hostedtoolcache/go/1.20.12/x64/src/net/http/server.go:2936\nnet/http.(*conn).serve\n\t/opt/hostedtoolcache/go/1.20.12/x64/src/net/http/server.go:1995"}
{"level":"info","ts":"2025-07-09T04:56:09Z","logger":"logging_event_handler","msg":"[playbook task start]","name":"awx-demo","namespace":"awx","gvk":"awx.ansible.com/v1beta1, Kind=AWX","event_type":"playbook_on_task_start","job":"8942871570929849432","EventData.Name":"Create imagePullSecret"}

--------------------------- Ansible Task StdOut -------------------------------

TASK [Create imagePullSecret] **************************************************
task path: /opt/ansible/playbooks/awx.yml:17

-------------------------------------------------------------------------------
{"level":"error","ts":"2025-07-09T04:56:10Z","logger":"proxy","msg":"Unable to determine if virtual resource","gvk":"/v1, Kind=Secret","error":"unable to retrieve the complete list of server APIs: external.metrics.k8s.io/v1beta1: stale GroupVersion discovery: external.metrics.k8s.io/v1beta1","stacktrace":"github.com/operator-framework/ansible-operator-plugins/internal/ansible/proxy.(*cacheResponseHandler).ServeHTTP\n\tansible-operator-plugins/internal/ansible/proxy/cache_response.go:99\nnet/http.serverHandler.ServeHTTP\n\t/opt/hostedtoolcache/go/1.20.12/x64/src/net/http/server.go:2936\nnet/http.(*conn).serve\n\t/opt/hostedtoolcache/go/1.20.12/x64/src/net/http/server.go:1995"}
{"level":"error","ts":"2025-07-09T04:56:10Z","logger":"proxy","msg":"Unable to determine if virtual resource","gvk":"/v1, Kind=Secret","error":"unable to retrieve the complete list of server APIs: external.metrics.k8s.io/v1beta1: stale GroupVersion discovery: external.metrics.k8s.io/v1beta1","stacktrace":"github.com/operator-framework/ansible-operator-plugins/internal/ansible/proxy.(*injectOwnerReferenceHandler).ServeHTTP\n\tansible-operator-plugins/internal/ansible/proxy/inject_owner.go:93\ngithub.com/operator-framework/ansible-operator-plugins/internal/ansible/proxy.(*cacheResponseHandler).ServeHTTP\n\tansible-operator-plugins/internal/ansible/proxy/cache_response.go:150\nnet/http.serverHandler.ServeHTTP\n\t/opt/hostedtoolcache/go/1.20.12/x64/src/net/http/server.go:2936\nnet/http.(*conn).serve\n\t/opt/hostedtoolcache/go/1.20.12/x64/src/net/http/server.go:1995"}
{"level":"error","ts":"2025-07-09T04:56:10Z","logger":"logging_event_handler","msg":"","name":"awx-demo","namespace":"awx","gvk":"awx.ansible.com/v1beta1, Kind=AWX","event_type":"runner_on_failed","job":"8942871570929849432","EventData.Task":"Create imagePullSecret","EventData.TaskArgs":"","EventData.FailedTaskPath":"/opt/ansible/playbooks/awx.yml:17","error":"[playbook task failed]","stacktrace":"github.com/operator-framework/ansible-operator-plugins/internal/ansible/events.loggingEventHandler.Handle\n\tansible-operator-plugins/internal/ansible/events/log_events.go:111"}

--------------------------- Ansible Task StdOut -------------------------------

 TASK [Create imagePullSecret] ********************************
fatal: [localhost]: FAILED! => {"changed": false, "msg": "Failed to create object: b'Unable to determine if virtual resource\\n'", "reason": "Internal Server Error"}
