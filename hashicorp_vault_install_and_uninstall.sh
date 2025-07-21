Runner logs:
[2025-07-21 16:18:56Z ERR  TempDirectoryManager] System.UnauthorizedAccessException: Access to the path '/home/gitrunner/actions-runner/_work/_temp/_github_home/.kube' is denied.
 ---> System.IO.IOException: Permission denied

 
Noticed following to hidden directories having root as owner and group
ls -la /home/gitrunner/actions-runner/_work/_temp/_github_home/
drwxr-xr-x 4 gitrunner gitrunner   4096 Jul 18 06:52 .
drwxr-xr-x 8 gitrunner gitrunner 176128 Jul 21 11:46 ..
drwxr-xr-x 3 root      root        4096 Jul 18 06:52 .cache
drwxr-x--- 3 root      root        4096 Jul 18 06:52 .kube


Only these repo shows up group as docker rest all shows as gitrunner
ls -la /home/gitrunner/actions-runner/_work/ | grep docker
drwxr-xr-x   4 gitrunner docker      4096 Jul 19  2023 chk-fax-management
drwxr-xr-x   3 gitrunner docker      4096 Apr  7 13:36 chk-generation
drwxr-xr-x   3 gitrunner docker      4096 Apr  9 04:46 chk-parsing


gitrunner@mo066inflrun01 ~/actions-runner/_diag $ls -l /home/gitrunner/actions-runner/_work/_temp/
total 236
drwxr-xr-x 3 gitrunner gitrunner   4096 Jul 21 04:48 __default-support
drwx------ 2 gitrunner gitrunner   4096 Jul 21 08:37 docker-actions-toolkit-5bNpHP
drwx------ 2 root      root        4096 Jul 21 15:07 docker-actions-toolkit-aBiaLl
drwx------ 2 root      root        4096 Jul 21 15:15 docker-actions-toolkit-DJegoa
drwx------ 2 root      root        4096 Jul 21 15:05 docker-actions-toolkit-DmPfFP
drwx------ 2 root      root        4096 Jul 21 15:25 docker-actions-toolkit-ELMnMI
drwx------ 2 gitrunner gitrunner   4096 Jul 21 08:37 docker-actions-toolkit-FYL7bE
drwx------ 2 root      root        4096 Jul 21 15:05 docker-actions-toolkit-hFflFj
drwx------ 2 root      root        4096 Jul 21 15:13 docker-actions-toolkit-jLjCLc
drwx------ 2 root      root        4096 Jul 21 15:20 docker-actions-toolkit-lbnECA
drwx------ 2 root      root        4096 Jul 21 15:22 docker-actions-toolkit-LikHjH
drwx------ 2 root      root        4096 Jul 21 15:23 docker-actions-toolkit-lLJjMn
drwx------ 2 root      root        4096 Jul 21 15:14 docker-actions-toolkit-MMACAE
drwx------ 2 root      root        4096 Jul 21 15:07 docker-actions-toolkit-nboHiN
drwx------ 2 root      root        4096 Jul 21 15:19 docker-actions-toolkit-NceCea
drwxr-xr-x 5 gitrunner gitrunner   4096 Jul 21 15:05 _github_home
drwxr-xr-x 2 gitrunner gitrunner   4096 Jul 18 06:52 _github_workflow
drwxr-xr-x 2 gitrunner gitrunner 167936 Jul 21 15:33 _runner_file_commands


mo066inflrun01 ~ # whoami
root
mo066inflrun01 ~ # cat /etc/systemd/system/actions.runner.optum-financial.vpay-mo066inflrun01.service
[Unit]
Description=GitHub Actions Runner (optum-financial.vpay-mo066inflrun01)
After=network.target

[Service]
ExecStart=/home/gitrunner/actions-runner/runsvc.sh
User=gitrunner
WorkingDirectory=/home/gitrunner/actions-runner
KillMode=process
KillSignal=SIGTERM
TimeoutStopSec=5min

[Install]
WantedBy=multi-user.target
