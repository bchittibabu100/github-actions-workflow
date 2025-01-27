name: helm-build-and-deploy-to-dev
on:
  workflow_dispatch:
  push:
    tags:
      - "*"

jobs:
  sonar:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/sonar-analysis.yml@main
    secrets:
      SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
      
  payment-routing-api:
    needs: sonar
    if: always()
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: quantum
      IMAGE_NAME: payment-routing-api
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/cpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/payment-routing-api/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  pay-routing-inbound-proc:
    needs: sonar
    if: always()
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: quantum
      IMAGE_NAME: pay-routing-inbound-proc
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/cpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/pay-routing-inbound-proc/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  outbound835-proc:
    needs: sonar
    if: always()
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: quantum
      IMAGE_NAME: outbound835-proc
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/cpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/outbound835-proc/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  apmesssage-proc:
    needs: sonar
    if: always()
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: quantum
      IMAGE_NAME: apmesssage-proc
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/cpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/apmessage-proc/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  raf-message-proc:
    needs: sonar
    if: always()
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: quantum
      IMAGE_NAME: raf-message-proc
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/cpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/raf-message-proc/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  deployment-plano-dev-dryrun:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-plano-dev.yml@main
    needs: [payment-routing-api,pay-routing-inbound-proc,outbound835-proc,apmesssage-proc,raf-message-proc]
    with:
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-dev
      RELEASE_NAME: payment-routing
      DRYRUN: true
    secrets: inherit
  deployment-stl-dev-dryrun:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-stl-dev.yml@main
    needs: [payment-routing-api,pay-routing-inbound-proc,outbound835-proc,apmesssage-proc,raf-message-proc]
    with:
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-dev
      RELEASE_NAME: payment-routing
      DRYRUN: true
    secrets: inherit
  deployment-plano-stage-dryrun:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-plano-stage.yml@main
    needs: [payment-routing-api,pay-routing-inbound-proc,outbound835-proc,apmesssage-proc,raf-message-proc]
    with:
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-stage
      RELEASE_NAME: payment-routing
      DRYRUN: true
    secrets: inherit
  deployment-stl-stage-dryrun:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-stl-stage.yml@main
    needs: [payment-routing-api,pay-routing-inbound-proc,outbound835-proc,apmesssage-proc,raf-message-proc]
    with:
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-stage
      RELEASE_NAME: payment-routing
      DRYRUN: true
    secrets: inherit
  deployment-plano-prod-dryrun:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-plano-prod.yml@main
    needs: [payment-routing-api, pay-routing-inbound-proc, outbound835-proc, apmesssage-proc, raf-message-proc]
    with: 
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-prod 
      RELEASE_NAME: payment-routing
      DRYRUN: true
    secrets: inherit 
  deployment-stl-prod-dryrun:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-stl-prod.yml@main
    needs: [payment-routing-api, pay-routing-inbound-proc, outbound835-proc, apmesssage-proc, raf-message-proc]
    with: 
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-prod
      RELEASE_NAME: payment-routing
      DRYRUN: true
    secrets: inherit   
  deployment-plano-dev:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-plano-dev.yml@main
    needs: [deployment-plano-dev-dryrun, deployment-stl-dev-dryrun]
    with:
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-dev
      RELEASE_NAME: payment-routing
      DRYRUN: false
    secrets: inherit
  deployment-stl-dev:
    uses: quantum-financial/cpay-actions-common-workflow/.github/workflows/helm-deploy-stl-dev.yml@main
    needs: [deployment-plano-dev-dryrun, deployment-stl-dev-dryrun]
    with:
      CHARTS_PATH: charts/payment-routing
      NAMESPACE: quantum-dev
      RELEASE_NAME: payment-routing
      DRYRUN: false
    secrets: inherit
    
    
even though the sonar is failed but build jobs of "payment-routing-api, pay-routing-inbound-proc, outbound835-proc, apmesssage-proc, raf-message-proc" succeeded. But deployment jobs are being skipped.
