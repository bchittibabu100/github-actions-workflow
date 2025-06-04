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
