$files = Get-ChildItem -Path $path -Recurse -Filter "*.Tests.csproj" | select Name, DirectoryName, BaseName, FullName

ForEach ($file in $files)
{
  Write-Host $file.Name
  dotnet test  $file.FullName  --logger "trx;LogFileName=${bamboo.build.working.directory}\TestResults\$($file.Name).trx" --filter "Category!=Integration"

  # return failure code
  if ($LastExitCode -ne 0) {
      $error | Write-Error $_
      exit $LastExitCode
  }
}
