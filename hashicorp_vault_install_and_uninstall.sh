$BAMBOO_HOME = "C:\Atlassian\Application Data\Bamboo"
   $BACKUP_DIR = "C:\BambooConfigBackups"
   $DATE = Get-Date -Format "yyyyMMdd"
   $ZIP_PATH = "$BACKUP_DIR\bamboo_configs_$DATE.zip"

   # Create backup dir if missing
   if (!(Test-Path $BACKUP_DIR)) { New-Item -ItemType Directory -Path $BACKUP_DIR -Force }

   # Backup only plan/job configs (build.xml files)
   Compress-Archive -Path `
     "$BAMBOO_HOME\xml-data\builds\*\build.xml", `
     "$BAMBOO_HOME\xml-data\builds\*\*\build.xml" `
     -DestinationPath $ZIP_PATH -Force

   # Verify
   Write-Host "Backup created at: $ZIP_PATH"
   Get-ChildItem $ZIP_PATH

   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

   
