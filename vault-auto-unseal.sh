source_workflow:
################
name: manual-build-deploy
run-name: "${{ github.actor }} is deploying ${{ github.ref_name }} to ${{ inputs.environment }}"
on:
    workflow_dispatch:
        inputs:
            environment:
                description: 'Select Environment From List Below'
                type: choice
                options:
                - Staging
                - Production
                default: Staging
                required: true
jobs:
    call-build-and-deploy:
        uses: test-repo/bamboo_deployment/.github/workflows/manual-deploy.yml@github
        with:
            environment: ${{ inputs.environment }}
        secrets: inherit

target_workflow(uses: test-repo/bamboo_deployment/.github/workflows/manual-deploy.yml@github):
###############
name: manual-build-deploy
run-name: "${{ github.actor }} is deploying ${{ github.ref_name }} to ${{ inputs.environment }}"
on:
    workflow_call:
        inputs:
            environment:
              type: string
              required: true
jobs:
    build-and-deploy:
        runs-on:
            group: test-runner-group
        environment: ${{ inputs.environment }}
        env:
            repo_name: ${{ github.event.repository.name }}
            app_target: ${{ vars.SCRIPT_DEPLOY_TARGET }}
            deploy_script_path: bamboo_deployment
            deploy_script_branch: ${{ vars.DEPLOY_SCRIPT_BRANCH }}
            deploy_env: ${{ vars.SCRIPT_DEPLOY_SERVER }}
            vault_replacements: ${{ vars.VAULT_REPLACEMENTS }}
            vault_enviornment: ${{ vars.VAULT_ENVIORNMENT }}
            variable_replace: ${{ vars.VARIABLE_REPLACE }}
            variable_replace_env: ${{ vars.VARIABLE_REPLACE_ENV}}
            deploy_script_name: ${{ vars.DEPLOY_SCRIPT_NAME }}
            vault_url: ${{ vars.VPAY_PROD_VAULT_URL }}
        steps:
        - run: echo "The job was automatically triggered by a  ${{ github.event_name }} event."
        - run: echo "This job is now running on ${{ runner.name }} running on ${{ runner.os }} OS" 
        - run: echo "The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}"

        - name:  Cleanup build folder
          run: |
            rm -rf ./*
            rm -rf ./.??*
        
        - name:  Checkout application codebase:${{ github.repository }}
          uses: actions/checkout@v3
          with:
            token: ${{ secrets.HPAY_DEVOPS }}
            repository: ${{ github.repository }}
            path: ${{ env.repo_name }}
            ref: ${{ github.ref }}
  
        - name:  Checkout bamboo deploy scripts 
          uses: actions/checkout@v3
          with:
            repository: test-repo/bamboo_deployment
            token: ${{ secrets.HPAY_DEVOPS }}
            path: ${{ env.deploy_script_path }}
            ref: ${{ env.deploy_script_branch }}
  
        - name: List of downloaded application artifact
          run: |
            ls ${{ github.workspace }}/${{ env.repo_name }} -ltr
        - name: List of downloaded deploy artifact
          run: |
            ls ${{ github.workspace }}/${{ env.deploy_script_path }} -ltr
  
        - name: Search and Convert Windows line endings into Unix line ending ???
          run: |
            find ${{ github.workspace }}/${{ env.repo_name }} -type f ! -name "*.jpg" ! -name "*.png" ! -name "*.gif" ! -name "*.ttf" ! -name "*.zip" ! -name "*tar" ! -name "*tgz" ! -name "*docx" ! -name "*pdf" |xargs -I '{}' sed -i 's/\r$//' '{}'

        - name: Replace variables in ${{ env.repo_name }}
          if: env.variable_replace != ''
          run: |
                source ~/tool/k.sh
                IFS=" " read -a replacements <<< "${{ env.variable_replace }}"
                for pair in ${replacements[@]}; do
                    IFS=, read file app <<< "${pair}";
                    bash ${{ github.workspace }}/${{ env.deploy_script_path }}/variable_replace.sh ${{ github.workspace }}/${{ env.repo_name }}/$file ${{ env.variable_replace_env }} $app;
                done

        - name: Replace Vault Variables in ${{ env.repo_name }}
          if: env.vault_replacements != ''
          run: |
                source ~/tool/k.sh
                IFS=" " read -a files <<< "${{ env.vault_replacements }}"
                for file in ${files[@]}; do
                    ~/tool/vault-helper fill --address ${{ env.vault_url }} --token ${{ secrets.PRODVAULT_TOKEN}} --env DEPLOYMENT=${{ env.vault_enviornment }} --output ${{ github.workspace }}/${{ env.repo_name }}/$file ${{ github.workspace }}/${{ env.repo_name }}/$file;
                done
            
        - name: Deploy To Env= ${{env.deploy_env}} for ${{ env.repo_name }}
          run: |
             echo "Start deployment process to ${{ env.deploy_env }} by ${{ runner.name }} "
             echo "Runner workspace: $(pwd)"
             echo ${{ env.repo_name }} is to deploy to: ${{ env.deploy_env }}
             echo "Executed by: $( whoami )"
             echo Executing deploy.sh
             bash ${{ github.workspace }}/${{ env.deploy_script_path }}/${{ env.deploy_script_name }} ${{ env.repo_name }} ${{ env.app_target }} ${{ env.deploy_env }}
  
        - run: echo "This job's status is ${{ job.status }}."
