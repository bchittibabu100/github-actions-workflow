2025-02-14T21:13:30.0265091Z Current runner version: '2.322.0'
2025-02-14T21:13:30.0274356Z Runner name: 'u-runner-jvfw2-runner-x8gnc'
2025-02-14T21:13:30.0275229Z Runner group name: 'prod-elr2-uhg'
2025-02-14T21:13:30.0276224Z Machine name: 'u-runner-jvfw2-runner-x8gnc'
2025-02-14T21:13:30.0281652Z ##[group]GITHUB_TOKEN Permissions
2025-02-14T21:13:30.0284222Z Actions: write
2025-02-14T21:13:30.0284930Z Attestations: write
2025-02-14T21:13:30.0285568Z Checks: write
2025-02-14T21:13:30.0286105Z Contents: write
2025-02-14T21:13:30.0286612Z Deployments: write
2025-02-14T21:13:30.0287338Z Discussions: write
2025-02-14T21:13:30.0287930Z Issues: write
2025-02-14T21:13:30.0288619Z Metadata: read
2025-02-14T21:13:30.0289203Z Packages: write
2025-02-14T21:13:30.0289710Z Pages: write
2025-02-14T21:13:30.0290182Z PullRequests: write
2025-02-14T21:13:30.0290816Z RepositoryProjects: write
2025-02-14T21:13:30.0291325Z SecurityEvents: write
2025-02-14T21:13:30.0291839Z Statuses: write
2025-02-14T21:13:30.0292617Z ##[endgroup]
2025-02-14T21:13:30.0295095Z Secret source: Actions
2025-02-14T21:13:30.0295807Z Prepare workflow directory
2025-02-14T21:13:30.0728861Z Prepare all required actions
2025-02-14T21:13:30.0819037Z Complete job name: schedule-deployment
2025-02-14T21:13:30.1557340Z ##[group]Run export DEPLOYMENT_DATETIME="2025-02-14T15:20:00:00"
2025-02-14T21:13:30.1558633Z [36;1mexport DEPLOYMENT_DATETIME="2025-02-14T15:20:00:00"[0m
2025-02-14T21:13:30.1559591Z [36;1mexport DEPLOYMENT_TIMESTAMP=$(date -d "$DEPLOYMENT_DATETIME America/Chicago" +"%s")[0m
2025-02-14T21:13:30.1560483Z [36;1mexport CURRENT_TIMESTAMP=$(date -u +"%s")[0m
2025-02-14T21:13:30.1561178Z [36;1m[0m
2025-02-14T21:13:30.1561775Z [36;1mWAIT_TIME=$((DEPLOYMENT_TIMESTAMP - CURRENT_TIMESTAMP))[0m
2025-02-14T21:13:30.1562571Z [36;1m[0m
2025-02-14T21:13:30.1563095Z [36;1mif [[ "$WAIT_TIME" -le 0 ]]; then[0m
2025-02-14T21:13:30.1563741Z [36;1m  echo "Scheduled time is in the past! Exiting."[0m
2025-02-14T21:13:30.1564629Z [36;1m  exit 1[0m
2025-02-14T21:13:30.1565147Z [36;1mfi[0m
2025-02-14T21:13:30.1565606Z [36;1m[0m
2025-02-14T21:13:30.1566315Z [36;1mecho "Deployment is scheduled at: $(date -d "@$DEPLOYMENT_TIMESTAMP" -u)"[0m
2025-02-14T21:13:30.1567211Z [36;1mecho "Waiting for $WAIT_TIME seconds..."[0m
2025-02-14T21:13:30.1567905Z [36;1mecho "wait_time=$WAIT_TIME" >> $GITHUB_ENV[0m
2025-02-14T21:13:30.1597828Z shell: /usr/bin/bash -e {0}
2025-02-14T21:13:30.1599031Z ##[endgroup]
2025-02-14T21:13:30.2062936Z date: invalid date ‘2025-02-14T15:20:00:00 America/Chicago’
2025-02-14T21:13:30.2063806Z Scheduled time is in the past! Exiting.
2025-02-14T21:13:30.2102514Z ##[error]Process completed with exit code 1.
2025-02-14T21:13:30.2290593Z Cleaning up orphan processes
