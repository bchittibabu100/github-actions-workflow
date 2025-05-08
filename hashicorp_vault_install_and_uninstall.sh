Here is the content of _metadata.yaml

test@plinfldops02 ~/defaul_helm_templates/helm-gen/templates $ cat _metadata.tpl
{{- /*
Creates a standard metadata header with name and labels.
A suffix can be passed in to adjust the name.
*/ -}}
{{- define "vpay.metadata" -}}
  {{- $base := include "vpay.name" . -}}
  {{- $suf := default "" .suffix -}}
  {{- $name := printf "%s-%s" $base $suf -}}
metadata:
  name: {{ $name | lower | trimSuffix "-" }}
  labels: {{ include "vpay.labels.standard" . | nindent 4 -}}
{{- end -}}

getting error as..
2025-05-08T01:04:09.2210589Z helm upgrade remittance-partner-network . --install --namespace docsys-dev --wait --set-string chart.virtual.shared.image.tag="v1.0.1-devops2" --set-string chart.virtual.shared.env.RELEASE_COMMIT_SHA="7aafed3a2f9f40bedf2ccb85c09148986594a11e" --set-string chart.virtual.shared.env.RELEASE_TAG="v1.0.1-devops2" --set-string chart.virtual.shared.env.DEPLOYMENT_TIME="Thu\, 08 May 2025 01:04:08 +0000" --set-string chart.virtual.shared.env.DEPLOYMENT_DATACENTER="Plano" -f default-env-dc-values.yaml -f values-dev.yaml -f secret-values.yaml
2025-05-08T01:04:09.3639961Z Release "remittance-partner-network" does not exist. Installing it now.
2025-05-08T01:04:10.9570170Z Error: ConfigMap "remittance-partner-network-opay-remittance-partner-network-configmaps" is invalid: metadata.labels: Invalid value: "remittance-partner-network-remittance-partner-network-development": must be no more than 63 characters
