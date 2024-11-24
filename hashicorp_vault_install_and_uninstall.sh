name: Vault Secret Management

on:
  workflow_dispatch:
    inputs:
      vault_mount_path:
        description: "Enter the Vault secret mount path"
        required: true
      secret_key:
        description: "Enter the secret key"
        required: true
      secret_value:
        description: "Enter the secret value"
        required: true

jobs:
  validate-user-permission:
    runs-on: ubuntu-latest
    steps:
      - name: Check User Group Membership
        id: check_group
        run: |
          ORG_NAME="phi-test"
          TEAM_SLUGS=("AZU_OFT_DEVOPS" "AZU_OFT_COMMPAY_DEVLEADS" "AZU_OFT_COMMPAY_ENGINEERS")
          GITHUB_USER="${{ github.actor }}"
          USER_GROUP=""
          
          echo "Checking group membership for user: $GITHUB_USER in org: $ORG_NAME"

          for TEAM_SLUG in "${TEAM_SLUGS[@]}"; do
            echo "Checking team: $TEAM_SLUG"
            API="https://api.github.com/orgs/$ORG_NAME/teams/$TEAM_SLUG/memberships/$GITHUB_USER"
            
            RESPONSE=$(curl -s -H "Authorization: Bearer ${{ secrets.ACTIONS_PAT_TOKEN }}" "$API")
            
            # Check if the response indicates the user is active
            STATE=$(echo "$RESPONSE" | jq -r '.state // empty')
            
            if [ "$STATE" == "active" ]; then
              echo "User is active in team: $TEAM_SLUG"
              USER_GROUP="$TEAM_SLUG"
              break
            fi
          done

          if [ -z "$USER_GROUP" ]; then
            echo "User is not active in any team. Exiting."
            exit 1
          fi

          echo "User belongs to group: $USER_GROUP"
          echo "group=$USER_GROUP" >> $GITHUB_ENV

      - name: Validate Mount Path Permission
        id: validate_permission
        run: |
          VAULT_MOUNT_PATH="${{ github.event.inputs.vault_mount_path }}"
          USER_GROUP="${{ env.group }}"
          
          echo "Validating access for mount path: $VAULT_MOUNT_PATH"
          case "$USER_GROUP" in
            "AZU_OFT_DEVOPS")
              # Full access
              ;;
            "AZU_OFT_COMMPAY_DEVLEADS")
              if [ "$VAULT_MOUNT_PATH" == "/devops" ]; then
                echo "Access denied: Leads cannot write to /devops."
                exit 1
              fi
              ;;
            "AZU_OFT_COMMPAY_ENGINEERS")
              if [ "$VAULT_MOUNT_PATH" != "/engineering" ] && [ "$VAULT_MOUNT_PATH" != "/secrets" ]; then
                echo "Access denied: Engineers can only write to /engineering or /secrets."
                exit 1
              fi
              ;;
            *)
              echo "User doesn't have sufficient permission to perform this action."
              exit 1
              ;;
          esac
          
          echo "Access validated for mount path: $VAULT_MOUNT_PATH"

  insert-secret:
    needs: validate-user-permission
    runs-on: ubuntu-latest
    steps:
      - name: Insert Secret into Vault
        run: |
          VAULT_MOUNT_PATH="${{ github.event.inputs.vault_mount_path }}"
          SECRET_KEY="${{ github.event.inputs.secret_key }}"
          SECRET_VALUE="${{ github.event.inputs.secret_value }}"
          
          echo "Inserting secret into Vault..."
          # Connect to Vault and insert the secret
          curl -s \
            --request POST \
            --header "X-Vault-Token: ${{ secrets.VAULT_TOKEN }}" \
            --data "{\"${SECRET_KEY}\": \"${SECRET_VALUE}\"}" \
            "https://vault.example.com/v1${VAULT_MOUNT_PATH}"
          
          echo "Secret inserted successfully!"
