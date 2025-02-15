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
gitrunner@mo066inflrun05 ~ $ansible-playbook -i inventory.ini playbook_copy_nfs.yaml -e "repo_name=test-abc"

PLAY [Copy Application to NFS] ********************************************************************************************************************************************

TASK [Ensure extra_excludes is treated as a list] *************************************************************************************************************************
ok: [asstglds03.vpayusa.net]

TASK [Convert exclude_files to a list if not already] *********************************************************************************************************************
ok: [asstglds03.vpayusa.net]

TASK [Merge exclude_files and extra_excludes] *****************************************************************************************************************************
ok: [asstglds03.vpayusa.net]

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
fatal: [asstglds03.vpayusa.net]: FAILED! => {"msg": "An unhandled exception occurred while templating '{{ reponame }}'. Error was a <class 'ansible.errors.AnsibleError'>, original message: An unhandled exception occurred while templating '{{ reponame }}'. Error was a <class 'ansible.errors.AnsibleError'>, original message: An unhandled exception occurred while templating '{{ reponame }}'. Error was a <class 'ansible.errors.AnsibleError'>, original message: An unhandled exception occurred while templating '{{ reponame }}'. Error was a <class 'ansible.errors.AnsibleError'>, original message: An unhandled exception occurred while templating '{{ reponame }}'. Error was a <class 'ansible.errors.AnsibleError'>, original message: An unhandled exception occurred while templating '{{ reponame }}'. Error was a <class 'ansible.errors.AnsibleError'>, original message: An unhandled exception occurred while templating '{{ reponame }}'. Error was a <class 'ansible.errors.AnsibleError'>, original message: An unhandled exception occurred while templating '{{ reponame }}'.
