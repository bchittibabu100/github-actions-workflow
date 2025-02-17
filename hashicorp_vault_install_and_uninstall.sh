TASK [Copy application files to NFS] **************************************************************************************************************************************
fatal: [asstglds03.test.net]: FAILED! => {"changed": false, "checksum": "e1e362e35921a6b9aee926fca789b8206a0c9149", "cur_context": ["system_u", "object_r", "cifs_t", "s0"], "gid": 858806941, "group": "smb_stg_service_rw", "input_was": ["system_u", "object_r", "default_t", "s0"], "mode": "0777", "msg": "invalid selinux context: [Errno 95] Operation not supported", "new_context": ["system_u", "object_r", "default_t", "s0"], "owner": "smbstlstgapps", "path": "/SRVFS/tpa_configs/abc1/.ansible_tmp1mpvnrjlabc_eob_maker.py", "secontext": "system_u:object_r:cifs_t:s0", "size": 31440, "state": "file", "uid": 858806934}

PLAY RECAP ****************************************************************************************************************************************************************
asstglds03.test.net     : ok=8    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

gitrunner@mo066inflrun05 ~/actions-runner/_work/vpay-abc/vpay-abc $cat ~/playbook_copy_nfs.yaml | tail
    - name: Copy application files to NFS
      remote_user: bogner
      copy:
        src: "{{ source_dir }}/{{ reponame }}/"
        dest: "{{ dest_dir }}"
        mode: '0755'
      when: not exclude_repo
