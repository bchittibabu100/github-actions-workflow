name: helm-deploy-plano-stage

on: 
  workflow_call:
    secrets:
      TPAY_KUBECONFIG:
        required: true
      STAGE_VAULT_TOKEN:
        required: true
    inputs:
      DRYRUN:
        required: true
        type: boolean

jobs:
  helm-deployment-plano-stage:
    uses: test-pro/tpay-actions-common-workflow/.github/workflows/helm-deploy.yml@main
    with: 
      VAULT_URL: ${{ vars.TPAY_PROD_VAULT_URL }}
      DRYRUN: ${{inputs.DRYRUN}}
    secrets:
      AVPAY_KUBECONFIG: ${{ secrets.TPAY_KUBECONFIG }}
      VAULT_TOKEN: ${{ secrets.STAGE_VAULT_TOKEN }}
