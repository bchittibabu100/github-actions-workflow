Here is the docker file contents and Jfrog Xray CVE's report. give me updated docker file to get rid off all these CVE's

ARG REGISTRYURL=docker.repo1.vhc.com/vpay-docker
ARG DOTNET_SDK_VERSION=8.0.403
ARG DOTNET_RUNTIME_VERSION=8.0.4

ARG DOTNET_SDK_VARIANT=jammy
ARG DOTNET_RUNTIME_VARIANT=jammy-db2
ARG BASE_SDK_IMAGE=dotnet/sdk
ARG BASE_RUNTIME_IMAGE=dotnet/aspnet

FROM ${REGISTRYURL}/base-images/${BASE_SDK_IMAGE}:${DOTNET_SDK_VERSION}-${DOTNET_SDK_VARIANT} as base
WORKDIR /app

FROM base as build

ARG CONFIG_PROFILE=Release
ARG PROJECT_DIR
ARG PROJECT_NAME

ENV PROJECT=${PROJECT_DIR}/${PROJECT_NAME}.csproj


COPY nuget.config* ./
COPY *.sln ./

SHELL ["/bin/bash", "-O", "globstar", "-c"]
RUN --mount=target=docker_build_context \
cd docker_build_context;\
cp **/*.csproj ../ --parents;
RUN rm -rf docker_build_context
SHELL ["/bin/sh", "-c"]

RUN dotnet restore ${PROJECT}
COPY . ./
RUN dotnet publish --no-restore -c ${CONFIG_PROFILE} -o /app/out ${PROJECT}

FROM ${REGISTRYURL}/base-images/${BASE_RUNTIME_IMAGE}:${DOTNET_RUNTIME_VERSION}-${DOTNET_RUNTIME_VARIANT} AS final
ARG PROJECT_NAME

RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /app

COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:80

RUN ln -s ${PROJECT_NAME}.dll Entrypoint.dll

ENTRYPOINT [ "dotnet", "Entrypoint.dll" ]

ARG IMAGE_BUILD_TIME
ENV IMAGE_BUILD_TIME ${IMAGE_BUILD_TIME}


CVE-2024-37371_ubuntu:jammy:libgssapi-krb5-2_1.19.2-2ubuntu0.3
CVE-2024-37371_ubuntu:jammy:libk5crypto3_1.19.2-2ubuntu0.3
CVE-2022-40735_ubuntu:jammy:openssl_3.0.2-0ubuntu1.15
CVE-2024-37371_ubuntu:jammy:libkrb5support0_1.19.2-2ubuntu0.3
CVE-2022-40735_ubuntu:jammy:libssl3_3.0.2-0ubuntu1.15
CVE-2024-37371_ubuntu:jammy:libkrb5-3_1.19.2-2ubuntu0.3
CVE-2024-37370_ubuntu:jammy:libk5crypto3_1.19.2-2ubuntu0.3
CVE-2024-37370_ubuntu:jammy:libgssapi-krb5-2_1.19.2-2ubuntu0.3
CVE-2024-37370_ubuntu:jammy:libkrb5support0_1.19.2-2ubuntu0.3
CVE-2024-37370_ubuntu:jammy:libkrb5-3_1.19.2-2ubuntu0.3
CVE-2018-5709_ubuntu:jammy:libkrb5-3_1.19.2-2ubuntu0.3
CVE-2018-5709_ubuntu:jammy:libkrb5support0_1.19.2-2ubuntu0.3
CVE-2018-5709_ubuntu:jammy:libgssapi-krb5-2_1.19.2-2ubuntu0.3
CVE-2017-11164_ubuntu:jammy:libpcre3:2_8.39-13ubuntu0.22.04.1
CVE-2016-20013_ubuntu:jammy:libc-bin_2.35-0ubuntu3.7
CVE-2022-4899_ubuntu:jammy:libzstd1_1.4.8+dfsg-3build1
CVE-2016-20013_ubuntu:jammy:libc6_2.35-0ubuntu3.7
CVE-2022-41409_ubuntu:jammy:libpcre2-8-0_10.39-3ubuntu0.1
CVE-2018-5709_ubuntu:jammy:libk5crypto3_1.19.2-2ubuntu0.3
