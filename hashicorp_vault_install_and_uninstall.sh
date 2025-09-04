Would like to append following annotation, label and env to the existing one. give me where these modification to be done.
  
template:
    metadata:
      annotations:
        admission.datadoghq.com/dotnet-lib.version: v3.24.1
      labels:
        admission.datadoghq.com/enabled: "true"
      containers:
      - env:
        - name: DD_LOGS_INJECTION
          value: "true"
