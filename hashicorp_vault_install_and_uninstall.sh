#12 [ 3/16] RUN apk add --no-cache   ca-certificates   update-ca-certificates
#12 0.198 fetch https://dl-cdn.alpinelinux.org/alpine/v3.20/main/x86_64/APKINDEX.tar.gz
#12 0.281 28CB6691847F0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2091:
#12 0.282 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/main: Permission denied
#12 0.282 fetch https://dl-cdn.alpinelinux.org/alpine/v3.20/community/x86_64/APKINDEX.tar.gz
#12 0.316 28CB6691847F0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2091:
#12 0.317 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/community: Permission denied
#12 0.317 ERROR: unable to select packages:
#12 0.317   ca-certificates (no such package):
#12 0.317     required by: world[ca-certificates]
#12 0.317   update-ca-certificates (no such package):
#12 0.317     required by: world[update-ca-certificates]
#12 ERROR: process "/bin/sh -c apk add --no-cache   ca-certificates   update-ca-certificates" did not complete successfully: exit code: 2
------
 > [ 3/16] RUN apk add --no-cache   ca-certificates   update-ca-certificates:
0.281 28CB6691847F0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2091:
0.282 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/main: Permission denied
0.282 fetch https://dl-cdn.alpinelinux.org/alpine/v3.20/community/x86_64/APKINDEX.tar.gz
0.316 28CB6691847F0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2091:
0.317 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/community: Permission denied
0.317 ERROR: unable to select packages:
0.317   ca-certificates (no such package):
0.317     required by: world[ca-certificates]
0.317   update-ca-certificates (no such package):
0.317     required by: world[update-ca-certificates]
