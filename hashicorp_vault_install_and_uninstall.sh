      - name: Fetch github_user membership
        run: |
          GITHUB_USER="${{ github.actor }}"
          echo "github_user: $GITHUB_USER"
          curl -s -H "Authorization: Bearer ${{ secrets.ACTIONS_PAT_TOKEN }}" "https://api.github.com/users/cboya1_uhg/teams"

action logs:
2024-11-24T01:56:55.0883785Z [36;1mcurl -s -H "Authorization: ***" "https://api.github.com/users/cboya1_uhg/teams"[0m
2024-11-24T01:56:55.0900667Z shell: /usr/bin/bash --noprofile --norc -e -o pipefail {0}
2024-11-24T01:56:55.0901140Z ##[endgroup]
2024-11-24T01:56:55.1035621Z github_user: cboya1_tpc
2024-11-24T01:56:55.2837168Z {
2024-11-24T01:56:55.2837537Z   "message": "Not Found",
2024-11-24T01:56:55.2837998Z   "documentation_url": "https://docs.github.com/rest",
2024-11-24T01:56:55.2838432Z   "status": "404"
2024-11-24T01:56:55.2838792Z }
