#9 [final 2/6] RUN apt-get update && apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
#9 2.332 Get:8 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [30.9 kB]
#9 2.520 Reading package lists...
#9 5.902 E: The repository 'http://archive.ubuntu.com/ubuntu focal InRelease' is no longer signed.
#9 5.902 E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/focal/InRelease  407  Proxy Authentication Required [IP: 185.125.190.83 80]
#9 5.902 E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/focal-updates/InRelease  407  Proxy Authentication Required [IP: 185.125.190.83 80]
#9 5.902 E: The repository 'http://archive.ubuntu.com/ubuntu focal-updates InRelease' is no longer signed.
#9 5.902 E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/focal-backports/InRelease  407  Proxy Authentication Required [IP: 185.125.190.83 80]
#9 5.902 E: The repository 'http://archive.ubuntu.com/ubuntu focal-backports InRelease' is no longer signed.
#9 ERROR: process "/bin/sh -c apt-get update && apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata" did not complete successfully: exit code: 100

#16 [build 7/9] RUN dotnet restore src/Vpay.Api.RestApi/Vpay.Api.RestApi.csproj
#16 0.864   Determining projects to restore...
#16 CANCELED
------
 > [final 2/6] RUN apt-get update && apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata:
1.447 Get:6 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [1296 kB]
1.672 Get:7 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [4157 kB]
2.332 Get:8 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [30.9 kB]

5.902 E: The repository 'http://archive.ubuntu.com/ubuntu focal InRelease' is no longer signed.
5.902 E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/focal/InRelease  407  Proxy Authentication Required [IP: 185.125.190.83 80]
5.902 E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/focal-updates/InRelease  407  Proxy Authentication Required [IP: 185.125.190.83 80]
5.902 E: The repository 'http://archive.ubuntu.com/ubuntu focal-updates InRelease' is no longer signed.
5.902 E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/focal-backports/InRelease  407  Proxy Authentication Required [IP: 185.125.190.83 80]
5.902 E: The repository 'http://archive.ubuntu.com/ubuntu focal-backports InRelease' is no longer signed.
------
Dockerfile:57
--------------------
  55 |     
  56 |     # Time zone...
  57 | >>> RUN apt-get update && apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
  58 |     
  59 |     # Locale...
--------------------
ERROR: failed to solve: process "/bin/sh -c apt-get update && apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && dpkg-reconfigure -f noninteractive tzdata" did not complete successfully: exit code: 100
