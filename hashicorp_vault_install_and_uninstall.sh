gitrunner@mo066inflrun05 ~/actions-runner/_work/vpay-abc/vpay-abc/vpay-abc $ansible-playbook /home/gitrunner/playbook_deploy.yaml -i /home/gitrunner/inventory.ini -e "reponame=tpa-abc" -e "dest_dir=/home/bogner/tpa-abc" -e "extra_excludes=" -C -u bogner

PLAY [Deploy Application] *************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************
fatal: [asstglds01.tpa.net]: FAILED! => {"ansible_facts": {}, "changed": false, "failed_modules": {"ansible.legacy.setup": {"failed": true, "module_stderr": "Shared connection to asstglds01.tpa.net closed.\r\n", "module_stdout": "/bin/sh: /root/.pyenv/shims/python: No such file or directory\r\n", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 127}}, "msg": "The following modules failed to execute: ansible.legacy.setup\n"}
