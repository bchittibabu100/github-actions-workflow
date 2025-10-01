[CheckNumberDatabase]
hostname={{ lookup('community.hashi_vault.hashi_vault', 'dba/Accounts/Application/stage/PLATFORM/OCFParser:hostname', auth_method='token', token=vault_token, url=vault_addr) }}
password={{ lookup('community.hashi_vault.hashi_vault', 'dba/Accounts/Application/stage/PLATFORM/OCFParser:password', auth_method='token', token=vault_token, url=vault_addr) }}
username={{ lookup('community.hashi_vault.hashi_vault', 'dba/Accounts/Application/stage/PLATFORM/OCFParser:username', auth_method='token', token=vault_token, url=vault_addr) }}
database={{ lookup('community.hashi_vault.hashi_vault', 'dba/Accounts/Application/stage/PLATFORM/OCFParser:database', auth_method='token', token=vault_token, url=vault_addr) }}

---
- name: Generate config.ini from Vault
  hosts: all
  vars:
    vault_addr: "http://127.0.0.1:8200"   # Replace with your Vault address
    vault_token: "{{ lookup('env', 'VAULT_TOKEN') }}"  # Read token from env
  tasks:
    - name: Template config.ini with Vault secrets
      ansible.builtin.template:
        src: templates/config.ini.j2
        dest: /etc/myapp/config.ini
        owner: myuser
        group: mygroup
        mode: '0640'
