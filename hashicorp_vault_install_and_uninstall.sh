ExecStartPre=/bin/bash -c 'find /home/gitrunner/actions-runner/_work/_temp -user root -exec chown -R gitrunner:gitrunner {} +'
