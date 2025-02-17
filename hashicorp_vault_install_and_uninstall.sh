## Install IBM iAccessSeries app package
RUN mkdir -p /opt/ibm
COPY ./driver/ibm-iaccess-1.1.0.2-1.0.amd64.deb /opt/ibm/
RUN dpkg -i *.deb
RUN apt-get install -f
COPY ./driver/config/* /etc/

Here is the error log.....
#10 [ 5/15] RUN mkdir -p /opt/ibm
#10 DONE 0.4s
#11 [ 6/15] COPY ./driver/ibm-iaccess-1.1.0.2-1.0.amd64.deb /opt/ibm/
#11 DONE 0.0s
#12 [ 7/15] RUN dpkg -i *.deb
#12 0.180 /bin/sh: dpkg: not found
#12 ERROR: process "/bin/sh -c dpkg -i *.deb" did not complete successfully: exit code: 127
------
 > [ 7/15] RUN dpkg -i *.deb:
0.180 /bin/sh: dpkg: not found
------
Dockerfile:37
--------------------
  35 |     RUN mkdir -p /opt/ibm
  36 |     COPY ./driver/ibm-iaccess-1.1.0.2-1.0.amd64.deb /opt/ibm/
  37 | >>> RUN dpkg -i *.deb
  38 |     RUN apt-get install -f
  39 |     COPY ./driver/config/* /etc/
--------------------
ERROR: failed to solve: process "/bin/sh -c dpkg -i *.deb" did not complete successfully: exit code: 127
Error: Process completed with exit code 1.
