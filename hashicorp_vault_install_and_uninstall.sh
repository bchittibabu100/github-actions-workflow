name: List Azure Images
on:
  push:
    branches:
      - install-awx-installer-on-aks

permissions:
  id-token: write
  contents: read

jobs:
  list-images:
    runs-on: cg-runner
    environment: eph

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Check AZ
        run: az version

      - name: Azure login
        uses: azure/login@v2
        with:
          tenant-id: ${{ vars.PMNTS_AZURE_TENANT_ID }}
          client-id: ${{ vars.OPAY_AZURE_CLIENT_ID }}
          subscription-id: ${{ vars.OPAY_AZURE_SUBSCRIPTION_ID }}

      - name: List Azure Images
        uses: azure/cli@v2
        with:
          azcliversion: latest
          inlineScript: |
            az account show
            az sig image-version list --resource-group prod_golden_image_azu_gallery --gallery-name prod_golden_image_azu_gallery --gallery-image-definition RHEL_9 --output table


logs:
Run azure/cli@v2
  
Starting script execution via docker image mcr.microsoft.com/azure-cli:latest
ERROR: Please run 'az login' to setup account.
Error: Error: az cli script failed.
cleaning up container...
MICROSOFT_AZURE_CLI_1753419720190_CONTAINER
Error: az cli script failed.
