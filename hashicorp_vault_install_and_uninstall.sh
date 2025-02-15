gitrunner@mo066inflrun05 ~ $ansible-playbook -i inventory.ini playbook_copy_nfs.yaml -e "reponame=test-abc"

PLAY [Copy Application to NFS] ********************************************************************************************************************************************

TASK [Ensure extra_excludes is treated as a list] *************************************************************************************************************************
ok: [asstglds03.test.net]

TASK [Convert exclude_files to a list if not already] *********************************************************************************************************************
ok: [asstglds03.test.net]

TASK [Merge exclude_files and extra_excludes] *****************************************************************************************************************************
ok: [asstglds03.test.net]

TASK [Print final_excludes] ***********************************************************************************************************************************************
ok: [asstglds03.test.net] => {
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
ok: [asstglds03.test.net]

TASK [Print repo is in exclude list] **************************************************************************************************************************************
ok: [asstglds03.test.net] => {
    "exclude_repo": false
}

TASK [Ensure destination directory exists] ********************************************************************************************************************************
fatal: [asstglds03.test.net]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: \n ##     ## ########     ###    ##    ##\n ##     ## ##     ##   ## ##    ##  ##\n ##     ## ##     ##  ##   ##    ####\n ##     ## ########  ##     ##    ##\n  ##   ##  ##        #########    ##\n   ## ##   ##        ##     ##    ##\n    ###    ##        ##     ##    ##\n\n\nNOTICE TO USERS:\n\nTHIS IS A PRIVATE COMPUTER SYSTEM. It is for authorized use only. Users\n(authorized or unauthorized) have no explicit or implicit expectation of\nprivacy.\n\nAny or all uses of this system and all files on this system may be intercepted,\nmonitored, recorded, copied, audited, inspected, and disclosed to authorized\nsite personnel. By using this system, the user consents to such interception,\nmonitoring, recording, copying, auditing, inspection, and disclosure at the\ndiscretion of authorized site personnel.\n\nUnauthorized or improper use of this system may result in administrative\ndisciplinary action and civil and criminal penalties. By continuing to use this\nsystem you indicate your awareness of and consent to these terms and conditions\nof use.\n\nLOG OFF IMMEDIATELY if you do not agree to the conditions stated in this\nwarning.\n\n\ngitrunner@asstglds03.vpayusa.net: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).", "unreachable": true}

PLAY RECAP ****************************************************************************************************************************************************************
asstglds03.test.net     : ok=6    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0

gitrunner@mo066inflrun05 ~ $cat playbook_copy_nfs.yaml
---
- name: Copy Application to NFS
  hosts: asstglds03.test.net
  become: yes
  become_user: bogner
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
      become: yes
      become_user: bogner
      command: mkdir -p "{{ dest_dir }}"
      args:
        creates: "{{ dest_dir }}"
      when: not exclude_repo
