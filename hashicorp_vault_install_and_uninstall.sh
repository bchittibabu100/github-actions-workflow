docker buildx build --secret id=jfrog_auth,src=/Users/cboya1/Downloads/aspnet/distribution/auth.conf --platform linux/amd64 -t dist-brookworm-image -f ./Dockerfile.brook-worm .
[+] Building 5.3s (6/6) FINISHED                                                                                                                      docker:desktop-linux
 => [internal] load build definition from Dockerfile.brook-worm                                                                                                       0.0s
 => => transferring dockerfile: 2.05kB                                                                                                                                0.0s
 => [internal] load metadata for mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim                                                                                    0.4s
 => [internal] load .dockerignore                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                       0.0s
 => [runtime 1/3] FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim@sha256:47091f7cee02e448630df85542579e09b7bbe3b10bd4e1991ff59d3adbddd720                      0.0s
 => => resolve mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim@sha256:47091f7cee02e448630df85542579e09b7bbe3b10bd4e1991ff59d3adbddd720                              0.0s
 => CACHED [runtime 2/3] WORKDIR /app                                                                                                                                 0.0s
 => ERROR [runtime 3/3] RUN --mount=type=secret,id=jfrog_auth     cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo "deb [trusted=yes] https://centraluhg.jf  4.9s
------
 > [runtime 3/3] RUN --mount=type=secret,id=jfrog_auth     cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm main" > /etc/apt/sources.list &&     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm main" >> /etc/apt/sources.list &&     apt-get clean && rm -rf /var/lib/apt/lists/* &&     apt-get update &&     apt-get install -y --no-install-recommends       default-jre-headless       libbcprov-java       libcommons-lang3-java       libc6       libjpeg62-turbo       libmysqlclient21       zlib1g       libxml2       odbcinst       python3       python3-pip  && apt-get clean  && rm -rf /var/lib/apt/lists/*:
0.648 Err:1 http://deb.debian.org/debian bookworm InRelease
0.648   403  Forbidden [IP: 199.232.98.132 80]
0.777 Err:2 http://deb.debian.org/debian bookworm-updates InRelease
0.777   403  Forbidden [IP: 199.232.98.132 80]
0.919 Err:3 http://deb.debian.org/debian-security bookworm-security InRelease
0.919   403  Forbidden [IP: 199.232.98.132 80]
1.789 Get:4 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm InRelease [3618 B]
1.902 Ign:5 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm InRelease
2.015 Ign:6 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm Release
2.130 Ign:7 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main amd64 Packages
2.240 Ign:8 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main all Packages
2.351 Ign:7 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main amd64 Packages
2.465 Ign:8 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main all Packages
2.575 Ign:7 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main amd64 Packages
2.689 Ign:8 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main all Packages
2.798 Ign:7 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main amd64 Packages
2.867 Ign:4 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm InRelease
2.900 Ign:8 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main all Packages
3.010 Ign:7 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main amd64 Packages
3.518 Get:9 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm/main all Packages [573 B]
4.133 Get:10 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm/main amd64 Packages [133 kB]
4.365 Ign:8 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main all Packages
4.478 Ign:7 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main amd64 Packages
4.581 Ign:8 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main all Packages
4.688 Err:7 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main amd64 Packages
4.688   404   [IP: 51.8.69.198 443]
4.799 Ign:8 https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm/main all Packages
4.847 Reading package lists...
4.897 E: The repository 'http://deb.debian.org/debian bookworm InRelease' is not signed.
4.897 E: Failed to fetch http://deb.debian.org/debian/dists/bookworm/InRelease  403  Forbidden [IP: 199.232.98.132 80]
4.897 E: Failed to fetch http://deb.debian.org/debian/dists/bookworm-updates/InRelease  403  Forbidden [IP: 199.232.98.132 80]
4.897 E: The repository 'http://deb.debian.org/debian bookworm-updates InRelease' is not signed.
4.897 E: Failed to fetch http://deb.debian.org/debian-security/dists/bookworm-security/InRelease  403  Forbidden [IP: 199.232.98.132 80]
4.897 E: The repository 'http://deb.debian.org/debian-security bookworm-security InRelease' is not signed.
4.897 W: GPG error: https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY EB3E94ADBE1229CF
------
Dockerfile.brook-worm:30
--------------------
  29 |
  30 | >>> RUN --mount=type=secret,id=jfrog_auth \
  31 | >>>     cp /run/secrets/jfrog_auth /etc/apt/auth.conf && \
  32 | >>>     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm main" > /etc/apt/sources.list && \
  33 | >>>     echo "deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm main" >> /etc/apt/sources.list && \
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
ERROR: failed to build: failed to solve: process "/bin/sh -c cp /run/secrets/jfrog_auth /etc/apt/auth.conf &&     echo \"deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-debian12-rem bookworm main\" > /etc/apt/sources.list &&     echo \"deb [trusted=yes] https://centraluhg.jfrog.io/artifactory/glb-debian-microsoft-12-rem-cache bookworm main\" >> /etc/apt/sources.list &&     apt-get clean && rm -rf /var/lib/apt/lists/* &&     apt-get update &&     apt-get install -y --no-install-recommends       default-jre-headless       libbcprov-java       libcommons-lang3-java       libc6       libjpeg62-turbo       libmysqlclient21       zlib1g       libxml2       odbcinst       python3       python3-pip  && apt-get clean  && rm -rf /var/lib/apt/lists/*" did not complete successfully: exit code: 100
