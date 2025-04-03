# Configurations
$BAMBOO_HOME = "C:\Atlassian\Application Data\Bamboo"
$BACKUP_DIR = "C:\BambooConfigBackups"
$DATE = Get-Date -Format "yyyyMMdd"
$ZIP_PATH = "$BACKUP_DIR\bamboo_configs_$DATE.zip"

# Create backup directory if it doesn't exist
if (-not (Test-Path -Path $BACKUP_DIR)) {
    New-Item -ItemType Directory -Path $BACKUP_DIR -Force | Out-Null
}

# Find all plan/job config files (build.xml)
$ConfigFiles = Get-ChildItem -Path "$BAMBOO_HOME\xml-data\builds" -Recurse -Filter "build.xml"

# Create a new ZIP file (empty)
[System.IO.Compression.ZipFile]::CreateFromDirectory("$BAMBOO_HOME\empty_temp_dir", $ZIP_PATH)  # Workaround to create empty ZIP
Remove-Item "$BAMBOO_HOME\empty_temp_dir" -Recurse -Force -ErrorAction SilentlyContinue

# Add files to ZIP using .NET (works on PS 4.0+)
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zipArchive = [System.IO.Compression.ZipFile]::Open($ZIP_PATH, [System.IO.Compression.ZipArchiveMode]::Update)

foreach ($file in $ConfigFiles) {
    $entryName = $file.FullName.Substring($BAMBOO_HOME.Length + 1)
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zipArchive, $file.FullName, $entryName) | Out-Null
}

$zipArchive.Dispose()

# Verify backup
Write-Host "Backup created at: $ZIP_PATH"
Write-Host "Contents:"
[System.IO.Compression.ZipFile]::OpenRead($ZIP_PATH).Entries | Select-Object Name
