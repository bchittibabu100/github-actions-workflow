        - name: Replace Vault Variables in ${{ env.repo_name }}
          if: env.vault_replacements != ''
          run: |
                source ~/tool/k.sh
                IFS=" " read -a files <<< "${{ env.vault_replacements }}"
                for file in ${files[@]}; do
                    ~/tool/vault-helper fill --address ${{ secrets.PRODVAULT_URL }} --token ${{ secrets.PRODVAULT_TOKEN}} --env DEPLOYMENT=${{ env.vault_enviornment }} --output ${{ github.workspace }}/${{ env.repo_name }}/$file ${{ github.workspace }}/${{ env.repo_name }}/$file;
                done
