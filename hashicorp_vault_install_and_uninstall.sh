gitrunner@mo066inflrun05 ~ $ansible-playbook -i inventory.ini playbook_copy_nfs.yaml -e "repo_name=test-abc" -e "extra_excludes=123.txt,abc.yaml"

PLAY [Copy Application to NFS] ********************************************************************************************************************************************

TASK [Ensure extra_excludes is treated as a list] *************************************************************************************************************************
ok: [asstglds03.test.net] => {
    "msg": "extra_excludes: 123.txt,abc.yaml"
}

TASK [Merge exclude_files and extra_excludes] *****************************************************************************************************************************
fatal: [asstglds03.vpayusa.net]: FAILED! => {"msg": "Unexpected templating type error occurred on ({{ exclude_files + extra_excludes }}): can only concatenate list (not \"str\") to list"}

PLAY RECAP ****************************************************************************************************************************************************************
asstglds03.vpayusa.net     : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
