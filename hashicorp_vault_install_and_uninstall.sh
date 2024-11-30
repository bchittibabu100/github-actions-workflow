# Build arguments
ARG REGISTRYURL=docker.repo1.vhc.com/vpay-docker
ARG DOTNET_SDK_VERSION=8.0.403
ARG DOTNET_RUNTIME_VERSION=8.0.4
ARG DOTNET_SDK_VARIANT=jammy
ARG DOTNET_RUNTIME_VARIANT=jammy-db2
ARG BASE_SDK_IMAGE=dotnet/sdk
ARG BASE_RUNTIME_IMAGE=dotnet/aspnet

# Use the base SDK image with the latest updates
FROM ${REGISTRYURL}/base-images/${BASE_SDK_IMAGE}:${DOTNET_SDK_VERSION}-${DOTNET_SDK_VARIANT} as base
WORKDIR /app

# Update base image and install security patches
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    # Security updates for vulnerable libraries
    openssl libkrb5-3 libkrb5support0 libssl3 libgssapi-krb5-2 libk5crypto3 \
    libc-bin libc6 libpcre3 libzstd1 libpcre2-8-0 && \
    apt-get clean

# Build stage
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

# Runtime image with the necessary security updates
FROM ${REGISTRYURL}/base-images/${BASE_RUNTIME_IMAGE}:${DOTNET_RUNTIME_VERSION}-${DOTNET_RUNTIME_VARIANT} AS final

# Update runtime image and install security patches
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    openssl libkrb5-3 libkrb5support0 libssl3 libgssapi-krb5-2 libk5crypto3 \
    libc-bin libc6 libpcre3 libzstd1 libpcre2-8-0 && \
    apt-get clean

# Set timezone and configure the application
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:80

RUN ln -s ${PROJECT_NAME}.dll Entrypoint.dll

ENTRYPOINT [ "dotnet", "Entrypoint.dll" ]

ARG IMAGE_BUILD_TIME
ENV IMAGE_BUILD_TIME ${IMAGE_BUILD_TIME}
