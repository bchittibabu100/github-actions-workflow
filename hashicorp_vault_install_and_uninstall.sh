export DEPLOYMENT_DATETIME="${{ github.event.inputs.deployment_date }} ${{ github.event.inputs.deployment_time }}"
export DEPLOYMENT_TIMESTAMP=$(TZ="America/Chicago" date -d "$DEPLOYMENT_DATETIME" +"%s")
export CURRENT_TIMESTAMP=$(date -u +"%s")

WAIT_TIME=$((DEPLOYMENT_TIMESTAMP - CURRENT_TIMESTAMP))

if [[ "$WAIT_TIME" -le 0 ]]; then
  echo "Scheduled time is in the past! Exiting."
  exit 1
fi

echo "Deployment is scheduled at: $(date -d "@$DEPLOYMENT_TIMESTAMP" -u)"
echo "Waiting for $WAIT_TIME seconds..."
echo "wait_time=$WAIT_TIME" >> $GITHUB_ENV
