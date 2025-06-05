Chart.yaml:
apiVersion: v2
name: par-process-api
description: VPay PAR Process API
icon: https://www.test.com/wp-content/themes/vpay/images/logo.svg
version: 0.0.1
dependencies:
  - name: helm-gen
    version: v1.2.0
    repository: https://plinfharbor.test.net/chartrepo/devops
    
bootstrap.yaml:
{{ include "vpay.bootstrap" . }}

values.yaml:
chart:
  virtual:
    charts:
      - par-process-api
    shared:
      generate:
        deployment: true
        secret: true
        service: true
        ingress: true
      image:
        registry: docker.repo1.test.com/vpay-docker
        tag: latest
        pullPolicy: Always

global:
  environment:
    name: dev
    ingress:
      subdomain: dev.pks.test.net

par-process-api:
  replicas: 1
  enabled: true
  listeningPort: 80
  contentRoot: /app
  generate:
    ingress: true
    service: true
  probes:
    readiness:
      endpoint: /api/about
    liveness:
      endpoint: /api/about
  image:
    name: par-process/par-process-api
  secrets:
    appsettings.secure.json:
      data: {}
  resources:
    requests:
      cpu: 20m
      memory: 1Gi
    limits:
      cpu: 500m
      memory: 1536Mi
  env:
    ASPNETCORE_ENVIRONMENT: '{{ .Values.global.environment.name }}'
    DOTNET_ENVIRONMENT: '{{ .Values.global.environment.name }}'
    
values-stage.yaml:
par-process-api:
  environment:
    ingress:
      domains:
        - par-process-api.stg.test.net
        
helm-gen/templates/_util.tpl:
{{- /*
Merge two YAML templates and output the result

This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)

*/ -}}
{{- define "vpay.util.merge" -}}
  {{- $top := first . -}}
  {{- $overrides := fromYaml (include (index . 1) $top) | default (dict) -}}
  {{- $tpl := fromYaml (include (index . 2) $top) | default (dict) -}}
  {{- toYaml (merge $overrides $tpl) -}}
{{- end -}}

{{- define "vpay.util.virtualize" -}}
  {{- $template := .template -}}
  {{- $generateType := .generateType -}}
  {{- $chart := default (dict) .Values.chart -}}
  {{- $virtual := default (dict) $chart.virtual -}}
  {{- $vcharts := default (list) $virtual.charts -}}
  {{- range $item := $vcharts -}}
    {{- $shared := default (dict) $virtual.shared | deepCopy -}}
    {{- $app := mergeOverwrite (dict) ($shared) (deepCopy (pick $.Values $item | values | first)) -}}
    {{- $nameOverride := default $item $app.nameOverride -}}
    {{- $fullnameOverride := default (printf "%s-%s" $.Release.Name $item) $app.fullnameOverride -}}
    {{- $nameOverrides := dict "nameOverride" $nameOverride "fullnameOverride" $fullnameOverride -}}
    {{- $global := ternary (pick $.Values "global") (dict) (empty $.Values.global | not) -}}
    {{- $values := mergeOverwrite (dict) ($global) ($nameOverrides) ($app) -}}
    {{- $globalValues := $.Values -}}
    {{- $root := omit $ "Values" -}}
    {{- $vchart := set $root "__GlobalValues" $globalValues }}
    {{- $vchart := set $root "Values" $values }}
    {{- $generateDict := default (dict) $vchart.Values.generate -}}
    {{- $shouldGenerate := (get $generateDict $generateType | default false) }}
    {{- if $shouldGenerate -}}
      {{- include $template $vchart }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "vpay.util.trueenabled" -}}
  {{- ternary ("true") ("") (or (.) (eq (. | toString) "<nil>")) -}}
{{- end -}}

{{- define "vpay.util.anymounted.secret" -}}
  {{- $hasMounted := false -}}
  {{- range $key, $value := default (dict) . -}}
    {{- if (include "vpay.util.trueenabled" $value.mount) -}}
      {{- $hasMounted = true -}}
    {{- end -}}
  {{- end -}}
  {{- ternary ("true") ("") $hasMounted -}}
{{- end -}}

{{- define "vpay.util.anymounted.share" -}}
  {{- $hasMounted := false -}}
  {{- $shares := .shares -}}
  {{- range $key, $value := default (dict) .mountPoints -}}
    {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $shares))) }}
      {{- range $volumeMount := default (list) $value -}}
        {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
          {{- $hasMounted = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- ternary ("true") ("") $hasMounted -}}
{{- end -}}

helm-gen/templates/_bootstrap.tpl:
{{- define "vpay.bootstrap" -}}
  {{- include "vpay.bootstrap.apphost" . }}
  {{- include "vpay.bootstrap.service" . }}
  {{- include "vpay.bootstrap.ingress" . }}
  {{- include "vpay.bootstrap.secret.opaque" . }}
  {{- include "vpay.bootstrap.secret.tls" . }}
  {{- include "vpay.bootstrap.configmap.filemount" . }}
  {{- include "vpay.bootstrap.pv.nfs" . }}
  {{- include "vpay.bootstrap.pvc.nfs" . }}
  {{- include "vpay.bootstrap.pv.smb" . }}
  {{- include "vpay.bootstrap.pvc.smb" . }}
  {{- include "vpay.bootstrap.secret.smb" . }}
{{- end -}}

{{- define "vpay.bootstrap.apphost" -}}
{{- $dataVirtualize := (set . "template" "vpay.apphost.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "deployment")}}
{{- end -}}

{{- define "vpay.bootstrap.ingress" -}}
{{- $dataVirtualize := (set . "template" "vpay.ingress.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "ingress")}}
{{- end -}}

{{- define "vpay.bootstrap.secret.tls" -}}
{{- $dataVirtualize := (set . "template" "vpay.secret.tls.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "secret")}}
{{- end -}}

{{- define "vpay.bootstrap.secret.opaque" -}}
{{- $dataVirtualize := (set . "template" "vpay.secret.opaque.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "secret")}}
{{- end -}}

{{- define "vpay.bootstrap.secret.smb" -}}
{{ include "vpay.secret.smb.basicAuth.tpl" .}}
{{- end -}}

{{- define "vpay.bootstrap.configmap.filemount" -}}
{{- $dataVirtualize := (set . "template" "vpay.configmap.filemount.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "configmap")}}
{{- end -}}

{{- define "vpay.bootstrap.service" -}}
{{- $dataVirtualize := (set . "template" "vpay.service.tpl") -}}
{{ include "vpay.util.virtualize" (set $dataVirtualize "generateType" "service") }}
{{- end -}}

{{- define "vpay.bootstrap.pv.nfs" -}}
{{ include "vpay.pv.nfs.tpl" . }}
{{- end -}}

{{- define "vpay.bootstrap.pvc.nfs" -}}
{{ include "vpay.pvc.nfs.tpl" . }}
{{- end -}}

{{- define "vpay.bootstrap.pv.smb" -}}
{{ include "vpay.pv.smb.tpl" . }}
{{- end -}}

{{- define "vpay.bootstrap.pvc.smb" -}}
{{ include "vpay.pvc.smb.tpl" . }}
{{- end -}}

helm-gen/templates/_apphost.tpl:
{{- define "vpay.apphost.tpl" -}}
  {{- if (include "vpay.util.trueenabled" .Values.enabled) -}}

  {{- $hasMountedSecrets := false -}}
  {{- range $key, $value := default (dict) .Values.secrets -}}
    {{- if (include "vpay.util.trueenabled" $value.mount) -}}
      {{- $hasMountedSecrets = true -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedConfigMaps := false -}}
  {{- range $key, $value := default (dict) .Values.configMaps -}}
    {{- if (include "vpay.util.trueenabled" $value.mount) -}}
      {{- $hasMountedConfigMaps = true -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedNfs := false -}}
  {{- range $key, $value := default (dict) .Values.mountNfs -}}
    {{- if (not (dig $key ("") (default (dict) $.__GlobalValues.nfsShares))) -}}
      {{- fail (printf "nfsMounts key does not exist for mountNfs mount with name \"%s\"" $key) }}
    {{- end -}}
    {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $.__GlobalValues.nfsShares))) }}
      {{- range $volumeMount := default (list) $value -}}
        {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
          {{- $hasMountedNfs = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedSmb := false -}}
  {{- range $key, $value := default (dict) .Values.mountSmb -}}
    {{- if (not (dig $key ("") (default (dict) $.__GlobalValues.smbShares))) -}}
      {{- fail (printf "nfsMounts key does not exist for mountSmb mount with name \"%s\"" $key) }}
    {{- end -}}
    {{- if (include "vpay.util.trueenabled" (dig $key "enabled" (true) (default (dict) $.__GlobalValues.smbShares))) }}
      {{- range $volumeMount := default (list) $value -}}
        {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
          {{- $hasMountedSmb = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedEmptyDir := false -}}
  {{- range $key, $value := default (dict) .Values.mountEmptyDir -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
        {{- $hasMountedEmptyDir = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $hasMountedPvc := false -}}
  {{- range $key, $value := default (dict) .Values.mountPersistentVolumeClaims -}}
    {{- range $volumeMount := default (list) $value -}}
      {{- if (include "vpay.util.trueenabled" $volumeMount.mount) -}}
        {{- $hasMountedPvc = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $_ := set . "hasMountedVolumes" (or $hasMountedSecrets $hasMountedConfigMaps $hasMountedNfs $hasMountedSmb $hasMountedEmptyDir $hasMountedPvc) }}

  {{- $appKind := default ("Deployment") .Values.kind -}}

  {{- if (eq $appKind "Deployment") -}}
    {{- include "vpay.deployment.tpl" $ -}}
  {{- else if (eq $appKind "CronJob") -}}
    {{- include "vpay.cronjob.tpl" $ -}}
  {{- else -}}
    {{- $failMsg := printf "Unknown application host kind: %s" $appKind -}}
    {{- fail $failMsg -}}
  {{- end -}}

  {{- if (.Values.secretEnv) }}
    {{- include "vpay.secret.secretEnv.tpl" $ }}
  {{- end }}

  {{- end -}}
{{- end -}}


here is the error:
helm upgrade par-process-api . --install --namespace par-process-stage --wait --set-string chart.virtual.shared.image.tag="v1.0.4-deploy2" --set-string chart.virtual.shared.env.RELEASE_COMMIT_SHA="9c3e046f8a66c7446e405f0759d62321fd555ef4" --set-string chart.virtual.shared.env.RELEASE_TAG="v1.0.4-deploy2" --set-string chart.virtual.shared.env.DEPLOYMENT_TIME="Wed\, 04 Jun 2025 23:29:10 +0000" --set-string chart.virtual.shared.env.DEPLOYMENT_DATACENTER="Plano" -f default-env-dc-values.yaml -f values-stage.yaml -f secret-values.yaml --dry-run=true
Error: UPGRADE FAILED: template: par-process-api/templates/bootstrap.yaml:1:3: executing "par-process-api/templates/bootstrap.yaml" at <include "vpay.bootstrap" .>: error calling include: template: par-process-api/charts/helm-gen/templates/_bootstrap.tpl:2:6: executing "vpay.bootstrap" at <include "vpay.bootstrap.apphost" .>: error calling include: template: par-process-api/charts/helm-gen/templates/_bootstrap.tpl:17:3: executing "vpay.bootstrap.apphost" at <include "vpay.util.virtualize" (set $dataVirtualize "generateType" "deployment")>: error calling include: template: par-process-api/charts/helm-gen/templates/_util.tpl:25:49: executing "vpay.util.virtualize" at <deepCopy (pick $.Values $item | values | first)>: error calling deepCopy: reflect: call of reflect.Value.Type on zero Value
