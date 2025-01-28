#!/bin/bash

# List of repositories
REPOS=("repo1" "repo2" "repo3" "repo4") # Add all your repository names here

# Variables to add
ENVIRONMENT="stage"  # Change to "prod" for production
VARIABLES=(
  "API_URL=https://stage.example.com"
  "DB_PASSWORD=stage-db-pass"
)

# Loop through repositories
for REPO in "${REPOS[@]}"; do
  echo "Updating variables for $REPO in $ENVIRONMENT environment..."
  
  for VARIABLE in "${VARIABLES[@]}"; do
    VAR_NAME=$(echo "$VARIABLE" | cut -d= -f1)
    VAR_VALUE=$(echo "$VARIABLE" | cut -d= -f2)
    
    gh variable set "$VAR_NAME" --body "$VAR_VALUE" --repo "your-org/$REPO" --env "$ENVIRONMENT"
    
    if [ $? -eq 0 ]; then
      echo "  - Added $VAR_NAME successfully!"
    else
      echo "  - Failed to add $VAR_NAME!"
    fi
  done
done
