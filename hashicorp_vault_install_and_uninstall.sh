    - name: Sonarqube End
      env:
        SONAR_HOST_URL: "https://sonar.optum.com"
        SONAR_TOKEN: ${{ secrets.sonar_token }}
        GITHUB_TOKEN: ${{ secrets.gh_token }}
      run: |
        set -o pipefail
        dotnet sonarscanner end /d:sonar.login="$SONAR_TOKEN" | tee /dev/fd/2 sonar.out
        RESULT="$?"
        if [ "$RESULT" != "0" ]; then
          echo "Failed to stop sonar scanning!" >> "$GITHUB_STEP_SUMMARY"
          exit "$RESULT"
        fi
        SCAN_URL=$(grep -o -e "$SONAR_HOST_URL\S*" sonar.out | head -n 1)
        rm sonar.out
        echo "Sonar scan results available at <$SCAN_URL>" >> "$GITHUB_STEP_SUMMARY"
      shell: bash

Logs:
-----
18:17:35.751 DEBUG: Post-jobs : 
18:17:35.751 DEBUG: Post-jobs : 
18:17:35.758 INFO: Analysis total time: 1:42.095 s
18:17:35.758 INFO: Analysis total time: 1:42.095 s
18:17:35.760 INFO: ------------------------------------------------------------------------
18:17:35.760 INFO: ------------------------------------------------------------------------
18:17:35.760 INFO: EXECUTION SUCCESS
18:17:35.760 INFO: ------------------------------------------------------------------------
18:17:35.761 INFO: Total time: 1:50.531s
18:17:35.760 INFO: EXECUTION SUCCESS
18:17:35.760 INFO: ------------------------------------------------------------------------
18:17:35.761 INFO: Total time: 1:50.531s
18:17:35.830 INFO: Final Memory: 51M/180M
18:17:35.830 INFO: ------------------------------------------------------------------------
18:17:35.830 INFO: Final Memory: 51M/180M
18:17:35.830 INFO: ------------------------------------------------------------------------
18:17:35.834 DEBUG: Cleanup org.eclipse.jgit.util.FS$FileStoreAttributes$$Lambda$369/0x00007f5d84398a38@79c5460e during JVM shutdown
18:17:35.834 DEBUG: Cleanup org.eclipse.jgit.util.FS$FileStoreAttributes$$Lambda$369/0x00007f5d84398a38@79c5460e during JVM shutdown
Process returned exit code 0
Process returned exit code 0
The SonarScanner CLI has finished
The SonarScanner CLI has finished
18:17:36.193  Post-processing succeeded.
18:17:36.193  Post-processing succeeded.
grep: write error: Broken pipe
Error: Process completed with exit code 2.
