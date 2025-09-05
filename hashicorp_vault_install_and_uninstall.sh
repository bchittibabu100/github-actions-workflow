{{- define "vpay.podmetaspec.tpl" -}}
metadata:
  labels:
    {{- include "vpay.labels.name" . | nindent 4 }}
    {{- include "vpay.labels.instance" . | nindent 4 }}
    {{- with .Values.podLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  annotations:
    {{- with .Values.podAnnotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  serviceAccountName: {{ include "vpay.serviceAccountName" . }}
  containers:
    - name: {{ include "vpay.fullname" . }}
      image: "{{ .Values.global.image.registry }}/{{ .Values.image.name }}:{{ .Values.global.image.tag | default .Chart.AppVersion }}"
      imagePullPolicy: {{ .Values.global.image.pullPolicy }}
      ports:
        - name: http
          containerPort: {{ .Values.listeningPort }}
      env:
        {{- with .Values.env }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
      resources:
        {{- toYaml .Values.resources | nindent 8 }}
      livenessProbe:
        httpGet:
          path: {{ .Values.probes.liveness.endpoint }}
          port: http
      readinessProbe:
        httpGet:
          path: {{ .Values.probes.readiness.endpoint }}
          port: http
{{- end }}
