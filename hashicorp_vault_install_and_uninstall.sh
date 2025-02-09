---
- name: Deploy Application
  hosts: all
  become: yes
  become_user: bogner
  vars:
    ansible_python_interpreter: /home/bogner/.pyenv/shims/python  # Ensure this is set to the correct Python interpreter on the remote server
  tasks:
    - name: Check if dest_dir exists and is valid on the remote server
      stat:
        path: "{{ dest_dir }}"
      register: dest_dir_status

    - name: Fail if dest_dir is invalid
      fail:
        msg: "The destination directory {{ dest_dir }} is not valid. It must be within /home/bogner."
      when: dest_dir_status.stat.exists == False or not dest_dir | regex_search('^/home/bogner/')

    - name: Archive old files if dest_dir exists on the remote server
      shell: |
        TIMESTAMP=$(date +%H_%M_%S)
        ARCHIVE_DIR="/SRVFS/bogner/deploymentBackup/{{ inventory_hostname }}/{{ reponame }}/$(date +%Y/%m/%d)/$TIMESTAMP/"
        
        # Archive existing files if the directory exists
        if [ -d "{{ dest_dir }}" ]; then
          mkdir -p "$ARCHIVE_DIR"
          cd "{{ dest_dir }}"
          tar --remove-files --exclude "*.egg-info" -cf "$ARCHIVE_DIR/$TIMESTAMP.tgz" "{{ dest_dir }}/"*
        fi
      register: archive_result
      when: dest_dir_status.stat.exists == True

    - name: Deploy to the remote server
      copy:
        src: "{{ reponame }}/"
        dest: "{{ dest_dir }}"
        remote_src: yes
      when: archive_result.changed == False  # If archive did not happen, proceed with deployment

    - name: Restore from archive if deploy fails
      shell: |
        cd "$ARCHIVE_DIR"
        tar -xvf "$TIMESTAMP.tgz"
        rm "$TIMESTAMP.tgz"
        mv "$ARCHIVE_DIR"/* "{{ dest_dir }}/"
      when: archive_result.changed == True
      failed_when: archive_result.failed
