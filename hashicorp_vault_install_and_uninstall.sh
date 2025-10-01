Here is the portion of my config.ini file will look like and would like to replace the value by fetching from hashicorp vault using ansible playbook. Give me playbook which works with this template.


[CheckNumberDatabase]
# `Vault Helper` deployment task in bamboo will replace anything inside of double curly braces in any text file that is targeted by it.
hostname={{ vault "dba/Accounts/Application/stage/PLATFORM/OCFParser" "hostname" }}
password={{ vault "dba/Accounts/Application/stage/PLATFORM/OCFParser" "password" }}
username={{ vault "dba/Accounts/Application/stage/PLATFORM/OCFParser" "username" }}
database={{ vault "dba/Accounts/Application/stage/PLATFORM/OCFParser" "database" }}
