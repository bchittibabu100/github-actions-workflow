param (
    [Parameter(Mandatory=$false)][string]$sys,
	[Parameter(Mandatory=$true)][string]$envName,
	[Parameter(Mandatory=$true)][string]$orig,
	[Parameter(Mandatory=$true)][string]$dest
)

trap
{
    write-output $_
    exit 1
}

if (!(Test-Path $orig -PathType Leaf)) {
    Write-Warning "$orig file is missing"    
} else {
    if ([string]::IsNullOrWhiteSpace($sys)) {
        $sys = '*';
    }
    $replaceString = '_' + $envName + '_'
    $searchString = 'bamboo_vpay_' + $sys + '_' + $envName + '_*'

    $lookupTable = @{}
    Get-ChildItem env:* | sort-object name | Where-Object {$_.Name -like $searchString} | ForEach-Object {
        $name = $_.Name;
        $key = $_.Name -replace 'bamboo_vpay_', ''
        $key = $key -replace $replaceString, ''
        $key = $key -replace '_', ''
        $key = "{{" + $key + "}}"
        Write-Output "$name = $key";
		if(-NOT $lookupTable.ContainsKey($key)) {
			$lookupTable.Add($key, $_.Value)
		}
    }


    Get-Content -Path $orig | ForEach-Object {
        $line = $_
    
        $lookupTable.GetEnumerator() | ForEach-Object {
            if ($line -match $_.Key)
            {
                $line = $line -replace $_.Key, $_.Value
            }
        }
       $line
    } | Set-Content -Path $dest
}
