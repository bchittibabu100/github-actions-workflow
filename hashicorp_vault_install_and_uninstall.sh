docker buildx build --secret id=jfrog_auth,src=/Users/cboya1/Downloads/aspnet/distribution/auth.conf --platform linux/amd64 -t dist-brookworm-image -f ./Dockerfile.brook-worm .
[+] Building 9.7s (6/6) FINISHED                                                                                                                      docker:desktop-linux
 => [internal] load build definition from Dockerfile.brook-worm                                                                                                       0.0s
 => => transferring dockerfile: 2.19kB                                                                                                                                0.0s
 => [internal] load metadata for mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim                                                                                    0.4s
 => [internal] load .dockerignore                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                       0.0s
 => [runtime 1/3] FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim@sha256:47091f7cee02e448630df85542579e09b7bbe3b10bd4e1991ff59d3adbddd720                      0.0s
 => => resolve mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim@sha256:47091f7cee02e448630df85542579e09b7bbe3b10bd4e1991ff59d3adbddd720                              0.0s
 => CACHED [runtime 2/3] WORKDIR /app                                                                                                                                 0.0s
 => ERROR [runtime 3/3] RUN --mount=type=secret,id=jfrog_auth     cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo "deb [trusted=yes] https://centraluhg.jf  9.3s
------
 > [runtime 3/3] RUN --mount=type=secret,id=jfrog_auth     cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy main multiverse restricted universe" > /etc/apt/sources.list &&     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy main multiverse restricted universe" >> /etc/apt/sources.list &&     apt-get clean && rm -rf /var/lib/apt/lists/* &&     apt-get update &&     apt-get install -y --no-install-recommends       default-jre-headless       libbcprov-java       libcommons-lang3-java       libc6       libjpeg62-turbo       libmysqlclient21       zlib1g       libxml2       odbcinst       python3       python3-pip  && apt-get clean  && rm -rf /var/lib/apt/lists/*:
0.655 Err:1 http://deb.debian.org/debian bookworm InRelease
0.655   403  Forbidden [IP: 199.232.98.132 80]
0.789 Err:2 http://deb.debian.org/debian bookworm-updates InRelease
0.789   403  Forbidden [IP: 199.232.98.132 80]
0.936 Err:3 http://deb.debian.org/debian-security bookworm-security InRelease
0.936   403  Forbidden [IP: 199.232.98.132 80]
1.190 Get:4 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy InRelease [270 kB]
1.652 Get:5 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy InRelease [270 kB]
2.607 Ign:4 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy InRelease
2.927 Get:6 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy/main amd64 Packages [1395 kB]
3.629 Ign:5 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy InRelease
4.069 Get:7 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy/restricted amd64 Packages [129 kB]
4.269 Get:8 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy/universe amd64 Packages [14.1 MB]
6.349 Get:9 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy/multiverse amd64 Packages [217 kB]
6.475 Get:10 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy/universe amd64 Packages [14.1 MB]
7.464 Get:11 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy/multiverse amd64 Packages [217 kB]
7.592 Get:12 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy/main amd64 Packages [1395 kB]
7.667 Get:13 https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy/restricted amd64 Packages [129 kB]
8.715 Reading package lists...
9.245 E: The repository 'http://deb.debian.org/debian bookworm InRelease' is not signed.
9.245 E: Failed to fetch http://deb.debian.org/debian/dists/bookworm/InRelease  403  Forbidden [IP: 199.232.98.132 80]
9.245 E: Failed to fetch http://deb.debian.org/debian/dists/bookworm-updates/InRelease  403  Forbidden [IP: 199.232.98.132 80]
9.245 E: The repository 'http://deb.debian.org/debian bookworm-updates InRelease' is not signed.
9.245 E: Failed to fetch http://deb.debian.org/debian-security/dists/bookworm-security/InRelease  403  Forbidden [IP: 199.232.98.132 80]
9.245 E: The repository 'http://deb.debian.org/debian-security bookworm-security InRelease' is not signed.
9.245 W: GPG error: https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 871920D1991BC93C
9.245 W: GPG error: https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 871920D1991BC93C
------
Dockerfile.brook-worm:30
--------------------
  29 |
  30 | >>> RUN --mount=type=secret,id=jfrog_auth \
  31 | >>>     cp /run/secrets/jfrog_auth /etc/apt/auth.conf && \
  32 | >>>     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy main multiverse restricted universe" > /etc/apt/sources.list && \
  33 | >>>     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy main multiverse restricted universe" >> /etc/apt/sources.list && \
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
ERROR: failed to build: failed to solve: process "/bin/sh -c cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo \"deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem/ubuntu jammy main multiverse restricted universe\" > /etc/apt/sources.list &&     echo \"deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-archive-ubuntu-rem-cache/ubuntu jammy main multiverse restricted universe\" >> /etc/apt/sources.list &&     apt-get clean && rm -rf /var/lib/apt/lists/* &&     apt-get update &&     apt-get install -y --no-install-recommends       default-jre-headless       libbcprov-java       libcommons-lang3-java       libc6       libjpeg62-turbo       libmysqlclient21       zlib1g       libxml2       odbcinst       python3       python3-pip  && apt-get clean  && rm -rf /var/lib/apt/lists/*" did not complete successfully: exit code: 100
