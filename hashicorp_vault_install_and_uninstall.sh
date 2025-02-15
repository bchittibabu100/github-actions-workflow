gitrunner@mo066inflrun05 ~ $ansible-playbook -i inventory.ini playbook_copy_nfs.yaml -e "reponame=test-abc1" -v
No config file found; using defaults

PLAY [Copy Application to NFS] ********************************************************************************************************************************************

TASK [Ensure extra_excludes is treated as a list] *************************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {"ansible_facts": {"extra_excludes_list": []}, "changed": false}

TASK [Convert exclude_files to a list if not already] *********************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {"ansible_facts": {"exclude_files_list": ["835_docs_generator", "bcf_transfer", "brdautosignature", "brdautosignature_py3", "brduploadmonitor", "brduploadmonitor_py3", "client_provider_report", "document_system", "dual_spec_process", "dual_spec_process_py3", "fax_server", "fileinterrogator", "fileinterrogator_py3", "fixed_length_process", "fixed_length_process_py3", "fssi", "fssi_cas", "herring_parser", "heq", "heq_provider_report", "importnonfundedpayment", "importnonfundedpayment_py3", "meta_check_images", "monday_reports", "parser_configs", "pep_file_process", "pep_file_process_py3", "rc", "recon", "red_card", "tigerteam", "transcard", "transfer835"]}, "changed": false}

TASK [Merge exclude_files and extra_excludes] *****************************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {"ansible_facts": {"final_excludes": ["835_docs_generator", "bcf_transfer", "brdautosignature", "brdautosignature_py3", "brduploadmonitor", "brduploadmonitor_py3", "client_provider_report", "document_system", "dual_spec_process", "dual_spec_process_py3", "fax_server", "fileinterrogator", "fileinterrogator_py3", "fixed_length_process", "fixed_length_process_py3", "fssi", "fssi_cas", "herring_parser", "heq", "heq_provider_report", "importnonfundedpayment", "importnonfundedpayment_py3", "meta_check_images", "monday_reports", "parser_configs", "pep_file_process", "pep_file_process_py3", "rc", "recon", "red_card", "tigerteam", "transcard", "transfer835"]}, "changed": false}

TASK [Print final_excludes] ***********************************************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {
    "final_excludes": [
        "835_docs_generator",
        "bcf_transfer",
        "brdautosignature",
        "brdautosignature_py3",
        "brduploadmonitor",
        "brduploadmonitor_py3",
        "client_provider_report",
        "document_system",
        "dual_spec_process",
        "dual_spec_process_py3",
        "fax_server",
        "fileinterrogator",
        "fileinterrogator_py3",
        "fixed_length_process",
        "fixed_length_process_py3",
        "fssi",
        "fssi_cas",
        "herring_parser",
        "heq",
        "heq_provider_report",
        "importnonfundedpayment",
        "importnonfundedpayment_py3",
        "meta_check_images",
        "monday_reports",
        "parser_configs",
        "pep_file_process",
        "pep_file_process_py3",
        "rc",
        "recon",
        "red_card",
        "tigerteam",
        "transcard",
        "transfer835"
    ]
}

TASK [Check if repo is in exclude list] ***********************************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {"ansible_facts": {"exclude_repo": false}, "changed": false}

TASK [Print repo is in exclude list] **************************************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {
    "exclude_repo": false
}

TASK [Ensure destination directory exists] ********************************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {"changed": false, "gid": 858806941, "group": "smb_stg_service_rw", "mode": "0777", "owner": "smbstlstgapps", "path": "/SRVFS/tpa_configs/abc1", "secontext": "system_u:object_r:cifs_t:s0", "size": 0, "state": "directory", "uid": 858806934}

TASK [Remove existing files in destination directory] *********************************************************************************************************************
ok: [asstglds03.vpayusa.net] => {"changed": false, "path": "/SRVFS/tpa_configs/abc1/*", "state": "absent"}

PLAY RECAP ****************************************************************************************************************************************************************
asstglds03.vpayusa.net     : ok=8    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

gitrunner@mo066inflrun05 ~ $cat playbook_copy_nfs.yaml
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

    - name: Check if repo is in exclude list
      set_fact:
        exclude_repo: "{{ reponame | lower in final_excludes }}"

    - name: Print repo is in exclude list
      debug:
        var: exclude_repo

    - name: Ensure destination directory exists
      remote_user: bogner
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0755'
      when: not exclude_repo

    - name: Remove existing files in destination directory
      remote_user: bogner
      file:
        path: "{{ dest_dir }}/*"
        state: absent
      when: not exclude_repo

bogner@asstglds03 /SRVFS/tpa_configs/abc1 $ ll /SRVFS/tpa_configs/abc1/*
-rwxrwxrwx. 1 smbstlstgapps smb_stg_service_rw 12 Feb 14 23:29 /SRVFS/tpa_configs/abc1/1.txt
-rwxrwxrwx. 1 smbstlstgapps smb_stg_service_rw 16 Feb 14 23:29 /SRVFS/tpa_configs/abc1/2.txt

Why the folder abc1 not empty ?
