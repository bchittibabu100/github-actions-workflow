name: helm-build-and-deploy-to-dev
on:
  workflow_dispatch:
  push:
    tags:
      - "*"

jobs:
  sonar:
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/sonar-analysis.yml@main
    secrets:
      SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
  bootstrap:
    needs: sonar
    if: always()
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: newplatform
      IMAGE_NAME: account-balancing-bootstrap
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/vpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/bootstrap/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  api:
    needs: sonar
    if: always()
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: newplatform
      IMAGE_NAME: account-balancing-api
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/vpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/api/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  queue-consumer:
    needs: sonar
    if: always()
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@main
    with:
      PROJECT: newplatform
      IMAGE_NAME: queue-consumer
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.uhc.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.uhc.com/vpay-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/queue-consumer/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
  deployment-plano-dev-dryrun:
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/helm-deploy-plano-dev.yml@main
    needs: [bootstrap, api, queue-consumer]
    with:
      CHARTS_PATH: charts/account-balancing
      NAMESPACE: account-balancing-api-dev
      RELEASE_NAME: accountbalancing
      DRYRUN: true
    secrets: inherit
  deployment-stl-dev-dryrun:
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/helm-deploy-stl-dev.yml@main
    needs: [bootstrap, api, queue-consumer]
    with:
      CHARTS_PATH: charts/account-balancing
      NAMESPACE: account-balancing-api-dev
      RELEASE_NAME: accountbalancing
      DRYRUN: true
    secrets: inherit
  deployment-plano-stage-dryrun:
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/helm-deploy-plano-stage.yml@main
    needs: [bootstrap, api, queue-consumer]
    with:
      CHARTS_PATH: charts/account-balancing
      NAMESPACE: account-balancing-api-stage
      RELEASE_NAME: accountbalancing
      DRYRUN: true
    secrets: inherit
  deployment-stl-stage-dryrun:
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/helm-deploy-stl-stage.yml@main
    needs: [bootstrap, api, queue-consumer]
    with:
      CHARTS_PATH: charts/account-balancing
      NAMESPACE: account-balancing-api-stage
      RELEASE_NAME: accountbalancing
      DRYRUN: true
    secrets: inherit
  deployment-plano-dev:
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/helm-deploy-plano-dev.yml@main
    needs: [deployment-plano-dev-dryrun, deployment-stl-dev-dryrun]
    with:
      CHARTS_PATH: charts/account-balancing
      NAMESPACE: account-balancing-api-dev
      RELEASE_NAME: accountbalancing
      DRYRUN: false
    secrets: inherit
  deployment-stl-dev:
    uses: test-repo/vpay-actions-common-workflow/.github/workflows/helm-deploy-stl-dev.yml@main
    needs: [deployment-plano-dev-dryrun, deployment-stl-dev-dryrun]
    with:
      CHARTS_PATH: charts/account-balancing
      NAMESPACE: account-balancing-api-dev
      RELEASE_NAME: accountbalancing
      DRYRUN: false
    secrets: inherit

Sonar failed. But why other jobs are failing eventhough api, bootstrap and queue-consumer succeeded ?
