---
- name: Check Vitals and Process Files
  hosts: localhost
  vars:
    repo_name: "{{ lookup('env', 'repo_name') }}"
    environment: "{{ ENVIRONMENT }}"
    vault_environment: "{{ lookup('env', 'vault_environment') }}"
    vpay_tpa_claims_api_url: "{{ lookup('env', 'VPAY_TPA_CLAIMS_API_URL') }}"
    vpay_tpa_RestAPI: "{{ lookup('env', 'VPAY_TPA_REST_API_URL') }}"
    vpay_tpa_mysqlhost: "{{ lookup('env', 'VPAY_TPA_MYSQLHOST') }}"
    vpay_tpa_toemail: "{{ lookup('env', 'VPAY_TPA_TOEMAIL') }}"
    vpay_tpa_fromemail: "{{ lookup('env', 'VPAY_TPA_FROMEMAIL') }}"
    vpay_tpa_voidcheck: "{{ lookup('env', 'VPAY_TPA_VOIDCHECK') }}"
    vpay_tpa_ftp: "{{ lookup('env', 'VPAY_TPA_FTPHOST') }}"
    repo_variables_file: "{{ lookup('env', 'GITHUB_WORKSPACE') }}/actions-common/tpa/repo_variables.yaml"
    repo_path: "{{ lookup('env', 'GITHUB_WORKSPACE') }}/{{ repo_name }}"
    vitals_yaml_path: "{{ repo_path }}/vitals.yaml"
    vitals_yml_path: "{{ repo_path }}/vitals.yml"
  tasks:

    - name: Check if vitals.yaml or vitals.yml exists
      stat:
        path: "{{ item }}"
      loop:
        - "{{ vitals_yaml_path }}"
        - "{{ vitals_yml_path }}"
      register: vitals_files
