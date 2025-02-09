      - name: Deploy To Production
        if: ${{ inputs.environment == 'Production' }}
        run: |
          set -x          
          function deploy() {
          
              local TPA=$1
              local DEST_DIR=$2
              local ENVIRONMENT=$3
              local USERNAME=$4
              local HOST=$5
              local TIMESTAMP=`date +%H_%M_%S`
              local ARCHIVE_DIR="/SRVFS/bogner/deploymentBackup/$HOST/$TPA/`date +%Y/%m/%d/`$TIMESTAMP/"
          
              #Make sure DEST_DIR looks correct. We don't want to accidentally delete something were not supposed to
              if [[ $DEST_DIR =~ /home/bogner/.+ ]]; then
                  echo "$DEST_DIR passed path checks"
              else
                  echo "$DEST_DIR does not look correct. The path needs to be /home/bogner/*"
                  exit 1
              fi
          
              #Setup directories and archive old files over SSH
              ssh $USERNAME@$HOST << EOF
              
                  #Make directory to deploy to if it doesn't already exist
                  if [ ! -d $DEST_DIR ]; then
                      mkdir -p $DEST_DIR;
                      if [ "\$?" != 0 ]; then
                          exit 1
                      fi 
                  
                  #If directory does exist, archive what was in it
                  else 
                      #Create archive directory directory
                      mkdir -p $ARCHIVE_DIR;
                      if [ "\$?" != 0 ]; then
                          exit 1
                      fi
          
                      cd $DEST_DIR
                      tar --remove-files \
                      --exclude "*.egg-info" \
                      -cf $ARCHIVE_DIR/$TIMESTAMP.tgz $DEST_DIR/*;
                      if [ "\$?" != 0 ]; then
                          exit 1
                      fi
                  fi
                  
          
          EOF
              #Exit with failure if archiving didn't succeed
              if [ "$?" != 0 ]; then
                  echo "Failed during setup/archiving."
                  exit 1
              fi
          
              #Deploy to server
              scp -r  $TPA/* $USERNAME@$HOST:$DEST_DIR;
              
              #Restore from archive if deploy fails
              if [ "$?" != 0 ]; then
                  echo "Deploying from archive"
                  ssh $USERNAME@$HOST << EOF
          
                      cd $ARCHIVE_DIR;
                      tar -xvf $TIMESTAMP.tgz;
                      rm $TIMESTAMP.tgz;
                      mv $ARCHIVE_DIR/* $DEST_DIR/;
          EOF
                  exit 1
              fi
              
          }
        shell: bash

      - name: Copy files To Staging
        if: ${{ inputs.environment == 'Staging' }}
        run: |
          local TPA=$1
          local TARGET_DIR=$2
          local USERNAME=$3
          local HOST=$4
          local DEST_DIR=$(sed 's|/home/bogner/|/SRVFS/tpa_configs/|g' <<< $TARGET_DIR)
          local TPA_LOWER=$(echo "${TPA}" | tr '[:upper:]' '[:lower:]')
          exclude_nfs=(
                '835_docs_generator'
                'bcf_transfer'
                'brdautosignature'
                'brdautosignature_py3'
                'brduploadmonitor'
                'brduploadmonitor_py3'
                'client_provider_report'
                'document_system'
                'dual_spec_process'
                'dual_spec_process_py3'
                'fax_server'
                'fileinterrogator'
                'fileinterrogator_py3'
                'fixed_length_process'
                'fixed_length_process_py3'
                'fssi'
                'fssi_cas'
                'herring_parser'
                'heq'
                'heq_provider_report'
                'importnonfundedpayment'
                'importnonfundedpayment_py3'
                'meta_check_images'
                'monday_reports'
                'parser_configs'
                'pep_file_process'
                'pep_file_process_py3'
                'rc'
                'recon'
                'red_card'
                'tigerteam'
                'transcard'
                'transfer835'
                )
          exclude='0'
          for i in "${exclude_nfs[@]}"
          do
              if [ "$i" == "${TPA_LOWER}" ] ; then
                  exclude='1'
              fi
          done
        
            #Copy to NFS
            if [ $exclude == '0' ]; then
              ssh $USERNAME@$HOST << EOF
              
                  #Make directory to deploy to if it doesn't already exist
                  if [ ! -d $DEST_DIR ]; then
                      mkdir -p $DEST_DIR;
                      if [ "\$?" != 0 ]; then
                          exit 1
                      fi
                  else
                    rm -r $DEST_DIR/*
                    if [ "\$?" != 0 ]; then
                        exit 1
                    fi
                  fi
          EOF
                scp -r  $TPA/* $USERNAME@$HOST:$DEST_DIR;
            fi
        shell: bash
