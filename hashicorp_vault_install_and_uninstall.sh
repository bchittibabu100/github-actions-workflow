5 extracting sha256:0a9a5dfd008f05ebc27e4790db0709a29e527690c21bcbcd01481eaeb6bb49dc
#5 extracting sha256:0a9a5dfd008f05ebc27e4790db0709a29e527690c21bcbcd01481eaeb6bb49dc 0.1s done
#5 sha256:de4fe7064d8f98419ea6b49190df1abbf43450c1702eeb864fe9ced453c1cc5f 9.22kB / 9.22kB done
#5 sha256:43180c492a5e6cedd8232e8f77a454f666f247586853eecb90258b26688ad1d3 1.02kB / 1.02kB done
#5 sha256:ff221270b9fb7387b0ad9ff8f69fbbd841af263842e62217392f18c3b5226f38 581B / 581B done
#5 sha256:0a9a5dfd008f05ebc27e4790db0709a29e527690c21bcbcd01481eaeb6bb49dc 3.63MB / 3.63MB 0.1s done
#5 DONE 0.3s

#6 [2/2] RUN apk add --no-cache       bash       jq       tzdata       fontconfig       liberation-fonts       zlib       icu-data-full       musl-locales
#6 0.165 fetch https://dl-cdn.alpinelinux.org/alpine/v3.20/main/x86_64/APKINDEX.tar.gz
#6 0.724 281B96E8FC7E0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2103:
#6 0.725 fetch https://dl-cdn.alpinelinux.org/alpine/v3.20/community/x86_64/APKINDEX.tar.gz
#6 0.725 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/main: Permission denied
#6 0.759 281B96E8FC7E0000:error:0A000086:SSL routines:tls_post_process_server_certificate:certificate verify failed:ssl/statem/statem_clnt.c:2103:
#6 0.760 WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.20/community: Permission denied
#6 0.760 ERROR: unable to select packages:
#6 0.760   bash (no such package):
#6 0.760     required by: world[bash]
#6 0.760   fontconfig (no such package):
#6 0.760     required by: world[fontconfig]
#6 0.760   icu-data-full (no such package):
#6 0.760     required by: world[icu-data-full]
#6 0.760   jq (no such package):
#6 0.760     required by: world[jq]
#6 0.760   liberation-fonts (no such package):
#6 0.760     required by: world[liberation-fonts]
#6 0.760   musl-locales (no such package):
#6 0.760     required by: world[musl-locales]
#6 0.760   tzdata (no such package):
#6 0.760     required by: world[tzdata]
#6 ERROR: process "/bin/sh -c apk add --no-cache       bash       jq       tzdata       fontconfig       liberation-fonts       zlib       icu-data-full       musl-locales" did not complete successfully: exit code: 7
------
 > [2/2] RUN apk add --no-cache       bash       jq       tzdata       fontconfig       liberation-fonts       zlib       icu-data-full       musl-locales:
0.760   icu-data-full (no such package):
0.760     required by: world[icu-data-full]
0.760   jq (no such package):
0.760     required by: world[jq]
0.760   liberation-fonts (no such package):
0.760     required by: world[liberation-fonts]
0.760   musl-locales (no such package):
0.760     required by: world[musl-locales]
0.760   tzdata (no such package):
0.760     required by: world[tzdata]
------
Dockerfile:4
--------------------
   3 |     
   4 | >>> RUN apk add --no-cache \
   5 | >>>       bash \
   6 | >>>       jq \
   7 | >>>       tzdata \
   8 | >>>       fontconfig \
   9 | >>>       liberation-fonts \
  10 | >>>       zlib \
  11 | >>>       icu-data-full \
  12 | >>>       musl-locales
  13 |     
--------------------
ERROR: failed to solve: process "/bin/sh -c apk add --no-cache       bash       jq       tzdata       fontconfig       liberation-fonts       zlib       icu-data-full       musl-locales" did not complete successfully: exit code: 7
Error: Process completed with exit code 1.
