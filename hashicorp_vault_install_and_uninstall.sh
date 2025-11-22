docker buildx build --secret id=jfrog_auth,src=/Users/cboya1/Downloads/aspnet/distribution/auth.conf --platform linux/amd64 -t dist-brookworm-image -f ./Dockerfile.brook-worm .
[+] Building 0.6s (6/6) FINISHED                                                                                                                      docker:desktop-linux
 => [internal] load build definition from Dockerfile.brook-worm                                                                                                       0.0s
 => => transferring dockerfile: 2.07kB                                                                                                                                0.0s
 => [internal] load metadata for mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim                                                                                    0.4s
 => [internal] load .dockerignore                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                       0.0s
 => [runtime 1/3] FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim@sha256:47091f7cee02e448630df85542579e09b7bbe3b10bd4e1991ff59d3adbddd720                      0.0s
 => => resolve mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim@sha256:47091f7cee02e448630df85542579e09b7bbe3b10bd4e1991ff59d3adbddd720                              0.0s
 => CACHED [runtime 2/3] WORKDIR /app                                                                                                                                 0.0s
 => ERROR [runtime 3/3] RUN --mount=type=secret,id=jfrog_auth     cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo "deb [trusted=yes] https://centraluhg.jf  0.2s
------
# --- Stage 0: Build (has build deps only here) ---
FROM mcr.microsoft.com/dotnet/sdk:8.0-bookworm-slim AS build
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /src

RUN --mount=type=secret,id=jfrog_auth \
    cp /run/secrets/jfrog_auth /etc/apt/auth.conf && \
    echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem/dists/bookworm main" > /etc/apt/sources.list && \
    echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache/dists/bookworm main" >> /etc/apt/sources.list && \
# Install build-only packages here (kept out of final image)
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      g++ \
      python3-dev \
      python3-pip \
      libmysqlclient-dev \
      libjpeg-dev \
      zlib1g-dev \
      libxml2-dev \
      odbcinst \
 && rm -rf /var/lib/apt/lists/*


# --- Stage 1: Runtime (minimal) ---
FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim AS runtime
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /app

RUN --mount=type=secret,id=jfrog_auth \
    cp /run/secrets/jfrog_auth /etc/apt/auth.conf && \
    echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem/dists/bookworm main" > /etc/apt/sources.list && \
    echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache/dists/bookworm main" >> /etc/apt/sources.list && \
# Install ONLY runtime packages required by your app.
# Avoid -dev packages here (they cause Xray to report more CVEs).
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      default-jre-headless \
      libbcprov-java \
      libcommons-lang3-java \
      libc6 \
      libjpeg62-turbo \
"Dockerfile.brook-worm" 52L, 2024B
# --- Stage 0: Build (has build deps only here) ---
FROM mcr.microsoft.com/dotnet/sdk:8.0-bookworm-slim AS build
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /src

RUN --mount=type=secret,id=jfrog_auth \
    cp /run/secrets/jfrog_auth /etc/apt/auth.conf && \
    echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem/dists/bookworm main" > /etc/apt/sources.list && \
    echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache/dists/bookworm main" >> /etc/apt/sources.list && \
 > [runtime 3/3] RUN --mount=type=secret,id=jfrog_auth     cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem/dists/bookworm main" > /etc/apt/sources.list &&     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache/dists/bookworm main" >> /etc/apt/sources.list &&     apt-get clean && rm -rf /var/lib/apt/lists/* &&     apt-get update &&     apt-get install -y --no-install-recommends       default-jre-headless       libbcprov-java       libcommons-lang3-java       libc6       libjpeg62-turbo       libmysqlclient21       zlib1g       libxml2       odbcinst       python3       python3-pip  && apt-get clean  && rm -rf /var/lib/apt/lists/*:
0.198 E: Malformed entry 1 in list file /etc/apt/sources.list (Component)
0.198 E: The list of sources could not be read.
------
Dockerfile.brook-worm:30
--------------------
  29 |
  30 | >>> RUN --mount=type=secret,id=jfrog_auth \
  31 | >>>     cp /run/secrets/jfrog_auth /etc/apt/auth.conf && \
  32 | >>>     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem/dists/bookworm main" > /etc/apt/sources.list && \
  33 | >>>     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache/dists/bookworm main" >> /etc/apt/sources.list && \
  34 | >>> # Install ONLY runtime packages required by your app.
  35 | >>> # Avoid -dev packages here (they cause Xray to report more CVEs).
  36 | >>>     apt-get clean && rm -rf /var/lib/apt/lists/* && \
  37 | >>>     apt-get update && \
  38 | >>>     apt-get install -y --no-install-recommends \
  39 | >>>       default-jre-headless \
  40 | >>>       libbcprov-java \
  41 | >>>       libcommons-lang3-java \
  42 | >>>       libc6 \
  43 | >>>       libjpeg62-turbo \
  44 | >>>       libmysqlclient21 \
  45 | >>>       zlib1g \
  46 | >>>       libxml2 \
  47 | >>>       odbcinst \
  48 | >>>       python3 \
  49 | >>>       python3-pip \
  50 | >>>  && apt-get clean \
  51 | >>>  && rm -rf /var/lib/apt/lists/*
  52 |
--------------------
ERROR: failed to build: failed to solve: process "/bin/sh -c cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo \"deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem/dists/bookworm main\" > /etc/apt/sources.list &&     echo \"deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache/dists/bookworm main\" >> /etc/apt/sources.list &&     apt-get clean && rm -rf /var/lib/apt/lists/* &&     apt-get update &&     apt-get install -y --no-install-recommends       default-jre-headless       libbcprov-java       libcommons-lang3-java       libc6       libjpeg62-turbo       libmysqlclient21       zlib1g       libxml2       odbcinst       python3       python3-pip  && apt-get clean  && rm -rf /var/lib/apt/lists/*" did not complete successfully: exit code: 100
