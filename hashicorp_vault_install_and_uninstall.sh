ansible-galaxy collection install community.hashi_vault -vvv
ansible-galaxy [core 2.12.0]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible-galaxy
  python version = 3.10.12 (main, Aug 15 2025, 14:32:43) [GCC 11.4.0]
  jinja version = 3.0.3
  libyaml = True
No config file found; using defaults
Starting galaxy collection install process
Process install dependency map
ERROR! Unexpected Exception, this is probably a bug: CollectionDependencyProvider.find_matches() got an unexpected keyword argument 'identifier'
the full traceback was:

Traceback (most recent call last):
  File "/usr/bin/ansible-galaxy", line 128, in <module>
    exit_code = cli.run()
  File "/usr/lib/python3/dist-packages/ansible/cli/galaxy.py", line 567, in run
    return context.CLIARGS['func']()
  File "/usr/lib/python3/dist-packages/ansible/cli/galaxy.py", line 86, in method_wrapper
    return wrapped_method(*args, **kwargs)
  File "/usr/lib/python3/dist-packages/ansible/cli/galaxy.py", line 1201, in execute_install
    self._execute_install_collection(
  File "/usr/lib/python3/dist-packages/ansible/cli/galaxy.py", line 1228, in _execute_install_collection
    install_collections(
  File "/usr/lib/python3/dist-packages/ansible/galaxy/collection/__init__.py", line 513, in install_collections
    dependency_map = _resolve_depenency_map(
  File "/usr/lib/python3/dist-packages/ansible/galaxy/collection/__init__.py", line 1327, in _resolve_depenency_map
    return collection_dep_resolver.resolve(
  File "/usr/lib/python3/dist-packages/resolvelib/resolvers.py", line 481, in resolve
    state = resolution.resolve(requirements, max_rounds=max_rounds)
  File "/usr/lib/python3/dist-packages/resolvelib/resolvers.py", line 348, in resolve
    self._add_to_criteria(self.state.criteria, r, parent=None)
  File "/usr/lib/python3/dist-packages/resolvelib/resolvers.py", line 147, in _add_to_criteria
    matches = self._p.find_matches(
TypeError: CollectionDependencyProvider.find_matches() got an unexpected keyword argument 'identifier'
