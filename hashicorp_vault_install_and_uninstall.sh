FROM docker.repo1.vhc.com/vpay-docker/base-images/dotnet/sdk:8.0.403-jammy as base
WORKDIR /app

FROM base as build

ENV PROJECT=src/VPay.MEP.API/VPay.MEP.API.csproj

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
RUN dotnet publish --no-restore -c Release -o /app/out ${PROJECT}


FROM docker.repo1.vhc.com/vpay-docker/base-images/dotnet/aspnet:8.0.4-jammy-db2 AS final
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /app

COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:80

RUN ln -s VPay.MEP.API.dll Entrypoint.dll

ENTRYPOINT [ "dotnet", "Entrypoint.dll" ]

## Optionally add image build time
ARG IMAGE_BUILD_TIME
ENV IMAGE_BUILD_TIME ${IMAGE_BUILD_TIME}
