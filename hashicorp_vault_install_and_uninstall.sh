Run dotnet restore $PROJECT_DIR/$PROJECT_NAME.csproj
  dotnet restore $PROJECT_DIR/$PROJECT_NAME.csproj
  shell: /usr/bin/bash --noprofile --norc -e -o pipefail {0}
  env:
    DOCKER_REGISTRY_URL: docker.repo1.test.com/TPay-docker
    PROJECT: user-management
    IMAGE_NAME: user-management-api
    DOCKERFILE: Dockerfile
    BUILD_ARGS: PROJECT_DIR PROJECT_NAME
    DOCKER_CONTEXT_DIR: 
    VERSION: sonar-scan-poc
    SONAR_TOKEN: ***
    PROJECT_DIR: src/TPay.UserManagement.Api
    PROJECT_NAME: TPay.UserManagement.Api
    DOTNET_ROOT: /home/runner/.dotnet
  
  Determining projects to restore...
/home/runner/.dotnet/sdk/8.0.404/NuGet.targets(174,5): error : 'sonar-scan-poc' is not a valid version string. (Parameter 'value') [/home/runner/_work/TPay-user-management-api/TPay-user-management-api/src/TPay.UserManagement.Api/TPay.UserManagement.Api.csproj]
