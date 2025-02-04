pldevlvault1 ~ # datadog-agent check vault
=== Series ===
[
  {
    "metric": "vault.is_leader",
    "points": [
      [
        1738647314,
        1
      ]
    ],
    "tags": [
      "api_url:http://localhost:8200/v1",
      "is_leader:true",
      "vault_cluster:vault-cluster-0a21354a",
      "vault_version:1.17.5"
    ],
    "host": "pldevlvault1.test.net",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  }
]
=== Service Checks ===
[
  {
    "check": "vault.unsealed",
    "host_name": "pldevlvault1.test.net",
    "timestamp": 1738647314,
    "status": 0,
    "message": "",
    "tags": [
      "api_url:http://localhost:8200/v1",
      "is_leader:true",
      "vault_cluster:vault-cluster-0a21354a",
      "vault_version:1.17.5"
    ]
  },
  {
    "check": "vault.initialized",
    "host_name": "pldevlvault1.test.net",
    "timestamp": 1738647314,
    "status": 0,
    "message": "",
    "tags": [
      "api_url:http://localhost:8200/v1",
      "is_leader:true",
      "vault_cluster:vault-cluster-0a21354a",
      "vault_version:1.17.5"
    ]
  },
  {
    "check": "vault.openmetrics.health",
    "host_name": "pldevlvault1.test.net",
    "timestamp": 1738647314,
    "status": 2,
    "message": "403 Client Error: Forbidden for url: http://localhost:8200/v1/sys/metrics?format=prometheus",
    "tags": [
      "api_url:http://localhost:8200/v1",
      "endpoint:http://localhost:8200/v1/sys/metrics?format=prometheus"
    ]
  }
]


  Running Checks
  ==============

    vault (6.0.0)
    -------------
      Instance ID: vault:502cdfddb49b1d99 [ERROR]
      Configuration Source: file:/etc/datadog-agent/conf.d/vault.d/conf.yaml
      Total Runs: 1
      Metric Samples: Last Run: 1, Total: 1
      Events: Last Run: 0, Total: 0
      Service Checks: Last Run: 3, Total: 3
      Average Execution Time : 13ms
      Last Execution Date : 2025-02-03 23:35:14 CST / 2025-02-04 05:35:14 UTC (1738647314000)
      Last Successful Execution Date : Never
      Error: There was an error scraping endpoint http://localhost:8200/v1/sys/metrics?format=prometheus: 403 Client Error: Forbidden for url: http://localhost:8200/v1/sys/metrics?format=prometheus
      Traceback (most recent call last):
        File "/opt/datadog-agent/embedded/lib/python3.12/site-packages/datadog_checks/base/checks/base.py", line 1301, in run
          self.check(instance)
        File "/opt/datadog-agent/embedded/lib/python3.12/site-packages/datadog_checks/vault/check.py", line 74, in check
          super().check(_)
        File "/opt/datadog-agent/embedded/lib/python3.12/site-packages/datadog_checks/base/checks/openmetrics/v2/base.py", line 75, in check
          raise type(e)("There was an error scraping endpoint {}: {}".format(endpoint, e)) from None
      requests.exceptions.HTTPError: There was an error scraping endpoint http://localhost:8200/v1/sys/metrics?format=prometheus: 403 Client Error: Forbidden for url: http://localhost:8200/v1/sys/metrics?format=prometheus

  Metadata
  ========
    config.hash: vault:502cdfddb49b1d99
    config.provider: file
    version.scheme: semver
    version.major: 1
    version.minor: 17
    version.patch: 5
    version.raw: 1.17.5
Check has run only once, if some metrics are missing you can try again with --check-rate to see any other metric if available.
This check type has 1 instances. If you're looking for a different check instance, try filtering on a specific one using the --instance-filter flag or set --discovery-min-instances to a higher value
