workflow-1
----------
name: helm-build-and-deploy-to-dev
on: 
  workflow_dispatch:
  push:
    tags:
    - '*'

jobs:
  build-and-publish:
    uses: test-financial/test-actions-common-workflow/.github/workflows/docker-build-and-publish.yml@sonar-scan-poc
    with: 
      PROJECT: test-api
      IMAGE_NAME: test-web-api
      BUILD_ARGS: "PROJECT_DIR PROJECT_NAME"
      DOCKER_URL: "docker.repo1.test.com"
      DOCKER_USERNAME: ${{ vars.PMNTS_DEVOPS_MSA }}
      DOCKER_REGISTRY_URL: "docker.repo1.test.com/test-docker"
      BUILD_ARGS_ENV_FILE_PATH: .github/build-args/
    secrets:
      DOCKER_PASSWORD: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}

workflow-2
----------
name: build-and-publish

on:
  workflow_call:
    secrets:
      DOCKER_PASSWORD:
        required: true      
        
    inputs:
      DOCKER_URL:
        required: true
        type: string
      DOCKER_USERNAME:
        required: true
        type: string
      # From .gitlab-ci.yml variables.PROJECT
      PROJECT:
        required: true
        type: string
      # From .gitlab-ci.yml variables.IMAGE_NAME
      # Might be under a sub variable. In this repo the sub is .api
      # If the repo is a mono repo, there will be one sub per deployment.
      IMAGE_NAME:
        required: true
        type: string
      DOCKER_REGISTRY_URL:
        required: false
        type: string
        default: test.net
      # From .gitlab-ci.yml variables.DOCKERFILE
      # If the repo is a mono repo, there will be one per deployment under a sub.
      DOCKERFILE:
        required: false
        type: string
        default: Dockerfile
      # Only needed for dotnet builds
      # From .gitlab-ci.yml variables.BUILD_ARGS under a sub for the dotnet build
      # If the gitlab pipeline was passing in custom args, then you will need to add those to these env variables as well.
      BUILD_ARGS:
        required: false
        type: string
      # if you have build args you will need this to populate the values. Located in .gitlab-ci.yml under variables.
      # Leave blank if not in sub folder. Slash at end. File should be named '.env' Format: FOO=bar
      BUILD_ARGS_ENV_FILE_PATH:
        required: false
        type: string
      # Only needed for mono repos that have sub folders for each deployed project (see RGB Screen's api and frontend folders for example)
      # From .gitlab-ci.yml variables.BUILD_ARGS under a sub for each build
      DOCKER_CONTEXT_DIR:
        required: false
        type: string
        default: ""
      # Set to false if it's an official production release. Will move image to prod registry where it will be permanent.
      PRE:
        required: false
        type: boolean
        default: true
      PREBUILD_COMMAND:
        required: false
        type: string
      

env:
  DOCKER_REGISTRY_URL: ${{inputs.DOCKER_REGISTRY_URL}}
  PROJECT: ${{inputs.PROJECT}}
  IMAGE_NAME: ${{inputs.IMAGE_NAME}}
  DOCKERFILE: ${{inputs.DOCKERFILE}}
  BUILD_ARGS: ${{inputs.BUILD_ARGS}}
  DOCKER_CONTEXT_DIR: ${{inputs.DOCKER_CONTEXT_DIR}}
  VERSION: ${{ github.event_name == 'pull_request' && github.event.pull_request.head.sha || github.ref_name }}

jobs:
  build-and-publish:
    runs-on: build-runner
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
          
      - name: Checkout Common workflow
        uses: actions/checkout@v4
        with:
          repository: test-financial/test-actions-common-workflow
            # token: ${{ secrets.TEST_DEVOPS }}
          path: sonar-test
          ref: sonar-scan-poc

      - name: run prebuild command
        run: ${{inputs.PREBUILD_COMMAND}}
        if: inputs.PREBUILD_COMMAND
        shell: bash

      - name: set build args env variables
        run: cat ${{inputs.BUILD_ARGS_ENV_FILE_PATH}}.env >> $GITHUB_ENV
        if: inputs.BUILD_ARGS_ENV_FILE_PATH

      - name: Sonar Scan Analysis 
        continue-on-error: true
        uses: ./test-actions-common-workflow/.github/workflows/sonar-analysis.yml@sonar-scan-poc
                
      - name: Login to Docker Container Registery
        uses: docker/login-action@v3
        with:
          registry: ${{ inputs.DOCKER_URL }}
          username: ${{ inputs.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      # Generates image tag like: test.net/user-management/user-management-api:commit-a0294f3d6e762bc690823c0c4cfa2d3acd0f5a3f
      - name: Build and Push Docker Image
        run: |
          echo "Building Docker image"
          BUILD_IMAGE_NAME=${DOCKER_REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${VERSION}
          echo "BUILD_IMAGE_NAME=$BUILD_IMAGE_NAME" >> $GITHUB_ENV
          echo "Generated image name: ${BUILD_IMAGE_NAME}"
          echo "Retrieved build args: ${{ env.BUILD_ARGS }}"
          if ! docker image pull ${BUILD_IMAGE_NAME} >/dev/null; then
            set +x
            BUILD_ARGS_FLAGS=${BUILD_ARGS:+$(printf -- "--build-arg %s " ${BUILD_ARGS[@]})}
            echo "Generated build arg flags: ${BUILD_ARGS_FLAGS}"
            echo "Building image: ${BUILD_IMAGE_NAME} in registry: ${DOCKER_REGISTRY_URL}"
            docker image build -f ${DOCKERFILE} --tag ${BUILD_IMAGE_NAME} --build-arg REGISTRY=${DOCKER_REGISTRY_URL} ${BUILD_ARGS_FLAGS} --build-arg IMAGE_BUILD_TIME="$(TZ=UTC date -R)" ${DOCKER_CONTEXT_DIR:-${GITHUB_WORKSPACE}}
            echo "Pushing image to ${DOCKER_REGISTRY_URL}"
            docker image push ${BUILD_IMAGE_NAME}
            set +x
          else
            echo "Image ${BUILD_IMAGE_NAME} already present"
          fi
        shell: bash
      - name: Xray
        uses: test-eeps/epl-actions/xray@v1
        with:
          type: image
          score: 9.7
          scan-type: xray
          image: ${{ env.BUILD_IMAGE_NAME }}
          user: ${{ inputs.DOCKER_USERNAME }}
          registry-secret: ${{ secrets.DOCKER_PASSWORD }}
        env:
          DOCKER_REGISTRY_URL: ${{ inputs.DOCKER_REGISTRY_URL }}
          PROJECT: ${{ inputs.PROJECT }}
          IMAGE_NAME: ${{ inputs.IMAGE_NAME }}
          DOCKERFILE: ${{ inputs.DOCKERFILE }}
          BUILD_ARGS: ${{ inputs.BUILD_ARGS }}
          DOCKER_CONTEXT_DIR: ${{ inputs.DOCKER_CONTEXT_DIR }}
      - name: Promote
        uses: test-financial/payments-github/actions/promote@main
        if: inputs.pre != true && !env.PROMOTED
        with:
          repository_name: test-docker/${{ inputs.PROJECT }}/${{ inputs.IMAGE_NAME }}
          tag: ${{ github.ref_name }}
          username: ${{ inputs.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

logs:
-----
Checkout Common workflow step is failing
  Error: fatal: could not read Username for 'https://github.com': terminal prompts disabled
  The process '/usr/bin/git' failed with exit code 128
  Waiting 10 seconds before trying again

