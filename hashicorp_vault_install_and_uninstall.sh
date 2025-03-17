name: Pull and upload images
on: [push, workflow_dispatch]

jobs:
  pull-and-upload: 
    runs-on: thg-runner
      
    steps: 
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Login to Docker Container Registery
        uses: docker/login-action@v3
        with:
          registry: "docker.repo1.vhc.com"
          username: ${{ vars.PMNTS_DEVOPS_MSA }}
          password: ${{ secrets.PMNTS_DEVOPS_MSA_PWD }}
        
      - name: Build and Push Docker Image
        run: |
          docker pull docker.repo1.vhc.com/redis:7.4.2
          docker tag redis:7.4.2 docker.repo1.vhc.com/vay-docker/base-images/redis:7.4.2
          docker push docker.repo1.vhc.com/vay-docker/base-images/redis:7.4.2
        shell: bash
        

error logs:
Run docker pull docker.repo1.vhc.com/redis:7.4.2
7.4.2: Pulling from redis
pull access denied for docker.repo1.vhc.com/redis, repository does not exist or may require 'docker login': denied: Artifact download request rejected: library/redis/sha256__7f346df9cd82ade39512e2040acf3583e6af260b98c01fe525020bf89fb82783/manifest.json was not downloaded due to the download blocking policy configured in Xray for docker-hub-cache.
Error: Process completed with exit code 1.
