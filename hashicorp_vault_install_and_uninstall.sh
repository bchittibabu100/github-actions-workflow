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

jobs:
  build-and-deploy-parsing-api:
    runs-on:
      group: vpay-runner-group
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
          sed -i "s/\[\[GitRevision\]\]/${{ env.RELEASE_COMMIT_SHA }}/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
          sed -i "s/\[\[BuildTime\]\]/${{ env.IMAGE_BUILD_TIME }}/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
          sed -i "s/\[\[VersionInfo\]\]/${{ env.RELEASE_TAG }}/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
          sed -i "s/\[\[DataCenter\]\]/plano/g" src/VPay.DocSys.Parsing.Api/AboutInfo.cs
        shell: bash

      - name: Substitue staging environment variables
        if: env.env_name == 'stage'
        run: |
          export VAULT_ADDR=${{ secrets.PRODVAULT_URL }}
          export VAULT_TOKEN=${{ secrets.PRODVAULT_TOKEN }}
          export env="stage"
          export DocSysConfigApiUrl="platform-configuration.stg.pks.vpayusa.net"
          export DocSysQueueHostName="asstglrbmq01.vpayusa.net, asstglrbmq02.vpayusa.net, asstglrbmq03.vpayusa.net"
          export DocSysQueueHostPort="5672"
          export DocSysRedCardDataScpServerPath="/home/distsysrc/distsys/internalrc/data/inbound/rcoutbound"
          export DocSysScpHostName="asstglftp01"
          export DocSysSqlServerDatabase="DocumentSystem"
          export DocSysSqlServerHostname="STGL-DocSys.VPayusa.net"
          echo "$(envsubst < src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json)" > src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json
          vault-helper fill src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json
        
      - name: Substitue production environment variables
        if: env.env_name == 'prod'
        run: |
          export VAULT_ADDR=${{ secrets.PRODVAULT_URL }}
          export VAULT_TOKEN=${{ secrets.PRODVAULT_TOKEN }}
          export env="prod"
          export DocSysConfigApiUrl="platform-configuration.prod.pks.vpayusa.net"
          export DocSysQueueHostName="plprdlrbmq01.vpayusa.net, plprdlrbmq02.vpayusa.net, plprdlrbmq03.vpayusa.net"
          export DocSysQueueHostPort="5672"
          export DocSysRedCardDataScpServerPath="/home/distsysrc/distsys/internalrc/data/inbound/rcoutbound"
          export DocSysScpHostName="srvftp01"
          export DocSysSqlServerDatabase="DocumentSystem"
          export DocSysSqlServerHostname="PRDL-DocSys"
          echo "$(envsubst < src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json)" > src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json
          vault-helper fill src/VPay.DocSys.Parsing.Api/appsettings.template-secure.json

      - name: Build artifacts
        run: |
          dotnet restore ./VPay.DocSys.Parsing.sln --configfile legacy-nuget.config
          dotnet publish ./src/VPay.DocSys.Parsing.Api/VPay.DocSys.Parsing.Api.csproj -c Release -r centos.7-x64 -o ./artifacts
        shell: bash

      - name: Copy artifacts to asstglds01
        if: env.env_name == 'stage'
        run: |
          scp artifacts/* bamboosa@asstglds01.vpayusa.net:/usr/local/vpay/docsys/parsing || echo "Failed to copy artifacts to asstglds01"
        shell: bash

      - name: Copy artifacts to asstglds02
        if: env.env_name == 'stage'
        run: |
          scp artifacts/* bamboosa@asstglds02.vpayusa.net:/usr/local/vpay/docsys/parsing || echo "Failed to copy artifacts to asstglds02"
        shell: bash

      - name: Copy artifacts to asstglds03
        if: env.env_name == 'stage'
        run: |
          scp artifacts/* bamboosa@asstglds03.vpayusa.net:/usr/local/vpay/docsys/parsing || echo "Failed to copy artifacts to asstglds03"
        shell: bash

      - name: Restart Parsing API service on asstglds01
        if: env.env_name == 'stage'
        run: |
          ssh bamboosa@asstglds01.vpayusa.net "sudo systemctl reload-or-restart kestrel-vpay-docsys-parsing-api.service" || echo "Failed to restart service on asstglds01"
        shell: bash

      - name: Restart Parsing API service on asstglds02
        if: env.env_name == 'stage'
        run: |
          ssh bamboosa@asstglds02.vpayusa.net "sudo systemctl reload-or-restart kestrel-vpay-docsys-parsing-api.service" || echo "Failed to restart service on asstglds01"
        shell: bash

      - name: Restart Parsing API service on asstglds03
        if: env.env_name == 'stage'
        run: |
          ssh bamboosa@asstglds03.vpayusa.net "sudo systemctl reload-or-restart kestrel-vpay-docsys-parsing-api.service" || echo "Failed to restart service on asstglds01"
        shell: bash

      - name: Copy artifacts to plprdlds01
        if: env.env_name == 'prod'
        run: |
          scp artifacts/* bamboosa@plprdlds01.vpayusa.net:/usr/local/vpay/docsys/parsing || echo "Failed to copy artifacts to plprdlds01"
        shell: bash

      - name: Copy artifacts to plprdlds02
        if: env.env_name == 'prod'
        run: |
          scp artifacts/* bamboosa@plprdlds02.vpayusa.net:/usr/local/vpay/docsys/parsing || echo "Failed to copy artifacts to plprdlds02"
        shell: bash

      - name: Copy artifacts to plprdlds03
        if: env.env_name == 'prod'
        run: |
          scp artifacts/* bamboosa@plprdlds03.vpayusa.net:/usr/local/vpay/docsys/parsing || echo "Failed to copy artifacts to plprdlds03"
        shell: bash

      - name: Restart Parsing API service on plprdlds01
        if: env.env_name == 'prod'
        run: |
          ssh bamboosa@plprdlds01.vpayusa.net "sudo systemctl reload-or-restart kestrel-vpay-docsys-parsing-api.service" || echo "Failed to restart service on plprdlds01"
        shell: bash

      - name: Restart Parsing API service on plprdlds02
        if: env.env_name == 'prod'
        run: |
          ssh bamboosa@plprdlds02.vpayusa.net "sudo systemctl reload-or-restart kestrel-vpay-docsys-parsing-api.service" || echo "Failed to restart service on plprdlds02"
        shell: bash

      - name: Restart Parsing API service on plprdlds03
        if: env.env_name == 'prod'
        run: |
          ssh bamboosa@plprdlds03.vpayusa.net "sudo systemctl reload-or-restart kestrel-vpay-docsys-parsing-api.service" || echo "Failed to restart service on plprdlds03"
        shell: bash
