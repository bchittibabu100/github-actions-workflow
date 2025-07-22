Error: AADSTS700213: No matching federated identity record found for presented assertion subject 'repo:chk-financial/commpay-infrastructure-terraform:ref:refs/heads/install-awx-installer-on-aks'. Check your federated identity credential Subject, Audience and Issuer against the presented assertion. https://learn.microsoft.com/entra/workload-id/workload-identity-federation Trace ID: 38c7c888-532a-4028-bd8b-8214a7e38e00 Correlation ID: f0a35f48-04a1-42bf-b00f-75bc9e59bdcd Timestamp: 2025-07-22 17:58:49Z

Error: Interactive authentication is needed. Please run:
az login

Error: Login failed with Error: The process '/usr/bin/az' failed with exit code 1. Double check if the 'auth-type' is correct. Refer to https://github.com/Azure/login#readme for more information.


workflow:
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
    runs-on: uhg-runner

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Azure login
        uses: azure/login@v2
        with:
          tenant-id: ${{ vars.PMNTS_AZURE_TENANT_ID }}
          client-id: ${{ vars.OPAY_AZURE_CLIENT_ID }}
          subscription-id: ${{ vars.OPAY_AZURE_SUBSCRIPTION_ID }}
          allow-no-subscriptions: true

update workflow based on following Azure OIDC configuration
Issuer: https://token.actions.githubusercontent.com
Orginzation: chk
Repository: commpay-infrastructure-terraform
Entity type: Environment
GitHub environment name: eph

Credentials details
Name: commpay-infrastructure-terraform




