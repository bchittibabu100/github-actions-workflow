jobs:
  replace-vars:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set environment variables
        run: |
          # Simulated environment variables (example)
          export bamboo_vpay_FaxMan_prod_DBPassword='faxpass'
          export bamboo_vpay_DocSys_prod_DBPassword='docpass'
          export bamboo_vpay_FaxMan_prod_ApiKey='faxkey'
          export bamboo_vpay_DocSys_prod_ApiKey='dockey'

      - name: Replace template variables
        run: |
          inputSysNames="FaxMan,DocSys"
          envName="prod"
          orig="./appsettings.template-secure.json"
          dest="./appsettings.secure.json"

          IFS=',' read -r -a sysArray <<< "$inputSysNames"

          for sys in "${sysArray[@]}"
          do
            searchString="bamboo_vpay_${sys}_${envName}_"
            VARS=($(compgen -v | grep -P "$searchString"))
            
            for i in "${VARS[@]}"
            do
              var=$(echo "$i" | sed "s/bamboo_vpay_${sys}_${envName}_/${sys}/")
              if grep -q "$var" "$orig"; then
                echo "Replacing '$var' with '${!i}' in file '$orig'"
                sed -i "s|{{$var}}|${!i}|" "$orig"
              fi
            done
          done
          mv "$orig" "$dest"
