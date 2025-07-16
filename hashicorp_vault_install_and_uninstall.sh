#!/bin/bash

# Optional: Force login (uncomment if needed)
# az login --tenant <your-tenant-id>

# Variables (edit as needed)
DURATION="PT8H"  # ISO8601 format: PT8H = 8 hours
JUSTIFICATION="Access needed for 8 hours to perform deployment"
GRAPH_API_VERSION="beta"

echo "Fetching your Azure AD user object ID..."
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)
if [[ -z "$USER_OBJECT_ID" ]]; then
  echo "Failed to get signed-in user ID"
  exit 1
fi

echo "Fetching your current subscription ID..."
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
if [[ -z "$SUBSCRIPTION_ID" ]]; then
  echo "Failed to get current subscription ID"
  exit 1
fi

echo "Looking for eligible PIM Contributor roles..."
ELIGIBLE_ROLES=$(az rest --method GET \
  --url "https://graph.microsoft.com/$GRAPH_API_VERSION/roleManagement/directory/roleEligibilityScheduleInstances?\$filter=principalId eq '$USER_OBJECT_ID'" \
  --query "value[?roleDefinition.displayName=='Contributor']" \
  -o json)

if [[ $(echo "$ELIGIBLE_ROLES" | jq length) -eq 0 ]]; then
  echo "No eligible Contributor PIM role found."
  exit 1
fi

# Use the first eligible instance
INSTANCE_ID=$(echo "$ELIGIBLE_ROLES" | jq -r '.[0].id')
ROLE_DEFINITION_ID=$(echo "$ELIGIBLE_ROLES" | jq -r '.[0].roleDefinitionId')

echo "Activating Contributor role via PIM for subscription $SUBSCRIPTION_ID..."

START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

az rest --method POST \
  --url "https://graph.microsoft.com/$GRAPH_API_VERSION/roleManagement/directory/roleScheduleRequests" \
  --headers 'Content-Type=application/json' \
  --body "{
    \"principalId\": \"$USER_OBJECT_ID\",
    \"roleDefinitionId\": \"$ROLE_DEFINITION_ID\",
    \"directoryScopeId\": \"/subscriptions/$SUBSCRIPTION_ID\",
    \"action\": \"selfActivate\",
    \"justification\": \"$JUSTIFICATION\",
    \"scheduleInfo\": {
      \"startDateTime\": \"$START_TIME\",
      \"expiration\": {
        \"type\": \"AfterDuration\",
        \"duration\": \"$DURATION\"
      }
    }
  }"

echo "Request submitted. It may take a moment for activation to be reflected."
