	$files = Get-ChildItem -Path $path -Recurse -Filter "*.Tests.csproj" | select Name, DirectoryName, BaseName, FullName
    ForEach ($file in $files)
    {
    Write-Host $file.Name
    dotnet test  $file.FullName --no-restore --logger "trx;LogFileName=${bamboo.build.working.directory}\TestResults\$($file.Name).trx" --filter "Category!=Integration"
    }

give me equivalent bash script
