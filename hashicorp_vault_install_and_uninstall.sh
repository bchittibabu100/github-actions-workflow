sudo mkdir -p /etc/systemd/system/actions.runner.optum-financial.vpay-mo066inflrun01.service.d
sudo vim /etc/systemd/system/actions.runner.optum-financial.vpay-mo066inflrun01.service.d/override.conf

[Service]
ExecStartPre=/bin/bash -c 'find /home/gitrunner/actions-runner/_work/_temp -user root -exec chown -R gitrunner:gitrunner {} +'

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart actions.runner.optum-financial.vpay-mo066inflrun01.service
