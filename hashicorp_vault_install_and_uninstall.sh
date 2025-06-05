helm template par-process-api . -f default-env-dc-values.yaml -f values-stage.yaml -f secret-values.yaml --set chart.virtual.charts={par-process-api} --dry-run
Error: template: par-process-api/templates/bootstrap.yaml:1:3: executing "par-process-api/templates/bootstrap.yaml" at <include "vpay.bootstrap" .>: error calling include: template: par-process-api/charts/helm-gen/templates/_bootstrap.tpl:2:6: executing "vpay.bootstrap" at <include "vpay.bootstrap.apphost" .>: error calling include: template: par-process-api/charts/helm-gen/templates/_bootstrap.tpl:17:3: executing "vpay.bootstrap.apphost" at <include "vpay.util.virtualize" (set $dataVirtualize "generateType" "deployment")>: error calling include: template: par-process-api/charts/helm-gen/templates/_util.tpl:25:49: executing "vpay.util.virtualize" at <deepCopy (pick $.Values $item | values | first)>: error calling deepCopy: reflect: call of reflect.Value.Type on zero Value


default-env-dc-values.yaml file contents:
global:
  environment:
    name: Staging
    ingress:
      subdomain: stg.pks.test.net
      altSubdomains:
      - plpksstg.vpayusa.net
chart:
  virtual:
    shared:
      image:
        registry: docker.repo1.test.com/vpay-docker


values-stage.yaml file contents:
par-process-api:
  environment:
    ingress:
      domains:
        - par-process-api.stg.test.net
        

secret-values.yaml file contents:
par-process-api:
  # Add your secret fields below. For example:
  # dbPassword: "<your-database-password>"
  # apiKey: "<your-api-key>"
  # secretToken: "<your-secret-token>"
