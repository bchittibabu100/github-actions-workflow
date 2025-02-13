      - name: Generate checksum for artifacts
        run: |
          tar -czvf saved_artifacts.tgz artifacts
          original_checksum=`md5sum saved_artifacts.tgz`
          echo "original_checksum=$original_checksum | cut -d' ' -f 1"  >> $GITHUB_ENV
          echo $original_checksum
        shell: bash

  deploy-stage:
    if: ${{ github.event.inputs.env == 'stage' }}
    needs: build
    runs-on:
      group: runner-group
    steps:
      - name: Download build artifacts
        run: |
          echo Original_Checksum: ${{ env.original_checksum }}
          current_checksum=`md5sum saved_artifacts.tgz | cut -d' ' -f 1`
          echo Current_Checksum: $current_checksum
          if [ "${{ env.original_checksum }}" == "$current_checksum" ]; then
            echo "Proceeding with the creation of directory"
            mkdir saved_atifacts
            tar -xzvf saved_artifacts.tgz --directory=saved_artifacts
          else
            echo "Make sure there are no other builds are in progress."
          fi
        shell: bash
