name: Build and Deploy Outbound RedCard Queue Processor Service

on:
  workflow_dispatch:
    inputs:
      env:
        description: "Choose the environment(*Make sure no other deployments are in progress)"
        required: true
        default: stage
        type: choice
        options:
          - stage
          - prod
      CHG_TICKET:
        type: string
      WAR_ROOM:
        type: string
        default: 'false'

jobs:
  build:
    runs-on: 
      group: cpay-runner-group
    outputs:
      original_checksum: ${{ steps.checksum.outputs.original_checksum}}
    env:
      VAULT_ADDR: ${{ secrets.PRODVAULT_URL }}
      VAULT_TOKEN: ${{ secrets.PRODVAULT_TOKEN }}
    steps:
      - name: Clean workspace
        run: |
          echo "Cleaning workspace at workspace..."
          REPO_NAME=$(echo ${{ github.repository }} | cut -d'/' -f2)
          pwd
          echo "$REPO_NAME"
          rm -rf /home/gitrunner/actions-runner/_work/$REPO_NAME/*
          ls  /home/gitrunner/actions-runner/_work/$REPO_NAME/
    
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set environment variables
        id: set-env
        run: |
          echo "env_name=${{ github.event.inputs.env }}" >> $GITHUB_ENV
          echo "RELEASE_COMMIT_SHA=${{ github.sha }}" >> $GITHUB_ENV
          echo "IMAGE_BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")" >> $GITHUB_ENV
          echo "RELEASE_TAG=${{ github.ref_name }}" >> $GITHUB_ENV
        shell: bash

      - name: Substitute environment variables
        run: |
          if [ "${{ env.env_name }}" == "stage" ]; then
            export env="stage"
            export DocSysConfigApiUrl="platform-configuration.stg.pks.cpayusa.net"
            export DocSysQueueHostName="stgrmqvip.cpayusa.net"
            export DocSysSqlServerHostname="STGL-DocSys.VPayusa.net"
            export DocSysScpHostName="asstglftp01"
          else
            export env="prod"
            export DocSysConfigApiUrl="platform-configuration.prod.pks.cpayusa.net"
            export DocSysQueueHostName="prdrmqvip.cpayusa.net"
            export DocSysSqlServerHostname="PRDL-DocSys"
            export DocSysScpHostName="plprdlftp01"
          fi
          export DocSysQueueHostPort="5672"
          export DocSysRedCardDataScpServerPath="/home/distsysrc/distsys/internalrc/data/inbound/rcoutbound"
          export DocSysSqlServerDatabase="DocumentSystem"
          echo "$(envsubst < src/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor/appsettings.template-secure.json)" > src/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor/appsettings.secure.json
          vault-helper fill src/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor/appsettings.secure.json
        shell: bash

      - name: Build artifacts
        run: |
          rm -rf outbound saved_outbound saved_outbound.tgz
          echo "BUILD_START_TIME: `date`"
          dotnet restore ./VPay.DocSys.Parsing.sln --configfile legacy-nuget.config
          dotnet publish ./src/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor.csproj -c Release -r centos.7-x64 -o ./outbound
        shell: bash

      - name: Generate checksum for artifacts
        id: checksum
        run: |
          tar -czf saved_outbound.tgz outbound
          original_checksum=$(md5sum saved_outbound.tgz | cut -d' ' -f 1)
          echo "original_checksum=$original_checksum"  >> $GITHUB_ENV
          echo "original_checksum=$original_checksum"  >> $GITHUB_OUTPUT
          echo $original_checksum
        shell: bash

  deploy-stage:
    needs: build
    runs-on:
      group: cpay-runner-group
    steps:
      - name: Download build artifacts
        run: |
          current_checksum=$(md5sum $(pwd)/saved_outbound.tgz | cut -d' ' -f 1)
          if [ "${{ needs.build.outputs.original_checksum }}" == "$current_checksum" ]; then
            mkdir saved_outbound
            tar -xzf saved_outbound.tgz --directory=saved_outbound
          else
            echo "Make sure there are no other builds are in progress."
            exit 1
          fi
        shell: bash

      - name: Deploy and Restart Services on asstglds01.cpayusa.net
        run: |
          ssh bamboosa@asstglds01.cpayusa.net "sudo systemctl stop outbound-redcard-data-driver-queue@*" || echo "Failed to stop service on asstglds01.cpayusa.net"
          scp -r saved_outbound/outbound/* bamboosa@asstglds01.cpayusa.net:/usr/local/cpay/docsys/outbound-redcard-data-driver-queue/ || echo "Failed to copy artifacts to asstglds01.cpayusa.net"
          ssh bamboosa@asstglds01.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/*" || echo "Failed to set permissions on asstglds01.cpayusa.net"
          ssh bamboosa@asstglds01.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor" || echo "Failed to set permissions on asstglds01.cpayusa.net"
          ssh bamboosa@asstglds01.cpayusa.net "sudo chown -R bamboosa:bogner /usr/local/cpay/docsys/outbound-redcard-data-driver-queue" || echo "Failed to set permissions on asstglds01.cpayusa.net"
          ssh bamboosa@asstglds01.cpayusa.net "sudo systemctl reload-or-restart outbound-redcard-data-driver-queue@* --all" || echo "Failed to restart service on asstglds01.cpayusa.net"
        shell: bash

      - name: Deploy and Restart Services on asstglds02.cpayusa.net
        run: |
          ssh bamboosa@asstglds02.cpayusa.net "sudo systemctl stop outbound-redcard-data-driver-queue@*" || echo "Failed to stop service on asstglds02.cpayusa.net"
          scp -r saved_outbound/outbound/* bamboosa@asstglds02.cpayusa.net:/usr/local/cpay/docsys/outbound-redcard-data-driver-queue/ || echo "Failed to copy artifacts to asstglds02.cpayusa.net"
          ssh bamboosa@asstglds02.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/*" || echo "Failed to set permissions on asstglds02.cpayusa.net"
          ssh bamboosa@asstglds02.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor" || echo "Failed to set permissions on asstglds02.cpayusa.net"
          ssh bamboosa@asstglds02.cpayusa.net "sudo chown -R bamboosa:bogner /usr/local/cpay/docsys/outbound-redcard-data-driver-queue" || echo "Failed to set permissions on asstglds02.cpayusa.net"
          ssh bamboosa@asstglds02.cpayusa.net "sudo systemctl reload-or-restart outbound-redcard-data-driver-queue@* --all" || echo "Failed to restart service on asstglds02.cpayusa.net"
        shell: bash

      - name: Deploy and Restart Services on asstglds03.cpayusa.net
        run: |
          ssh bamboosa@asstglds03.cpayusa.net "sudo systemctl stop outbound-redcard-data-driver-queue@*" || echo "Failed to stop service on asstglds03.cpayusa.net"
          scp -r saved_outbound/outbound/* bamboosa@asstglds03.cpayusa.net:/usr/local/cpay/docsys/outbound-redcard-data-driver-queue/ || echo "Failed to copy artifacts to asstglds03.cpayusa.net"
          ssh bamboosa@asstglds03.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/*" || echo "Failed to set permissions on asstglds03.cpayusa.net"
          ssh bamboosa@asstglds03.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor" || echo "Failed to set permissions on asstglds03.cpayusa.net"
          ssh bamboosa@asstglds03.cpayusa.net "sudo chown -R bamboosa:bogner /usr/local/cpay/docsys/outbound-redcard-data-driver-queue" || echo "Failed to set permissions on asstglds03.cpayusa.net"
          ssh bamboosa@asstglds03.cpayusa.net "sudo systemctl reload-or-restart outbound-redcard-data-driver-queue@* --all" || echo "Failed to restart service on asstglds03.cpayusa.net"
        shell: bash

  check_service_now:
    if: ${{ github.event.inputs.env == 'prod' }}
    needs: build
    uses: optum-financial/opay-actions-common-workflow/.github/workflows/snow-validate.yml@main
    with:
      chg-ticket: ${{ inputs.CHG_TICKET }}
      war-room: ${{ inputs.WAR_ROOM }}
    secrets:
      SERVICENOW_API_USER: ${{ secrets.SERVICENOW_API_USER }}
      SERVICENOW_API_PASSWORD: ${{ secrets.SERVICENOW_API_PASSWORD }}

  pass_service_now:
    runs-on: chg-runner
    needs: check_service_now
    if: ${{ github.event.inputs.env == 'prod' && always() && !failure() && !cancelled() }}
    steps:
      - name: Check SNow ticket
        run: |
          if [[ "${{ needs.check_service_now.outputs.pass }}" != "true" ]];
          then
            echo "Invalid Service Now Change Ticket"
            exit 1
          fi
        shell: bash

  deploy-prod:
    if: ${{ github.event.inputs.env == 'prod' }}
    needs: pass_service_now
    runs-on:
      group: cpay-runner-group
    steps:
      - name: Download build artifacts
        run: |
          current_checksum=$(md5sum $(pwd)/saved_outbound.tgz | cut -d' ' -f 1)
          if [ "${{ needs.build.outputs.original_checksum }}" == "$current_checksum" ]; then
            mkdir saved_outbound
            tar -xzf saved_outbound.tgz --directory=saved_outbound
          else
            echo "Make sure there are no other builds are in progress."
            exit 1
          fi
        shell: bash

      - name: Deploy and Restart Services on plprdlds01.cpayusa.net
        run: |
          ssh bamboosa@plprdlds01.cpayusa.net "sudo systemctl stop outbound-redcard-data-driver-queue@*" || echo "Failed to stop service on plprdlds01.cpayusa.net"
          scp -r saved_outbound/outbound/* bamboosa@plprdlds01.cpayusa.net:/usr/local/cpay/docsys/outbound-redcard-data-driver-queue/ || echo "Failed to copy artifacts to plprdlds01.cpayusa.net"
          ssh bamboosa@plprdlds01.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/*" || echo "Failed to set permissions on plprdlds01.cpayusa.net"
          ssh bamboosa@plprdlds01.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor" || echo "Failed to set permissions on plprdlds01.cpayusa.net"
          ssh bamboosa@plprdlds01.cpayusa.net "sudo chown -R bamboosa:bogner /usr/local/cpay/docsys/outbound-redcard-data-driver-queue" || echo "Failed to set permissions on plprdlds01.cpayusa.net"
          ssh bamboosa@plprdlds01.cpayusa.net "sudo systemctl reload-or-restart outbound-redcard-data-driver-queue@* --all" || echo "Failed to restart service on plprdlds01.cpayusa.net"
        shell: bash

      - name: Deploy and Restart Services on plprdlds02.cpayusa.net
        run: |
          ssh bamboosa@plprdlds02.cpayusa.net "sudo systemctl stop outbound-redcard-data-driver-queue@*" || echo "Failed to stop service on plprdlds02.cpayusa.net"
          scp -r saved_outbound/outbound/* bamboosa@plprdlds02.cpayusa.net:/usr/local/cpay/docsys/outbound-redcard-data-driver-queue/ || echo "Failed to copy artifacts to plprdlds02.cpayusa.net"
          ssh bamboosa@plprdlds02.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/*" || echo "Failed to set permissions on plprdlds02.cpayusa.net"
          ssh bamboosa@plprdlds02.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor" || echo "Failed to set permissions on plprdlds02.cpayusa.net"
          ssh bamboosa@plprdlds02.cpayusa.net "sudo chown -R bamboosa:bogner /usr/local/cpay/docsys/outbound-redcard-data-driver-queue" || echo "Failed to set permissions on plprdlds02.cpayusa.net"
          ssh bamboosa@plprdlds02.cpayusa.net "sudo systemctl reload-or-restart outbound-redcard-data-driver-queue@* --all" || echo "Failed to restart service on plprdlds02.cpayusa.net"
        shell: bash

      - name: Deploy and Restart Services on plprdlds03.cpayusa.net
        run: |
          ssh bamboosa@plprdlds03.cpayusa.net "sudo systemctl stop outbound-redcard-data-driver-queue@*" || echo "Failed to stop service on plprdlds03.cpayusa.net"
          scp -r saved_outbound/outbound/* bamboosa@plprdlds03.cpayusa.net:/usr/local/cpay/docsys/outbound-redcard-data-driver-queue/ || echo "Failed to copy artifacts to plprdlds03.cpayusa.net"
          ssh bamboosa@plprdlds03.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/*" || echo "Failed to set permissions on plprdlds03.cpayusa.net"
          ssh bamboosa@plprdlds03.cpayusa.net "sudo chmod -R 755 /usr/local/cpay/docsys/outbound-redcard-data-driver-queue/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor" || echo "Failed to set permissions on plprdlds03.cpayusa.net"
          ssh bamboosa@plprdlds03.cpayusa.net "sudo chown -R bamboosa:bogner /usr/local/cpay/docsys/outbound-redcard-data-driver-queue" || echo "Failed to set permissions on plprdlds03.cpayusa.net"
          ssh bamboosa@plprdlds03.cpayusa.net "sudo systemctl reload-or-restart outbound-redcard-data-driver-queue@* --all" || echo "Failed to restart service on plprdlds03.cpayusa.net"
        shell: bash
