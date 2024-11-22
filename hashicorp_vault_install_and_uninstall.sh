name: Insert Secret into Vault

on:
  workflow_call:
    inputs:
      secret_key:
        description: 'Secret key'
        required: true
        type: string
      secret_value:
        description: 'Secret value'
        required: true
        type: string
      secret_path:
        description: 'Full Vault path (e.g., DBA/<env>/<app-name>/secretname/ or engineering/<env>/<app-name>/secretname/)'
        required: true
        type: string

jobs:
  insert_secret:
    runs-on: 
      group: test-runner-group

    steps:
      - name: Set Vault Environment Variables
        run: |
          echo "VAULT_ADDR=${{ vars.VPAY_VAULT_VM_URL }}" >> $GITHUB_ENV
          echo "VAULT_TOKEN=${{ secrets.VPAY_VAULT_VM_TOKEN }}" >> $GITHUB_ENV

      - name: Validate Vault path and check permissions
        id: validate_path
        run: |
          SECRET_PATH="${{ inputs.secret_path }}"
          SECRET_KEY="${{ inputs.secret_key }}"
          SECRET_VALUE="${{ inputs.secret_value }}"
          GITHUB_USER="${{ github.actor }}"
          MOUNT_PATH=$(echo "$SECRET_PATH" | cut -d'/' -f1)

          # Define valid Vault mounts
          VALID_MOUNTS=("devops" "DBA" "engineering" "secret" "roletest")
          if ! printf '%s\n' "${VALID_MOUNTS[@]}" | grep -qx "$MOUNT_PATH"; then
              echo "Invalid Vault mount path. Allowed mounts are: ${VALID_MOUNTS[*]}"
              exit 1
          fi
          echo "Vault mount path $MOUNT_PATH is valid."

          # Fetch user's teams
          TEAMS=$(curl -s -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
                  "https://api.github.com/users/$GITHUB_USER/teams" | jq -r '.[].slug') || {
              echo "Failed to fetch user teams or parse JSON response."
              exit 1
          }
          echo "Teams for user $GITHUB_USER: $TEAMS"

          # Determine allowed paths based on team membership
          if echo "$TEAMS" | grep -qw "AZU_OFT_COMMPAY_DEVOPS"; then
              ALLOWED_PATHS=("devops" "DBA" "engineering" "secret" "roletest")
          elif echo "$TEAMS" | grep -qw "AZU_OFT_COMMPAY_DEVLEADS"; then
              ALLOWED_PATHS=("DBA")
          elif echo "$TEAMS" | grep -qw "AZU_OFT_COMMPAY_ENGINEERING"; then
              ALLOWED_PATHS=("engineering" "secret")
          else
              echo "User $GITHUB_USER is not in a recognized team. Access denied."
              exit 1
          fi

          # Check if the user is authorized for the specified path
          if ! printf '%s\n' "${ALLOWED_PATHS[@]}" | grep -qx "$MOUNT_PATH"; then
              echo "User $GITHUB_USER is not allowed to write to mount path: $MOUNT_PATH"
              exit 1
          fi
          echo "User $GITHUB_USER is authorized to write to the path: $MOUNT_PATH"

      - name: Insert Secret into Vault
        if: success()
        run: |
          VAULT_ADDR=${{ vars.VPAY_VAULT_VM_URL }}
          VAULT_TOKEN=${{ secrets.VPAY_VAULT_VM_TOKEN }}
          SECRET_PATH="${{ inputs.secret_path }}"
          SECRET_KEY="${{ inputs.secret_key }}"
          SECRET_VALUE="${{ inputs.secret_value }}"
          
          # Construct full path for Vault
          FULL_PATH="${VAULT_ADDR}/v1/${SECRET_PATH}"
          
          # Insert the secret into Vault
          curl --fail --header "X-Vault-Token: $VAULT_TOKEN" \
               --request POST \
               --data '{"data": {"'"$SECRET_KEY"'": "'"$SECRET_VALUE"'"}}' \
               "$FULL_PATH" || {
              echo "Failed to insert/update the secret in Vault."
              exit 1
          }
          echo "Secret inserted/updated successfully."
