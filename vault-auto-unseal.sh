- name: Replace Vault Variables in ${{ env.repo_name }}
  if: env.vault_replacements != ''
  run: |
    source ~/tool/k.sh
    IFS=" " read -a files <<< "${{ env.vault_replacements }}"
    if [[ ${#files[@]} -eq 0 ]]; then
      echo "Warning: No files provided in vault_replacements. Skipping this step."
    else
      for file in ${files[@]}; do
        if [[ -f "${{ github.workspace }}/${{ env.repo_name }}/$file" ]]; then
          ~/tool/vault-helper fill \
              --address ${{ secrets.PRODVAULT_URL }} \
              --token ${{ secrets.PRODVAULT_TOKEN }} \
              --env DEPLOYMENT=${{ env.vault_environment }} \
              --output ${{ github.workspace }}/${{ env.repo_name }}/$file \
              ${{ github.workspace }}/${{ env.repo_name }}/$file
        else
          echo "Warning: File $file does not exist. Skipping..."
        fi
      done
    fi
