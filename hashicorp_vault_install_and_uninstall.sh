- name: Validate Vault path and check permissions
        id: validate_path
        run: |
          SECRET_PATH="${{ inputs.secret_path }}"
          GITHUB_USER="${{ github.actor }}"
          MOUNT_PATH=$(echo "$SECRET_PATH" | cut -d'/' -f1)

          # Define valid Vault mounts
          VALID_MOUNTS="devops DBA engineering secret roletest"
          if ! echo "$VALID_MOUNTS" | grep -qw "$MOUNT_PATH"; then
              echo "Invalid Vault mount path. Allowed mounts are: $VALID_MOUNTS"
              exit 1
          fi
          echo "Vault mount path $MOUNT_PATH is valid."

          # Fetch user's teams
          TEAMS_RESPONSE=$(curl -s -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
                           "https://api.github.com/users/$GITHUB_USER/teams")
          echo "Teams API Response: $TEAMS_RESPONSE"
          
          TEAMS=$(echo "$TEAMS_RESPONSE" | jq -r 'if type=="array" then .[].slug else empty end')
          if [ -z "$TEAMS" ]; then
              echo "No teams found or invalid response: $TEAMS_RESPONSE"
              exit 1
          fi
          echo "Teams for user $GITHUB_USER: $TEAMS"

          # Determine allowed paths based on team membership
          ALLOWED_PATHS=""
          if echo "$TEAMS" | grep -qw "AZU_OFT_COMMPAY_DEVOPS"; then
              ALLOWED_PATHS="devops DBA engineering secret roletest"
          elif echo "$TEAMS" | grep -qw "AZU_OFT_COMMPAY_DEVLEADS"; then
              ALLOWED_PATHS="DBA"
          elif echo "$TEAMS" | grep -qw "AZU_OFT_COMMPAY_ENGINEERING"; then
              ALLOWED_PATHS="engineering secret"
          else
              echo "User $GITHUB_USER is not in a recognized team. Access denied."
              exit 1
          fi

          # Check if the user is authorized for the specified path
          if ! echo "$ALLOWED_PATHS" | grep -qw "$MOUNT_PATH"; then
              echo "User $GITHUB_USER is not allowed to write to mount path: $MOUNT_PATH"
              exit 1
          fi
          echo "User $GITHUB_USER is authorized to write to the path: $MOUNT_PATH"
