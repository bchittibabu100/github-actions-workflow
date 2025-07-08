kubectl get crd | grep awx                                                                                                                                           ─╯
awxbackups.awx.ansible.com                                   2025-07-08T00:31:49Z
awxmeshingresses.awx.ansible.com                             2025-07-08T00:31:49Z
awxrestores.awx.ansible.com                                  2025-07-08T00:31:50Z
awxs.awx.ansible.com                                         2025-07-08T00:31:50Z

 vim awxs.awx.ansible.com_crd.json
 
  "node_selector": {
    "description": "nodeSelector for the pods",
    "type": "string"
  },
  "nodeport_port": {
    "description": "Port to use for the nodeport",
    "type": "integer"
  },



  "web_node_selector": {
    "description": "nodeSelector for the web pods",
    "type": "string"
  },
  "web_readiness_failure_threshold": {
    "default": 3,
    "description": "Number of consecutive failure events to identify failure of web pod",
    "format": "int32",
    "type": "integer"
  },


  "image": "quay.io/ansible/awx-operator:2.17.0"
