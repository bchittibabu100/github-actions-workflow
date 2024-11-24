Here is the respone...
{
  "state": "active",
  "role": "member",
  "url": "https://api.github.com/organizations/10351111/team/101111/memberships/cboya1_tvz"
}

here is the 3 different user groups
AZU_OFT_DEVOPS
AZU_OFT_COMMPAY_DEVLEADS
AZU_OFT_COMMPAY_ENGINEERS

Here is the 3 different vault mount paths
/devops
/engineering
/dba
/secrets

go through each one of the group from top to bottom and whichever group the user exit break the loop. in the next workflow step let execute
connect to vault and insert secret. inputs will be received through workflow_dispatch and users enters secret mount path along with vault secret in key and value format
if the group is AZU_OFT_DEVOPS allow user to insert secret into any mount path
if the group is AZU_OFT_COMMPAY_DEVLEADS allow user to insert secret into any mount path other than /devops
if the group is AZU_OFT_COMMPAY_ENGINEERS allow user to insert secret into /engineering and /secrets
else exist with message user doesn't have sufficient permission to perform this action
