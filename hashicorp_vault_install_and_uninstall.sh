gitrunner@mo066inflrun05 ~ $ansible -m ping all -i hosts -u bogner
[WARNING]: Unhandled error in Python interpreter discovery for host asstglds01.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Unhandled error in Python interpreter discovery for host asstglds02.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Unhandled error in Python interpreter discovery for host asstglbum01.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Platform linux on host asstglds02.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.8, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
asstglds02.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.8"
    },
    "changed": false,
    "module_stderr": "Shared connection to asstglds02.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.8: command not found\r\n\r\nThe `python3.8' command exists in these Python versions:\r\n  3.8.18\r\n\r\nNote: See 'pyenv help global' for tips on allowing both\r\n      python2 and python3 to be found.\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
[WARNING]: Platform linux on host asstglds01.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.8, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
asstglds01.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.8"
    },
    "changed": false,
    "module_stderr": "Shared connection to asstglds01.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.8: command not found\r\n\r\nThe `python3.8' command exists in these Python versions:\r\n  3.8.18\r\n\r\nNote: See 'pyenv help global' for tips on allowing both\r\n      python2 and python3 to be found.\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
asstglds03.tap.net | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
[WARNING]: Platform linux on host asstglbum01.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.8, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
asstglbum01.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.8"
    },
    "changed": false,
    "module_stderr": "Shared connection to asstglbum01.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.8: command not found\r\n\r\nThe `python3.8' command exists in these Python versions:\r\n  3.8.18\r\n\r\nNote: See 'pyenv help global' for tips on allowing both\r\n      python2 and python3 to be found.\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
[WARNING]: Unhandled error in Python interpreter discovery for host plprdlds01.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Unhandled error in Python interpreter discovery for host plprdlbum02.tap.net: Expecting value: line 1 column 1 (char 0)
plprdlbum01.tap.net | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
[WARNING]: Unhandled error in Python interpreter discovery for host plprdlbum03.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Platform linux on host plprdlds01.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.8, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
plprdlds01.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.8"
    },
    "changed": false,
    "module_stderr": "Shared connection to plprdlds01.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.8: command not found\r\n\r\nThe `python3.8' command exists in these Python versions:\r\n  3.8.18\r\n\r\nNote: See 'pyenv help global' for tips on allowing both\r\n      python2 and python3 to be found.\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
[WARNING]: Unhandled error in Python interpreter discovery for host plprdlbum04.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Unhandled error in Python interpreter discovery for host plprdlds02.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Platform linux on host plprdlbum02.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.7, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
plprdlbum02.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.7"
    },
    "changed": false,
    "module_stderr": "Shared connection to plprdlbum02.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.7: command not found\r\n\r\nThe `python3.7' command exists in these Python versions:\r\n  3.7.4\r\n\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
[WARNING]: Unhandled error in Python interpreter discovery for host plprdlds03.tap.net: Expecting value: line 1 column 1 (char 0)
[WARNING]: Platform linux on host plprdlds02.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.8, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
plprdlds02.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.8"
    },
    "changed": false,
    "module_stderr": "Shared connection to plprdlds02.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.8: command not found\r\n\r\nThe `python3.8' command exists in these Python versions:\r\n  3.8.18\r\n\r\nNote: See 'pyenv help global' for tips on allowing both\r\n      python2 and python3 to be found.\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
[WARNING]: Platform linux on host plprdlbum04.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.7, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
plprdlbum04.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.7"
    },
    "changed": false,
    "module_stderr": "Shared connection to plprdlbum04.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.7: command not found\r\n\r\nThe `python3.7' command exists in these Python versions:\r\n  3.7.4\r\n\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
[WARNING]: Platform linux on host plprdlbum03.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.7, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
plprdlbum03.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.7"
    },
    "changed": false,
    "module_stderr": "Shared connection to plprdlbum03.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.7: command not found\r\n\r\nThe `python3.7' command exists in these Python versions:\r\n  3.7.4\r\n\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
[WARNING]: Platform linux on host plprdlds03.tap.net is using the discovered Python interpreter at /home/bogner/.pyenv/shims/python3.8, but future installation of
another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
plprdlds03.tap.net | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/home/bogner/.pyenv/shims/python3.8"
    },
    "changed": false,
    "module_stderr": "Shared connection to plprdlds03.tap.net closed.\r\n",
    "module_stdout": "pyenv: python3.8: command not found\r\n\r\nThe `python3.8' command exists in these Python versions:\r\n  3.8.18\r\n\r\nNote: See 'pyenv help global' for tips on allowing both\r\n      python2 and python3 to be found.\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 127
}
gitrunner@mo066inflrun05 ~ $ansible --version
ansible [core 2.12.0]
  config file = None
  configured module search path = ['/home/gitrunner/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/gitrunner/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.10.12 (main, Jan 17 2025, 14:35:34) [GCC 11.4.0]
  jinja version = 3.0.3
  libyaml = True
