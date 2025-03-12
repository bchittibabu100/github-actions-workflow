JFrog Xray vulnerabilities:

4 Vulnerabilities:
Last Scan Status 
9.8
CVE-2024-51501
Locked
refit:6.3.2
7.2.22
CWE-93
7.5
CVE-2023-44487
Locked
High
ubuntu:focal:libnghttp2-14:1.40.0-1ubuntu0.1
1.40.0-1ubuntu0.2
NVD-CWE-noinfo
7.3
CVE-2023-7104
Locked
Medium
ubuntu:focal:libsqlite3-0:3.31.1-4ubuntu0.5
3.31.1-4ubuntu0.6
CWE-119
8.8
CVE-2023-36414
Locked
azure.identity:1.7.0
1.10.2
CWE-77 (+1)


6 Vulnerabilities:
Last Scan Status 
N/A
CVE-2024-4741
Locked
ubuntu:focal:libssl1.1:1.1.1f-1ubuntu2.19
1.1.1f-1ubuntu2.23
N/A
N/A
CVE-2024-2511
Locked
ubuntu:focal:libssl1.1:1.1.1f-1ubuntu2.19
1.1.1f-1ubuntu2.23
N/A
5.5
CVE-2024-0727
Locked
ubuntu:focal:libssl1.1:1.1.1f-1ubuntu2.19
1.1.1f-1ubuntu2.21
NVD-CWE-noinfo
5.3
CVE-2023-5678
Locked
ubuntu:focal:libssl1.1:1.1.1f-1ubuntu2.19
1.1.1f-1ubuntu2.21
CWE-754
5.3
CVE-2023-3817
Locked
ubuntu:focal:libssl1.1:1.1.1f-1ubuntu2.19
1.1.1f-1ubuntu2.20
CWE-834
5.3
CVE-2023-3446
Locked
ubuntu:focal:libssl1.1:1.1.1f-1ubuntu2.19
1.1.1f-1ubuntu2.20
CWE-1333



Dockerfile:
#######################################
## This Dockerfile requires BuildKit ##
#######################################

## General arguments
ARG REGISTRY=docker.repo1.pbc.com/vpay-docker
ARG DOTNET_RUNTIME_VERSION=8.0.4
ARG DOTNET_SDK_VERSION=8.0.403
ARG DOTNET_SDK_VARIANT=jammy
ARG DOTNET_RUNTIME_VARIANT=jammy-db2
ARG BASE_SDK_IMAGE=dotnet/sdk
ARG BASE_RUNTIME_IMAGE=dotnet/aspnet

## Build Stage
FROM ${REGISTRY}/base-images/${BASE_SDK_IMAGE}:${DOTNET_SDK_VERSION}-${DOTNET_SDK_VARIANT} as build

## Build stage arguments
ARG CONFIG_PROFILE=Release
ARG PROJECT_DIR
ARG PROJECT_NAME

ENV PROJECT=${PROJECT_DIR}/${PROJECT_NAME}.csproj
WORKDIR /app

COPY .editorconfig \
    Directory.Build.props \
    Directory.Build.targets \
    Directory.Packages.props \
    nuget.config* \
    *.sln \
    ./

## Copy .csproj files into the correct file structure
SHELL ["/bin/bash", "-O", "globstar", "-c"]
RUN --mount=target=docker_build_context \
cd docker_build_context;\
cp **/*.csproj ../ --parents;
RUN rm -rf docker_build_context
SHELL ["/bin/sh", "-c"]

## Restore project
RUN dotnet restore ${PROJECT}
## Copy all files if restore succeeds
COPY . ./
## Publish project without restoring
RUN dotnet publish --no-restore -c ${CONFIG_PROFILE} -o /app/out ${PROJECT}

## New stage used to reduce the size of the final image
FROM ${REGISTRY}/base-images/${BASE_RUNTIME_IMAGE}:${DOTNET_RUNTIME_VERSION}-${DOTNET_RUNTIME_VARIANT} AS final
## Final stage arguments
ARG PROJECT_NAME

# Change time zone to central time
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /app

COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:80

## Create a symlink so we can use exec form entrypoint
RUN ln -s ${PROJECT_NAME}.dll Entrypoint.dll

ENTRYPOINT [ "dotnet", "Entrypoint.dll" ]

## Optionally add image build time
ARG IMAGE_BUILD_TIME
ENV IMAGE_BUILD_TIME ${IMAGE_BUILD_TIME}


get me updated dockerfile with all the fixes for the listed vulnerabilities. Make sure new vulnerabilities are not introduced as part of addressing these
