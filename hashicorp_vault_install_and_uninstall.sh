I see empty lines before and after annotation and labels.

  template:
    metadata:
      labels:

        app: bartok-bartok-outbound-worker-b-development
        app.kubernetes.io/name: bartok-outbound-worker-b
        app.kubernetes.io/instance: bartok-bartok-outbound-worker-b
        app.kubernetes.io/part-of: bartok-outbound-worker-b
        helm.sh/chart: bartok-0.0.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/cluster-domain: dev.pks.vpayusa.net

        admission.datadoghq.com/enabled: "true"

      annotations:
        checksum/appsettings.secure.json: a99911b2c42202d68144174245f80f430d54856a35d06ac9df8e536b954f039b

        admission.datadoghq.com/dotnet-lib.version: v3.24.1

    spec:
      containers:
