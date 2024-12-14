      - name: Copy artifacts
        run: |
          scp artifacts/* bamboosa@asstglds01.example.net:/usr/local/example/docsys/parsing
          scp artifacts/* bamboosa@asstglds02.example.net:/usr/local/example/docsys/parsing
          scp artifacts/* bamboosa@asstglds03.example.net:/usr/local/example/docsys/parsing
        shell: bash

      - name: Restart Parsing API service
        if: env.env_name == 'stage'
        run: |
          ssh bamboosa@asstglds01.example.net "sudo systemctl reload-or-restart kestrel-example-docsys-parsing-api.service"
          ssh bamboosa@asstglds02.example.net "sudo systemctl reload-or-restart kestrel-example-docsys-parsing-api.service"
          ssh bamboosa@asstglds03.example.net "sudo systemctl reload-or-restart kestrel-example-docsys-parsing-api.service"
        shell: bash
