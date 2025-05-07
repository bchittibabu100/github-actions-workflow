test@plinfldops02 ~/defaul_helm_templates/helm-gen/templates $ cat _container.tpl
{{- define "vpay.container.tpl" -}}
  {{- $probes := default (dict) .Values.probes -}}
  {{- $liveness := default (dict) $probes.liveness -}}
  {{- $readiness := default (dict) $probes.readiness -}}
  {{- $primaryPort := ternary (int (dig "experimentalFeatures" "exposeHttpAndHttps" "httpsPort" (443) .Values)) (int (.Values.listeningPort)) (dig "experimentalFeatures" "exposeHttpAndHttps" "enabled" (false) .Values) -}}
  {{- $portName := default "primary-port" .Values.portName -}}
  {{- $portScheme := ternary ("HTTPS") (default "HTTP" .Values.portScheme) (dig "experimentalFeatures" "exposeHttpAndHttps" "enabled" (false) .Values) -}}
  {{- $imageWithTag := printf "%s:%s" .Values.image.name (.Values.image.tag | toString) -}}
  {{- $startup := $probes.startup -}}
name: {{ default (include "vpay.name" .) .Values.containerName }}
image: {{ ternary ($imageWithTag) (printf "%s/%s" .Values.image.registry $imageWithTag) (eq (.Values.image.registry | toString) "<nil>") }}
imagePullPolicy: {{ default "Always" .Values.image.pullPolicy}}
env:
  - name: K8S_NODE_NAME
    valueFrom:
      fieldRef:
        fieldPath: spec.nodeName
  - name: K8S_POD_NAME
    valueFrom:
      fieldRef:
        fieldPath: metadata.name

  {{- if .Values.env }}
    {{- range $key, $val := .Values.env }}
    {{- if (eq ($val | toString) "<nil>" | not) }}
  - name: {{ $key }}
    value: {{ tpl ($val | toString) $ | quote }}
    {{- end }}
    {{- end }}
  {{- end }}

{{- if .Values.secretEnv }}
envFrom:
  - secretRef:
      name: {{ default (include "vpay.name" .) .Values.containerName }}-env
      optional: false
{{- end }}

  {{- if (dig "experimentalFeatures" "exposeHttpAndHttps" "enabled" (false) .Values) }}
    {{- if (or (.Values.listeningPort) (.Values.serviceExposePort) (.Values.portScheme)) }}
      {{- fail "When 'exposeHttpAndHttps' is enabled, you can't provide a 'listeningPort', 'portScheme', or 'serviceExposePort'" }}
    {{- end }}
    {{- if (eq (int (dig "experimentalFeatures" "exposeHttpAndHttps" "httpsPort" (443) .Values)) (int (dig "experimentalFeatures" "exposeHttpAndHttps" "httpPort" (80) .Values))) }}
      {{- fail "When 'exposeHttpAndHttps' is enabled, the HTTPS and HTTP ports must be different" }}
    {{- end }}
  {{- end }}
  {{- if $primaryPort }}
ports:
  - name: {{ $portName }}
    containerPort: {{ $primaryPort }}
    protocol: TCP
  {{- if (dig "experimentalFeatures" "exposeHttpAndHttps" "enabled" (false) .Values) }}
  - name: http-port
    containerPort: {{ int (dig "experimentalFeatures" "exposeHttpAndHttps" "httpPort" (80) .Values) }}
    protocol: TCP
  {{- end }}
    {{- if include "vpay.util.trueenabled" $liveness.enabled }}
livenessProbe:
      {{- if $liveness.endpoint }}
  httpGet:
    path: {{ $liveness.endpoint }}
    port: {{ $portName }}
    {{- if (eq $portScheme "HTTP" | not) }}
    scheme: {{ $portScheme }}
    {{- end }}
      {{- else }}
  tcpSocket:
    port: {{ $portName }}
      {{- end }}
  initialDelaySeconds: {{ default (30) $liveness.initialDelaySeconds }}
  periodSeconds: {{ default (30) $liveness.periodSeconds }}
  failureThreshold: {{ default (5) $liveness.failureThreshold }}
  successThreshold: {{ default (1) $startup.successThreshold }}
  timeoutSeconds: {{ default (3) $liveness.timeoutSeconds }}
    {{- end }}
    {{- if include "vpay.util.trueenabled" $readiness.enabled }}
readinessProbe:
      {{- if $readiness.endpoint }}
  httpGet:
    path: {{ $readiness.endpoint }}
    port: {{ $portName }}
    {{- if (eq $portScheme "HTTP" | not) }}
    scheme: {{ $portScheme }}
    {{- end }}
      {{- else }}
  tcpSocket:
    port: {{ $portName }}
      {{- end }}
  periodSeconds: {{ default (10) $readiness.periodSeconds }}
  failureThreshold: {{ default (3) $readiness.failureThreshold }}
  successThreshold: {{ default (1) $startup.successThreshold }}
  timeoutSeconds: {{ default (3) $readiness.timeoutSeconds }}
    {{- end }}
    {{- if (not (eq ($startup | toString) "<nil>")) }}
      {{- if include "vpay.util.trueenabled" $startup.enabled }}
startupProbe:
        {{- if $startup.endpoint }}
  httpGet:
    path: {{ $startup.endpoint }}
    port: {{ $portName }}
    {{- if (eq $portScheme "HTTP" | not) }}
    scheme: {{ $portScheme }}
    {{- end }}
        {{- else }}
  tcpSocket:
    port: {{ $portName }}
        {{- end }}
  periodSeconds: {{ default (10) $startup.periodSeconds }}
  failureThreshold: {{ default (5) $startup.failureThreshold }}
  successThreshold: {{ default (1) $startup.successThreshold }}
  timeoutSeconds: {{ default (3) $startup.timeoutSeconds }}
      {{- end }}
    {{- end }}
  {{- end }}

  {{- if .Values.resources }}
resources: {{- .Values.resources | toYaml | trim | nindent 2 }}
  {{- end }}

  {{- if .hasMountedVolumes }}
volumeMounts:
  {{- if (include "vpay.util.anymounted.secret" .Values.secrets) }}
    {{- include "vpay.secret.volumeMounts" . | trim | nindent 2 }}
  {{- end }}
  {{- if (include "vpay.util.anymounted.secret" .Values.configMaps) }}
    {{- include "vpay.configmap.volumeMounts" . | trim | nindent 2 }}
  {{- end }}
  {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountNfs "shares" $.__GlobalValues.nfsShares)) }}
    {{- include "vpay.pvc.nfs.volumeMounts" . | trim | nindent 2 }}
  {{- end }}
  {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountSmb "shares" $.__GlobalValues.smbShares)) }}
    {{- include "vpay.pvc.smb.volumeMounts" . | trim | nindent 2 }}
  {{- end }}
  {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountEmptyDir "shares" (dict))) }}
    {{- include "vpay.emptyDir.volumeMounts" . | trim | nindent 2 }}
  {{- end }}
  {{- if (include "vpay.util.anymounted.share" (dict "mountPoints" .Values.mountPersistentVolumeClaims "shares" (dict))) }}
    {{- include "vpay.pvc-raw.volumeMounts" . | trim | nindent 2 }}
  {{- end }}
  {{- end -}}
{{- end }}
