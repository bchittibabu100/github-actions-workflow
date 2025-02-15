  - name: Ensure destination directory exists
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0755'
      when: not exclude_repo

 perform this task with user by name bogner 
