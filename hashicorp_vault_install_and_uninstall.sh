name: Package EPS Batch Job

on:
  workflow_dispatch:
    inputs:
      jobNum:
        description: 'Job number (e.g., PPS.0006)'
        required: true

jobs:
  package-batch:
    runs-on: ubuntu-latest

    env:
      SRC_BASE: ../../executable
      DEST_DIR: eps-batch/dist/EPS_DTSTG_BATCH
      DEPLOY_DIR: eps-batch/deploy

    steps:
      - name: Checkout source
        uses: actions/checkout@v4

      - name: Set up build timestamp
        id: vars
        run: echo "timestamp=$(date +'%Y%m%d.%H%M')" >> "$GITHUB_OUTPUT"

      - name: Create required directories
        run: |
          mkdir -p "$DEST_DIR"
          mkdir -p "$DEPLOY_DIR"

      - name: Copy job files
        run: |
          cp -r "$SRC_BASE/${{ github.event.inputs.jobNum }}" "$DEST_DIR/"

      - name: Create .tar archive
        run: |
          tar -cf "${DEPLOY_DIR}/${{ github.event.inputs.jobNum }}-${{ steps.vars.outputs.timestamp }}.tar" -C "$DEST_DIR" "${{ github.event.inputs.jobNum }}"

      - name: List archive file
        run: ls -lh "$DEPLOY_DIR"
