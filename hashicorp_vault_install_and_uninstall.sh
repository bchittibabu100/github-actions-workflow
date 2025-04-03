# Configs
$BAMBOO_HOME = "C:\Atlassian\Application Data\Bamboo"
$BACKUP_DIR = "C:\BambooConfigBackups"
$DATE = Get-Date -Format "yyyyMMdd"
$ZIP_PATH = "$BACKUP_DIR\bamboo_configs_$DATE.zip"

# Create backup dir if missing
New-Item -ItemType Directory -Path $BACKUP_DIR -Force | Out-Null

# Compress ONLY plan/job configs (exclude builds/logs/artifacts)
Compress-Archive -Path `
  "$BAMBOO_HOME\xml-data\builds\*\build.xml", `
  "$BAMBOO_HOME\xml-data\builds\*\*\build.xml" `
  -DestinationPath $ZIP_PATH -CompressionLevel Optimal

# Verify
Write-Host "Backup created at: $ZIP_PATH"
Write-Host "Contents:"
(Get-ZipArchive -Path $ZIP_PATH).Entries | Select-Object Name
