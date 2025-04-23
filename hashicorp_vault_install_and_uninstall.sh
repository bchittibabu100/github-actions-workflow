      - name: Deploy and Restart Services on asstglds03.test.net
        run: |
          scp -r saved_artifacts/listener-artifacts/* bamboosa@asstglds03.test.net:/usr/local/vpay/faxmanagement/ || echo "Failed to copy artifacts to asstglds03.test.net"
          ssh bamboosa@asstglds03.test.net "sudo chmod -R 755 /usr/local/vpay/faxmanagement/*" || echo "Failed to set permissions on asstglds03.test.net"
          ssh bamboosa@asstglds03.test.net "sudo chown -R bamboosa:bogner /usr/local/vpay/faxmanagement" || echo "Failed to set permissions on asstglds03.test.net"
          ssh bamboosa@asstglds03.test.net "sudo systemctl reload-or-restart faxman-listener.service" || echo "Failed to restart service on asstglds03.test.net"
        shell: bash


would like to perform similar steps across these servers
asstglas-fax02.test.net
asstglds01.test.net
asstglds02.test.net
asstglds03.test.net
