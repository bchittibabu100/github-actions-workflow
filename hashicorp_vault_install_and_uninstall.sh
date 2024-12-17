name: Run Unit Tests

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  run-tests:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Set up .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: '6.0.x' # Replace with your version

      - name: Run Tests
        shell: bash
        run: |
          # Set variables
          path="./"  # Update as per your repo structure
          output_dir="${GITHUB_WORKSPACE}/TestResults"

          # Create TestResults directory
          mkdir -p "$output_dir"

          # Find and run tests
          find "$path" -type f -name "*.Tests.csproj" | while read -r file; do
              filename=$(basename "$file")
              basename_no_ext="${filename%.*}"
              
              echo "Running tests for: $filename"
              
              dotnet test "$file" \
                  --logger "trx;LogFileName=$output_dir/${basename_no_ext}.trx" \
                  --filter "Category!=Integration"
              
              # Handle test failure
              if [ $? -ne 0 ]; then
                  echo "Test failed for $filename" >&2
                  exit 1
              fi
          done

      - name: Publish Test Results
        uses: actions/upload-artifact@v3
        with:
          name: TestResults
          path: TestResults/
