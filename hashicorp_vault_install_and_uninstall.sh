deploy_vars.yaml
tpa: "{{ lookup('env', 'TPA') }}"
dest_dir: "{{ lookup('env', 'DEST_DIR') }}"
username: "{{ lookup('env', 'USERNAME') }}"
host: "{{ lookup('env', 'HOST') }}"
timestamp: "{{ lookup('pipe', 'date +%H_%M_%S') }}"
archive_dir: "/SRVFS/bogner/deploymentBackup/{{ host }}/{{ tpa }}/{{ lookup('pipe', 'date +%Y/%m/%d/') }}{{ timestamp }}/"

copy_vars.yaml
tpa: "{{ lookup('env', 'TPA') }}"
target_dir: "{{ lookup('env', 'TARGET_DIR') }}"
username: "{{ lookup('env', 'USERNAME') }}"
host: "{{ lookup('env', 'HOST') }}"
dest_dir: "{{ target_dir | regex_replace('^/home/bogner/', '/SRVFS/tpa_configs/') }}"
tpa_lower: "{{ tpa | lower }}"
exclude_nfs:
  - "835_docs_generator"
  - "bcf_transfer"
  - "brdautosignature"
  - "brdautosignature_py3"
  - "brduploadmonitor"
  - "brduploadmonitor_py3"
  - "client_provider_report"
  - "document_system"
  - "dual_spec_process"
  - "dual_spec_process_py3"
  - "fax_server"
  - "fileinterrogator"
  - "fileinterrogator_py3"
  - "fixed_length_process"
  - "fixed_length_process_py3"
  - "fssi"
  - "fssi_cas"
  - "herring_parser"
  - "heq"
  - "heq_provider_report"
  - "importnonfundedpayment"
  - "importnonfundedpayment_py3"
  - "meta_check_images"
  - "monday_reports"
  - "parser_configs"
  - "pep_file_process"
  - "pep_file_process_py3"
  - "rc"
  - "recon"
  - "red_card"
  - "tigerteam"
  - "transcard"
  - "transfer835"

deploy
---
- name: Deploy Application to Production
  hosts: production
  gather_facts: no
  vars_files:
    - vars/deploy_vars.yml

  tasks:
    - name: Validate DEST_DIR path
      fail:
        msg: "{{ dest_dir }} does not look correct. The path needs to be /home/bogner/*"
      when: dest_dir is not regex('^/home/bogner/.+')

    - name: Ensure deployment directory exists
      ansible.builtin.file:
        path: "{{ dest_dir }}"
        state: directory
        owner: "{{ username }}"
        group: "{{ username }}"
        mode: '0755'

    - name: Create archive directory
      ansible.builtin.file:
        path: "{{ archive_dir }}"
        state: directory
        owner: "{{ username }}"
        group: "{{ username }}"
        mode: '0755'

    - name: Archive existing deployment if it exists
      ansible.builtin.command:
        cmd: "tar --remove-files --exclude '*.egg-info' -cf {{ archive_dir }}/{{ timestamp }}.tgz -C {{ dest_dir }} ."
      ignore_errors: yes
      when: ansible.builtin.stat.path is defined and ansible.builtin.stat.path.exists

    - name: Copy application files to production
      ansible.builtin.copy:
        src: "{{ tpa }}/"
        dest: "{{ dest_dir }}"
        owner: "{{ username }}"
        group: "{{ username }}"
        mode: '0755'

    - name: Rollback on failure
      block:
        - name: Restore from archive if deployment fails
          ansible.builtin.command:
            cmd: "tar -xvf {{ archive_dir }}/{{ timestamp }}.tgz -C {{ dest_dir }}/"
      rescue:
        - name: Restore failed, ensure clean state
          ansible.builtin.fail:
            msg: "Deployment failed, restoration unsuccessful!"


      copy
      ---
- name: Copy Application Files to NFS in Staging
  hosts: staging
  gather_facts: no
  vars_files:
    - vars/nfs_vars.yml

  tasks:
    - name: Exclude specific TPAs from NFS deployment
      set_fact:
        exclude: "{{ tpa_lower in exclude_nfs }}"

    - name: Ensure staging directory exists (if included)
      ansible.builtin.file:
        path: "{{ dest_dir }}"
        state: directory
        owner: "{{ username }}"
        group: "{{ username }}"
        mode: '0755'
      when: not exclude

    - name: Clear existing files in staging (if included)
      ansible.builtin.file:
        path: "{{ dest_dir }}"
        state: absent
      when: not exclude

    - name: Copy application files to NFS (if included)
      ansible.builtin.copy:
        src: "{{ tpa }}/"
        dest: "{{ dest_dir }}"
        owner: "{{ username }}"
        group: "{{ username }}"
        mode: '0755'
      when: not exclude

      
