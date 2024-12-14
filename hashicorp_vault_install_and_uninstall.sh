name: Build and Deploy Parsing API Service

on:
  workflow_dispatch:
    inputs:
      env:
        description: "Choose the environment"
        required: true
        default: stage
        type: choice
        options:
          - stage
          - prod
  push:
    branches:
      - offload_from_bamboo

jobs:
  build-and-deploy-parsing-api:
    runs-on:
      group: vpay-runner-group
    env:
      VAULT_ADDR: ${{ secrets.PRODVAULT_URL }}
      VAULT_TOKEN: ${{ secrets.PRODVAULT_TOKEN }}
    strategy:
      matrix:
        host:
          - asstglds01.vpayusa.net
          - asstglds02.vpayusa.net
          - asstglds03.vpayusa.net
          - plprdlds01.vpayusa.net
          - plprdlds02.vpayusa.net
          - plprdlds03.vpayusa.net
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Set environment variables
        id: set-env
        run: |
          echo "env_name=${{ github.event.inputs.env }}" >> $GITHUB_ENV
          echo "RELEASE_COMMIT_SHA=${{ github.sha }}" >> $GITHUB_ENV
          echo "IMAGE_BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")" >> $GITHUB_ENV
          echo "RELEASE_TAG=${{ github.ref_name }}" >> $GITHUB_ENV
        shell: bash

      - name: Replace placeholders in AboutInfo.cs
        run: |
          sed -i "s/GitRevision/${{ env.RELEASE_COMMIT_SHA }}/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
          sed -i "s/BuildTime/${{ env.IMAGE_BUILD_TIME }}/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
          sed -i "s/VersionInfo/${{ env.RELEASE_TAG }}/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
          sed -i "s/DataCenter/plano/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
        shell: bash

      - name: Substitute environment variables
        run: |
          if [ "${{ env.env_name }}" == "stage" ]; then
            export DocSysConfigApiUrl="platform-configuration.stg.pks.vpayusa.net"
            export DocSysQueueHostName="asstglrbmq01.vpayusa.net,asstglrbmq02.vpayusa.net,asstglrbmq03.vpayusa.net"
            export DocSysSqlServerHostname="STGL-DocSys.VPayusa.net"
          else
            export DocSysConfigApiUrl="platform-configuration.prod.pks.vpayusa.net"
            export DocSysQueueHostName="plprdlrbmq01.vpayusa.net,plprdlrbmq02.vpayusa.net,plprdlrbmq03.vpayusa.net"
            export DocSysSqlServerHostname="PRDL-DocSys"
          fi
          export DocSysQueueHostPort="5672"
          export DocSysRedCardDataScpServerPath="/home/distsysrc/distsys/internalrc/data/inbound/rcoutbound"
          echo "$(envsubst < src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json)" > src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json
          vault-helper fill src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json
        shell: bash

      - name: Build artifacts
        run: |
          dotnet restore ./VPay.DocSys.Parsing.sln --configfile legacy-nuget.config
          dotnet publish ./src/VPay.DocSys.Parsing.Api/VPay.DocSys.Parsing.Api.csproj -c Release -r centos.7-x64 -o ./artifacts
        shell: bash

      - name: Deploy and Restart Services
        run: |
          # Filter hosts based on environment
          if [[ "${{ matrix.host }}" == *"stg"* && "${{ env.env_name }}" == "stage" ]] || \
             [[ "${{ matrix.host }}" == *"prd"* && "${{ env.env_name }}" == "prod" ]]; then
            echo "Deploying to ${{ matrix.host }}"
            scp artifacts/* bamboosa@${{ matrix.host }}:/usr/local/vpay/docsys/parsing || echo "Failed to copy artifacts to ${{ matrix.host }}"
            ssh bamboosa@${{ matrix.host }} "sudo systemctl reload-or-restart kestrel-vpay-docsys-parsing-api.service" || echo "Failed to restart service on ${{ matrix.host }}"
          else
            echo "Skipping ${{ matrix.host }} for environment ${{ env.env_name }}"
          fi
        shell: bash
