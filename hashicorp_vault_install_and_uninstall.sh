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
          GITHUB_USER="${{ github.actor }}"
          echo "Checking group membership for user: $GITHUB_USER"
          
          # Get user teams
          RESPONSE=$(curl -s -H "Authorization: Bearer ${{ secrets.ACTIONS_PAT_TOKEN }}" \
            "https://api.github.com/user/teams")
          
          # Define groups
          groups=("AZU_OFT_DEVOPS" "AZU_OFT_COMMPAY_DEVLEADS" "AZU_OFT_COMMPAY_ENGINEERS")
          mount_paths=("/devops" "/engineering" "/dba" "/secrets")
          user_group=""
          
          for group in "${groups[@]}"; do
            if echo "$RESPONSE" | grep -q "$group"; then
              user_group="$group"
              break
            fi
          done
          
          if [ -z "$user_group" ]; then
            echo "User doesn't have sufficient permission to perform this action."
            exit 1
          fi
          
          echo "User belongs to group: $user_group"
          echo "group=$user_group" >> $GITHUB_ENV

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
