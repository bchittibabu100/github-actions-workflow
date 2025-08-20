Here is the updated workflow. But still nothing shows up in the xray_scan job.

name: Get Production Image details from Repo1

on:
  push:
  workflow_dispatch: 
    inputs:
      DEFAULT_VALUES_ENVIRONMENT_NAME: 
        description: "Environment name"
        required: true
        default: "prod"
      DRYRUN:
        description: "Dry run?"
        required: false
        default: false
        type: boolean
      CLUSTER_NAME: 
        description: "Kube context cluster name between 'stl' or 'pl'"
        required: true
        default: "pl"
      CONTEXT_NAME:
        description: "Kube context name"
        required: true
        default: "plprod"

jobs:
  deploy:
    name: Get Image List
    runs-on:
      group: vpay-runner-group

    outputs:
      encoded_images: ${{ steps.encode.outputs.encoded }}

    steps:
      - uses: actions/checkout@v4
        with:
          clean: true

      - name: Set Kube context
        uses: azure/k8s-set-context@v3
        with:
          method: kubeconfig
          kubeconfig: ${{ secrets.AVPAY_KUBECONFIG }}
          context: ${{ 
            github.event.inputs.DEFAULT_VALUES_ENVIRONMENT_NAME == 'Dev' && (github.event.inputs.CLUSTER_NAME == 'pl' && 'pldev' || 'stldev') ||
            github.event.inputs.DEFAULT_VALUES_ENVIRONMENT_NAME == 'Staging' && (github.event.inputs.CLUSTER_NAME == 'pl' && 'plstage' || 'stlstage') ||
            (github.event.inputs.CLUSTER_NAME == 'stl' && 'stlprod' || 'plprod')}}
          cluster-type: generic

      - name: Set image file variables
        run: |
          if [ "${{ github.event.inputs.DEFAULT_VALUES_ENVIRONMENT_NAME }}" = "Dev" ]; then
            echo "NS_FILE=PKS/dev_namespace.txt" >> $GITHUB_ENV
          elif [ "${{ github.event.inputs.DEFAULT_VALUES_ENVIRONMENT_NAME }}" = "Staging" ]; then
            echo "NS_FILE=PKS/stage_namespace.txt" >> $GITHUB_ENV
          else
            echo "NS_FILE=PKS/prod_namespace.txt" >> $GITHUB_ENV
          fi


      - name: Get repo1 images list
        id: encode
        run: |
          images_list=$(
            while IFS= read -r namespace; do
              kubectl get pods -n "$namespace" -o jsonpath="{range .items[*]}{range .spec.containers[*]}{.image}{'\n'}{end}{end}" 2>/dev/null
            done < "$NS_FILE" | grep 'docker.repo1.uhc.com' | sort -u
          )
          json_array=$(printf '%s\n' "$images_list" | jq -R . | jq -s .)
          encoded=$(echo "$json_array" | base64 | tr -d '\n')

          echo "Images found:"
          echo "$images_list"
          echo "JSON array:"
          echo "$json_array"
          echo "Encoded output:"
          echo "$encoded"

          echo "encoded=$encoded" >> $GITHUB_OUTPUT

  xray_scan:
    needs: deploy
    runs-on: uhg-runner

    steps:
      - name: Debug encoded output
        run: |
          echo "Encoded output from deploy job:"
          echo "${{ needs.deploy.outputs.encoded_images }}"
