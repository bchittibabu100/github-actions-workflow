name: Scheduled Deployment with Approvals

on:
  workflow_dispatch:
    inputs:
      environment_name:
        description: 'Target Environment (e.g., production, staging)'
        required: true
        type: string
      deployment_date:
        description: 'Deployment Date (YYYY-MM-DD) in CST'
        required: true
        type: string
      deployment_time:
        description: 'Deployment Time (HH:MM 24-hour format) in CST'
        required: true
        type: string

jobs:
  schedule-deployment:
    runs-on: ubuntu-latest
    environment:
      name: ${{ github.event.inputs.environment_name }}
    steps:
      - name: Convert CST Deployment Time to UTC
        id: time_conversion
        run: |
          export DEPLOYMENT_DATETIME="${{ github.event.inputs.deployment_date }}T${{ github.event.inputs.deployment_time }}:00"
          export DEPLOYMENT_TIMESTAMP=$(date -d "$DEPLOYMENT_DATETIME America/Chicago" +"%s")
          export CURRENT_TIMESTAMP=$(date -u +"%s")
          
          WAIT_TIME=$((DEPLOYMENT_TIMESTAMP - CURRENT_TIMESTAMP))

          if [[ "$WAIT_TIME" -le 0 ]]; then
            echo "Scheduled time is in the past! Exiting."
            exit 1
          fi

          echo "Deployment is scheduled at: $(date -d "@$DEPLOYMENT_TIMESTAMP" -u)"
          echo "Waiting for $WAIT_TIME seconds..."
          echo "wait_time=$WAIT_TIME" >> $GITHUB_ENV

      - name: Wait Until Scheduled Time
        run: sleep ${{ env.wait_time }}

      - name: Check for Required Approvals
        run: |
          APPROVALS=$(gh api repos/${{ github.repository }}/environments/${{ github.event.inputs.environment_name }}/approvals | jq '.total_count')
          if [[ "$APPROVALS" -eq 0 ]]; then
            echo "No approvals received within the scheduled window. Canceling deployment."
            exit 1
          fi
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  deploy:
    runs-on: ubuntu-latest
    needs: schedule-deployment
    environment:
      name: ${{ github.event.inputs.environment_name }}
    steps:
      - name: Deploy Application
        run: echo "Deploying to ${{ github.event.inputs.environment_name }}..."
