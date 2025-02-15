---
- name: Copy Application to NFS
  hosts: asstglds03.vpayusa.net
  gather_facts: no
  vars:
    reponame: "{{ reponame }}"
    target_dir: "{{ reponame.split('-')[1] | default('') }}"
    dest_dir: "/SRVFS/tpa_configs/{{ target_dir }}"

  vars_files:
    - exclude_files.yaml

  tasks:
    - name: Ensure extra_excludes is treated as a list
      set_fact:
        extra_excludes_list: "{{ extra_excludes.split(',') if extra_excludes is string else extra_excludes | default([]) }}"

    - name: Convert exclude_files to a list if not already
      set_fact:
        exclude_files_list: "{{ exclude_files | default([]) | list }}"

    - name: Merge exclude_files and extra_excludes
      set_fact:
        final_excludes: "{{ exclude_files_list + extra_excludes_list }}"

    - name: Print final_excludes
      debug:
        var: final_excludes
        
        
        
        ---
- name: Copy Application to NFS
  hosts: asstglds03.vpayusa.net
  gather_facts: no
  vars:
    reponame: "{{ reponame }}"
    target_dir: "{{ reponame.split('-')[1] | default('') }}"
    dest_dir: "/SRVFS/tpa_configs/{{ target_dir }}"
    extra_excludes: "{{ extra_excludes | default('') | split(',') | reject('equalto', '') | list }}"

  vars_files:
    - exclude_files.yaml

  tasks:
    - name: Ensure extra_excludes is treated as a list
      debug:
        msg: "extra_excludes: {{ extra_excludes }}"

    - name: Convert exclude_files to list if not already
      set_fact:
        exclude_files: "{{ exclude_files | default([]) | list }}"

    - name: Merge exclude_files and extra_excludes
      set_fact:
        final_excludes: "{{ exclude_files + extra_excludes }}"

    - name: Printing final_excludes
      debug:
        var: final_excludesgitrunner@mo066inflrun05 ~ $ansible-playbook -i inventory.ini playbook_copy_nfs.yaml -e "repo_name=test-abc" -e "extra_excludes=123.txt,abc.yaml"

PLAY [Copy Application to NFS] ********************************************************************************************************************************************

TASK [Ensure extra_excludes is treated as a list] *************************************************************************************************************************
ok: [asstglds03.test.net] => {
    "msg": "extra_excludes: 123.txt,abc.yaml"
}

TASK [Merge exclude_files and extra_excludes] *****************************************************************************************************************************
fatal: [asstglds03.test.net]: FAILED! => {"msg": "Unexpected templating type error occurred on ({{ exclude_files + extra_excludes }}): can only concatenate list (not \"str\") to list"}

PLAY RECAP ****************************************************************************************************************************************************************
asstglds03.test.net     : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

gitrunner@mo066inflrun05 ~ $cat playbook_copy_nfs.yaml
---
- name: Copy Application to NFS
  hosts: asstglds03.vpayusa.net
  gather_facts: no
  vars:
    reponame: "{{ reponame }}"
    target_dir: "{{ reponame.split('-')[1] | default('') }}"
    dest_dir: "/SRVFS/tpa_configs/{{ target_dir }}"
    extra_excludes: "{{ extra_excludes | default('') | split(',') | select('string') | list }}"

  vars_files:
    - exclude_files.yaml

  tasks:
    - name: Ensure extra_excludes is treated as a list
      debug:
        msg: "extra_excludes: {{ extra_excludes }}"
    - name: Merge exclude_files and extra_excludes
      set_fact:
        final_excludes: "{{ exclude_files + extra_excludes }}"

    - name: Printing final_excludes
      debug:
        var: final_excludes
