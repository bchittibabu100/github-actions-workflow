#7 [ 1/15] FROM docker.repo1.test.com/vpay-docker/base-images/node:22-alpine@sha256:4ccef6ad477bc0f3f189721fe819fade25f1c884adb75ccba8665e4c37e88802
#7 sha256:c6a83fedfae6ed8a4f5f7cbb6a7b6f1c1ec3d86fea8cb9e5ba2e5e6673fde9f6 3.62MB / 3.62MB 0.2s done
#7 sha256:286f203c853bd2814b022a5f3189475c0971114cc1e724b09b2461d30b145617 36.70MB / 49.18MB 0.3s
#7 extracting sha256:c6a83fedfae6ed8a4f5f7cbb6a7b6f1c1ec3d86fea8cb9e5ba2e5e6673fde9f6 0.1s done
#7 sha256:a0b0347273f33c5c005dd2056e35586f390ceec67bd2ea939b8c1cdc2826c5c4 445B / 445B 0.1s done
#7 sha256:286f203c853bd2814b022a5f3189475c0971114cc1e724b09b2461d30b145617 49.18MB / 49.18MB 0.3s done
#7 extracting sha256:286f203c853bd2814b022a5f3189475c0971114cc1e724b09b2461d30b145617 0.1s
#7 extracting sha256:286f203c853bd2814b022a5f3189475c0971114cc1e724b09b2461d30b145617 1.2s done
#7 extracting sha256:cc70de2ae229e6b20a7bc8ff3ba540a00f394964ea015bc006e70dcdc23261cb
#7 extracting sha256:cc70de2ae229e6b20a7bc8ff3ba540a00f394964ea015bc006e70dcdc23261cb 0.0s done
#7 extracting sha256:a0b0347273f33c5c005dd2056e35586f390ceec67bd2ea939b8c1cdc2826c5c4 done
#7 DONE 1.8s
#11 [ 2/15] ADD https://repo1.test.com/artifactory/THG-certificates/optum/Optum_Root_CA.cer     https://repo1.test.com/artifactory/THG-certificates/optum/Optum_Internal_Policy_CA.cer     https://repo1.test.com/artifactory/THG-certificates/optum/Optum_Internal_Policy_CA2.cer     https://repo1.test.com/artifactory/THG-certificates/optum/Optum_Internal_Issuing_CA2.cer     /usr/local/share/ca-certificates/
#11 DONE 0.2s
#12 [ 3/15] WORKDIR /opt/ibm/
#12 DONE 0.0s
#13 [ 4/15] RUN apk add --no-cache   build-base   make   unixodbc   unixodbc-dev 	python3
#13 0.157 fetch https://dl-cdn.alpinelinux.org/alpine/v3.20/main/x86_64/APKINDEX.tar.gz
#13 0.288 280B3152DF7F0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2091:
#13 0.289 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/main: Permission denied
#13 0.289 fetch https://dl-cdn.alpinelinux.org/alpine/v3.20/community/x86_64/APKINDEX.tar.gz
#13 0.339 280B3152DF7F0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2091:
#13 0.342 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/community: Permission denied
#13 0.342 ERROR: unable to select packages:
#13 0.342   build-base (no such package):
#13 0.342     required by: world[build-base]
#13 0.342   make (no such package):
#13 0.342     required by: world[make]
#13 0.342   python3 (no such package):
#13 0.342     required by: world[python3]
#13 0.342   unixodbc (no such package):
#13 0.342     required by: world[unixodbc]
#13 0.342   unixodbc-dev (no such package):
#13 0.342     required by: world[unixodbc-dev]
#13 ERROR: process "/bin/sh -c apk add --no-cache   build-base   make   unixodbc   unixodbc-dev \tpython3" did not complete successfully: exit code: 5
------
 > [ 4/15] RUN apk add --no-cache   build-base   make   unixodbc   unixodbc-dev 	python3:
0.342   build-base (no such package):
0.342     required by: world[build-base]
0.342   make (no such package):
0.342     required by: world[make]
0.342   python3 (no such package):
0.342     required by: world[python3]
0.342   unixodbc (no such package):
0.342     required by: world[unixodbc]
0.342   unixodbc-dev (no such package):
0.342     required by: world[unixodbc-dev]
------
Dockerfile:32
--------------------
  31 |     
  32 | >>> RUN apk add --no-cache \
  33 | >>>   build-base \
  34 | >>>   make \
  35 | >>>   unixodbc \
  36 | >>>   unixodbc-dev \
  37 | >>> 	python3
  38 |     ## Install IBM iAccessSeries app package
--------------------
ERROR: failed to solve: process "/bin/sh -c apk add --no-cache   build-base   make   unixodbc   unixodbc-dev \tpython3" did not complete successfully: exit code: 5
Error: Process completed with exit code 1.
