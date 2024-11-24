This is the API being executed.
TEAM_SLUG=("AZU_OFT_DEVOPS" "AZU_OFT_COMMPAY_DEVLEADS" "AZU_OFT_COMMPAY_ENGINEERS")
ORG_NAME="phi-test"

API=https://api.github.com/orgs/$ORG_NAME/teams/$TEAM_SLUG/memberships/$GITHUB_USER"

wanted to execute API for each team_slug in the same order if the user is active end the loop else continue with remaining groups
