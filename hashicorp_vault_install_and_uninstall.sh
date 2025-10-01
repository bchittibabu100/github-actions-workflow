Getting generic meesage of "The secret 'test' doesn't seem to exist.. The secret 'test' doesn't seem to exist". Secret exist and able to fetch it using python script with hvac module.
Does playbook looks ok ?

Playbook:
- name: Fetch Vault secret using mount_point
  hosts: localhost
  gather_facts: false

  tasks:
    - name: Get password from Vault
      ansible.builtin.set_fact:
        vault_password: >-
          {{ lookup(
            'community.hashi_vault.hashi_vault',
            'test',
            kv_version=2,
            mount_point='dba',
            url='http://10.130.112.100:8200',
            token='hvs.qnno8Z432aoJ24',
            key='password'
          ) }}

    - name: Show password
      ansible.builtin.debug:
        msg: "Vault password is: {{ vault_password }}"

Logs:
mo066inflrun01 test_ansible # ansible-galaxy collection install community.hashi_vault --force
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Downloading https://galaxy.ansible.com/api/v3/plugin/ansible/content/published/collections/artifacts/community-hashi_vault-7.0.0.tar.gz to /root/.ansible/tmp/ansible-local-419839jj4r7b_1/tmppwlp3_t9/community-hashi_vault-7.0.0-weijfb9q
Installing 'community.hashi_vault:7.0.0' to '/root/.ansible/collections/ansible_collections/community/hashi_vault'
community.hashi_vault:7.0.0 was installed successfully
mo066inflrun01 test_ansible # ansible-playbook vault_access_test.yaml -vvv
ansible-playbook [core 2.17.14]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.10/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible-playbook
  python version = 3.10.12 (main, Aug 15 2025, 14:32:43) [GCC 11.4.0] (/usr/bin/python3)
  jinja version = 3.0.3
  libyaml = True
No config file found; using defaults
host_list declined parsing /etc/ansible/hosts as it did not pass its verify_file() method
Skipping due to inventory source not existing or not being readable by the current user
script declined parsing /etc/ansible/hosts as it did not pass its verify_file() method
auto declined parsing /etc/ansible/hosts as it did not pass its verify_file() method
Skipping due to inventory source not existing or not being readable by the current user
yaml declined parsing /etc/ansible/hosts as it did not pass its verify_file() method
Skipping due to inventory source not existing or not being readable by the current user
ini declined parsing /etc/ansible/hosts as it did not pass its verify_file() method
Skipping due to inventory source not existing or not being readable by the current user
toml declined parsing /etc/ansible/hosts as it did not pass its verify_file() method
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'
Skipping callback 'default', as we already have a stdout callback.
Skipping callback 'minimal', as we already have a stdout callback.
Skipping callback 'oneline', as we already have a stdout callback.

PLAYBOOK: vault_access_test.yaml ******************************************************************************************************************************************
1 plays in vault_access_test.yaml

PLAY [Test Vault access using runtime lookup] *****************************************************************************************************************************

TASK [Fetch Vault secret into a variable] *********************************************************************************************************************************
task path: /home/cboya1/test_ansible/vault_access_test.yaml:7
exception during Jinja2 execution: Traceback (most recent call last):
  File "/usr/local/lib/python3.10/dist-packages/ansible/template/__init__.py", line 827, in _lookup
    ran = instance.run(loop_terms, variables=self._available_variables, **kwargs)
  File "/root/.ansible/collections/ansible_collections/community/hashi_vault/plugins/lookup/hashi_vault.py", line 269, in run
    ret.extend(self.get())
  File "/root/.ansible/collections/ansible_collections/community/hashi_vault/plugins/lookup/hashi_vault.py", line 316, in get
    raise AnsibleError("The secret '%s' doesn't seem to exist." % secret)
ansible.errors.AnsibleError: The secret 'test' doesn't seem to exist.
fatal: [localhost]: FAILED! => {
    "msg": "An unhandled exception occurred while running the lookup plugin 'community.hashi_vault.hashi_vault'. Error was a <class 'ansible.errors.AnsibleError'>, original message: The secret 'test' doesn't seem to exist.. The secret 'test' doesn't seem to exist."
}

PLAY RECAP ****************************************************************************************************************************************************************
localhost                  : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0


Here is the python script that works.

import hvac
import configparser

# Vault connection parameters
vault_url = "http://10.130.112.100:8200"
vault_token = "hvs.qnno8Z432aoJ24"
mount_point = "dba"
secret_path = "test"

# Create a Vault client
client = hvac.Client(url=vault_url, token=vault_token)

# Check if the client is authenticated
if client.is_authenticated():
    try:
        # Read the secret from KV v2
        response = client.secrets.kv.v2.read_secret_version(
            path=secret_path,
            mount_point=mount_point
        )
        secret_data = response['data']['data']

        # Create a configparser object and populate it
        config = configparser.ConfigParser()
        config['vault_secret'] = secret_data

        # Write to config.ini
        with open('config.ini', 'w') as configfile:
            config.write(configfile)

        print("Secrets successfully written to config.ini")
    except Exception as e:
        print(f"Error retrieving secret: {e}")
else:
    print("Vault authentication failed.")

Execution logs:
python3 vault_test.py
/home/cboya1/test_ansible/vault_test.py:17: DeprecationWarning: The raise_on_deleted_version parameter will change its default value to False in hvac v3.0.0. The current default of True will presere previous behavior. To use the old behavior with no warning, explicitly set this value to True. See https://github.com/hvac/hvac/pull/907
  response = client.secrets.kv.v2.read_secret_version(
Retrieved password: hello123
