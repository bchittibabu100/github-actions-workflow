gitrunner@mo066inflrun05 ~ $ansible-playbook -i inventory.ini playbook_copy_nfs.yaml -e repo_name=test-abc -e extra_excludes=123.txt,abc.yaml

PLAY [Copy Application to NFS] ********************************************************************************************************************************************

TASK [Merge exclude_files and extra_excludes] *****************************************************************************************************************************
fatal: [asstglds03.test.net]: FAILED! => {"msg": "Unexpected templating type error occurred on ({{ exclude_files + extra_excludes }}): can only concatenate list (not \"str\") to list"}

PLAY RECAP ****************************************************************************************************************************************************************
asstglds03.vpayusa.net     : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

gitrunner@mo066inflrun05 ~ $cat playbook_copy_nfs.yaml
---
- name: Copy Application to NFS
  hosts: asstglds03.vpayusa.net
  gather_facts: no
  vars:
    reponame: "{{ reponame }}"
    target_dir: "{{ reponame.split('-')[1] | default('') }}"
    dest_dir: "/SRVFS/tpa_configs/{{ target_dir }}"
    extra_excludes: "{{ extra_excludes | default([]) }}"

  vars_files:
    - exclude_files.yaml

  tasks:
    - name: Merge exclude_files and extra_excludes
      set_fact:
        final_excludes: "{{ exclude_files + extra_excludes }}"

    - name: Printing final_excludes
      debug:
        var: final_excludes

gitrunner@mo066inflrun05 ~ $cat exclude_files.yaml
---
exclude_files:
  - "835_docs_generator"
  - "bcf_transfer"
  - "brdautosignature"
  - "brdautosignature_py3"
  - "brduploadmonitor"
