# Configs
$BAMBOO_HOME = "C:\Atlassian\Application Data\Bamboo"
$BACKUP_DIR = "C:\BambooConfigBackups"
$DATE = Get-Date -Format "yyyyMMdd"
$ZIP_PATH = "$BACKUP_DIR\bamboo_configs_$DATE.zip"

# Create backup dir if missing
if (!(Test-Path $BACKUP_DIR)) {
    New-Item -ItemType Directory -Path $BACKUP_DIR -Force | Out-Null
}

# Find all plan/job configs (build.xml files)
$ConfigFiles = Get-ChildItem -Path "$BAMBOO_HOME\xml-data\builds" -Recurse -Filter "build.xml"

# Compress files into ZIP (using COM object for compatibility)
$Shell = New-Object -ComObject "Shell.Application"
$ZipFile = $Shell.NameSpace($ZIP_PATH)
foreach ($file in $ConfigFiles) {
    $ZipFile.CopyHere($file.FullName)
    Start-Sleep -Milliseconds 500  # Prevents race condition
}

# Verify backup
Write-Host "Backup created at: $ZIP_PATH"
Write-Host "Contents:"
$Shell.NameSpace($ZIP_PATH).Items() | Select-Object Name
