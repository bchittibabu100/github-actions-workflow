gitrunner@mo066inflrun05 ~/actions-runner/_work/vpay-abc/vpay-abc/vpay-abc $ansible-playbook /home/gitrunner/playbook_deploy.yaml -i /home/gitrunner/inventory.ini -e "reponame=vpay-abc" -e "dest_dir=/home/bogner/vpay-abc" -e "extra_excludes=" -C -u bogner

PLAY [Deploy Application] *************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************
fatal: [asstglds01.vpayusa.net]: FAILED! => {"ansible_facts": {}, "changed": false, "failed_modules": {"ansible.legacy.setup": {"failed": true, "module_stderr": "Shared connection to asstglds01.vpayusa.net closed.\r\n", "module_stdout": "/bin/sh: /root/.pyenv/shims/python: No such file or directory\r\n", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 127}}, "msg": "The following modules failed to execute: ansible.legacy.setup\n"}
