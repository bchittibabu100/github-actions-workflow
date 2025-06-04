Here is the contents of values.yaml


chart:
  virtual:
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
      env:
        ASPNETCORE_ENVIRONMENT: '{{ .Values.global.environment.name }}'
        DOTNET_ENVIRONMENT: '{{ .Values.global.environment.name }}'
    charts:
      - par-process-api

global:
  parent: 'par-process'
  environment:
    name: Development
    ingress:
      subdomain: dev.pks.test.net
nfsShares:
  enabled: false

par-process-api:
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


Error:
template: par-process-api/templates/bootstrap.yaml:1:3: executing "par-process-api/templates/bootstrap.yaml" at <include "vpay.bootstrap" .>: error calling include: template: par-process-api/charts/helm-gen/templates/_bootstrap.tpl:2:6: executing "vpay.bootstrap" at <include "vpay.bootstrap.apphost" .>: error calling include: template: par-process-api/charts/helm-gen/templates/_bootstrap.tpl:17:3: executing "vpay.bootstrap.apphost" at <include "vpay.util.virtualize" (set $dataVirtualize "generateType" "deployment")>: error calling include: template: par-process-api/charts/helm-gen/templates/_util.tpl:25:49: executing "vpay.util.virtualize" at <deepCopy (pick $.Values $item | values | first)>: error calling deepCopy: reflect: call of reflect.Value.Type on zero Value
2025-06-04T17:30:10.9111051Z ##[error]Process completed with exit code 1.
