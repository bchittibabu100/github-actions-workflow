- name: Sonarqube End
  env:
    SONAR_HOST_URL: "https://sonar.testproj.com"
    SONAR_TOKEN: ${{ secrets.sonar_token }}
    GITHUB_TOKEN: ${{ secrets.gh_token }}
  run: |
    set -o pipefail
    dotnet sonarscanner end /d:sonar.login="$SONAR_TOKEN" | tee sonar.out
    RESULT="$?"
    if [ "$RESULT" != "0" ]; then
      echo "Failed to stop sonar scanning!" >> "$GITHUB_STEP_SUMMARY"
      exit "$RESULT"
    fi

    SCAN_URL=$(grep -o -e "$SONAR_HOST_URL\S*" sonar.out | head -n 1 || true)
    rm sonar.out

    if [ -n "$SCAN_URL" ]; then
      echo "Sonar scan results available at <$SCAN_URL>" >> "$GITHUB_STEP_SUMMARY"
    else
      echo "No Sonar scan URL found." >> "$GITHUB_STEP_SUMMARY"
    fi
  shell: bash
