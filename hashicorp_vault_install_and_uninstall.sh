---
- name: Deploy Application
  hosts: all
  become: yes
  vars:
    reponame: "{{ reponame }}"
    dest_dir: "{{ dest_dir }}"
    timestamp: "{{ lookup('pipe', 'date +%H_%M_%S') }}"
    archive_dir: "/SRVFS/bogner/deploymentBackup/{{ inventory_hostname }}/{{ reponame }}/{{ lookup('pipe', 'date +%Y/%m/%d') }}/{{ timestamp }}/"

  tasks:
    - name: Validate destination directory path
      fail:
        msg: "{{ dest_dir }} does not look correct. The path needs to be /home/bogner/*"
      when: dest_dir is not regex('/home/bogner/.+')

    - name: Ensure destination directory exists
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0755'

    - name: Archive existing files if directory is not empty
      block:
        - name: Ensure archive directory exists
          file:
            path: "{{ archive_dir }}"
            state: directory
            mode: '0755'

        - name: Archive files
          command: >
            tar --remove-files --exclude="*.egg-info"
            -cf {{ archive_dir }}/{{ timestamp }}.tgz -C {{ dest_dir }} .
          args:
            removes: "{{ dest_dir }}"
      when: dest_dir is directory and dest_dir | length > 0

    - name: Deploy application files
      copy:
        src: "{{ reponame }}/"
        dest: "{{ dest_dir }}"
        mode: '0755'
      register: deploy_result

    - name: Restore from archive if deploy fails
      block:
        - name: Extract archive
          command: "tar -xvf {{ archive_dir }}/{{ timestamp }}.tgz -C {{ dest_dir }}"

        - name: Remove archive
          file:
            path: "{{ archive_dir }}/{{ timestamp }}.tgz"
            state: absent
      when: deploy_result is failed



---
- name: Copy Application to NFS
  hosts: all
  become: yes
  vars:
    reponame: "{{ reponame }}"
    target_dir: "{{ reponame.split('-')[1] | default('') }}"
    dest_dir: "/SRVFS/tpa_configs/{{ target_dir }}"
    extra_excludes: "{{ extra_excludes | default([]) }}"
  
  vars_files:
    - vars/exclude_nfs.yml

  tasks:
    - name: Merge exclude_nfs and extra_excludes
      set_fact:
        final_excludes: "{{ exclude_nfs + extra_excludes }}"

    - name: Check if repo is in exclude list
      set_fact:
        exclude_repo: "{{ reponame | lower in final_excludes }}"

    - name: Ensure destination directory exists
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0755'
      when: not exclude_repo

    - name: Remove existing files in destination directory
      file:
        path: "{{ dest_dir }}/*"
        state: absent
      when: not exclude_repo

    - name: Copy application files to NFS
      copy:
        src: "{{ reponame }}/"
        dest: "{{ dest_dir }}"
        mode: '0755'
      when: not exclude_repo



---
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


- name: Deploy Application
      run: |
        ansible-playbook deploy.yml \
          -i inventory.ini \
          -e "reponame=${{ inputs.reponame }}" \
          -e "dest_dir=/home/bogner/${{ inputs.reponame }}" \
          -e "extra_excludes=${{ inputs.extra_excludes }}"

    - name: Copy to NFS
      run: |
        ansible-playbook copy_nfs.yml \
          -i inventory.ini \
          -e "reponame=${{ inputs.reponame }}" \
          -e "extra_excludes=${{ inputs.extra_excludes }}"
