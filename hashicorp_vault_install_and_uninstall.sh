---
- name: Deploy to Production
  hosts: all
  become: yes
  vars:
    tpa: "{{ tpa }}"
    dest_dir: "/home/bogner/{{ tpa }}"
    archive_dir: "/SRVFS/bogner/deploymentBackup/{{ inventory_hostname }}/{{ tpa }}/{{ ansible_date_time.year }}/{{ ansible_date_time.month }}/{{ ansible_date_time.day }}/{{ ansible_date_time.hour }}_{{ ansible_date_time.minute }}_{{ ansible_date_time.second }}/"

  tasks:
    - name: Ensure destination directory exists
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0755'

    - name: Ensure archive directory exists
      file:
        path: "{{ archive_dir }}"
        state: directory
        mode: '0755'

    - name: Archive existing files if destination exists
      ansible.builtin.shell: |
        if [ -d "{{ dest_dir }}" ]; then
          tar --remove-files --exclude "*.egg-info" -cf "{{ archive_dir }}/backup.tgz" -C "{{ dest_dir }}" .
        fi
      args:
        executable: /bin/bash

    - name: Copy files to the server
      ansible.builtin.copy:
        src: "{{ tpa }}/"
        dest: "{{ dest_dir }}"
        mode: '0755'
    
    - name: Restore from archive if deploy fails
      ansible.builtin.shell: |
        if [ ! -d "{{ dest_dir }}" ]; then
          mkdir -p "{{ dest_dir }}"
          tar -xvf "{{ archive_dir }}/backup.tgz" -C "{{ dest_dir }}"
        fi
      args:
        executable: /bin/bash



---
- name: Copy files to NFS for Staging
  hosts: all
  become: yes
  vars:
    tpa: "{{ tpa }}"
    target_dir: "{{ target_dir }}"
    dest_dir: "{{ target_dir | regex_replace('/home/bogner/', '/SRVFS/tpa_configs/') }}"
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

  tasks:
    - name: Check if TPA is in the exclusion list
      set_fact:
        excluded: "{{ tpa | lower in exclude_nfs }}"

    - name: Ensure destination directory exists on NFS
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0755'
      when: not excluded

    - name: Clear existing files in destination
      ansible.builtin.shell: "rm -rf {{ dest_dir }}/*"
      when: not excluded

    - name: Copy files to the NFS destination
      ansible.builtin.copy:
        src: "{{ tpa }}/"
        dest: "{{ dest_dir }}"
        mode: '0755'
      when: not excluded



- name: Deploy to Production
  if: ${{ inputs.environment == 'Production' }}
  run: |
    ansible-playbook deploy.yml -e "tpa=${{ github.event.repository.name }}"

- name: Copy files to Staging NFS
  if: ${{ inputs.environment == 'Staging' }}
  run: |
    ansible-playbook copy_nfs.yml -e "tpa=${{ github.event.repository.name }} target_dir=/home/bogner/${{ github.event.repository.name }}"

