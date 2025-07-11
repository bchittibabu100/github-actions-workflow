name: Deploy AWX

on:
  workflow_dispatch:
    inputs:
      environment:
        description: "Environment name (e.g. dev, stg, prod)"
        required: true
        default: "dev"
      cluster_name:
        description: "AKS cluster name"
        required: true

env:
  LOCATION: centralus
  RESOURCE_GROUP: rg-${{ github.event.inputs.environment }}-hub-centralus
  NAMESPACE: awx
  AWX_REPO: https://github.com/ansible/awx-operator.git
  AWX_TAG: 2.19.1
  NODEPOOL_NAME: awxpool
  NODEPOOL_VM_SIZE: Standard_D2ps_v6
  TAINT_KEY: awx
  TAINT_VALUE: true
  TAINT_EFFECT: NoSchedule

jobs:
  create-nodepool:
    name: Create AKS Node Pool
    runs-on: ubuntu-latest

    steps:
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Create AWX Node Pool with Taints
        run: |
          az aks nodepool add \
            --resource-group $RESOURCE_GROUP \
            --cluster-name ${{ github.event.inputs.cluster_name }} \
            --name $NODEPOOL_NAME \
            --node-count 1 \
            --node-vm-size $NODEPOOL_VM_SIZE \
            --labels workload=awx \
            --aks-custom-headers UseGPUDedicatedVHD=true \
            --node-taints $TAINT_KEY=$TAINT_VALUE:$TAINT_EFFECT \
            --zones 1 \
            --mode User

  install-awx:
    name: Deploy AWX to AKS
    runs-on: ubuntu-latest
    needs: create-nodepool

    steps:
      - name: Checkout AWX Installer
        run: |
          git clone --depth 1 --branch $AWX_TAG $AWX_REPO
          cd awx-operator
          echo "Cloned tag $AWX_TAG"

      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Get AKS Credentials
        run: |
          az aks get-credentials \
            --name ${{ github.event.inputs.cluster_name }} \
            --resource-group $RESOURCE_GROUP \
            --overwrite-existing

      - name: Create Namespace
        run: |
          kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

      - name: Deploy AWX Operator
        run: |
          cd awx-operator
          make deploy NAMESPACE=$NAMESPACE

      - name: Apply AWX Custom Resource
        run: |
          kubectl apply -f awx-deploy.yaml -n $NAMESPACE
