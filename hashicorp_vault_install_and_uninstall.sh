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
      PROJECT:
        required: true
        type: string
      IMAGE_NAME:
        required: true
        type: string
      DOCKER_REGISTRY_URL:
        required: false
        type: string
        default: plinfharbor.vayusa.net
      DOCKERFILE:
        required: false
        type: string
        default: Dockerfile
      BUILD_ARGS:
        required: false
        type: string
      BUILD_ARGS_ENV_FILE_PATH:
        required: false
        type: string
      DOCKER_CONTEXT_DIR:
        required: false
        type: string
        default: ""
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
    runs-on: uhg-runner
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: run prebuild command
        run: ${{inputs.PREBUILD_COMMAND}}
        if: inputs.PREBUILD_COMMAND
        shell: bash
      - name: set build args env variables
        run: cat ${{inputs.BUILD_ARGS_ENV_FILE_PATH}}.env >> $GITHUB_ENV
        if: inputs.BUILD_ARGS_ENV_FILE_PATH
      - name: Login to Docker Container Registery
        uses: docker/login-action@v3
        with:
          registry: ${{ inputs.DOCKER_URL }}
          username: ${{ inputs.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

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
        uses: uhg-pipelines/epl-jf/xray-scan@v1
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
        uses: chk-financial/payments-github/actions/promote@main
        if: inputs.pre != true && !env.PROMOTED
        with:
          repository_name: vay-docker/${{ inputs.PROJECT }}/${{ inputs.IMAGE_NAME }}
          tag: ${{ github.ref_name }}
          username: ${{ inputs.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
