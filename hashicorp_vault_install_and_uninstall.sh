PS C:\Users\cboya1> powershell -ExecutionPolicy Bypass -File "C:\Users\cboya1\bamboo_backup.ps1" -Verbose
Unable to find type [System.IO.Compression.ZipFile].
At C:\Users\cboya1\bamboo_backup.ps1:16 char:1
+ [System.IO.Compression.ZipFile]::CreateFromDirectory("$BAMBOO_HOME\em ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (System.IO.Compression.ZipFile:TypeName) [], RuntimeException
    + FullyQualifiedErrorId : TypeNotFound

Unable to find type [System.IO.Compression.ZipArchiveMode].
At C:\Users\cboya1\bamboo_backup.ps1:21 char:64
+ ... File]::Open($ZIP_PATH, [System.IO.Compression.ZipArchiveMode]::Update ...
+                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (System.IO.Compression.ZipArchiveMode:TypeName) [], RuntimeException
    + FullyQualifiedErrorId : TypeNotFound

You cannot call a method on a null-valued expression.
At C:\Users\cboya1\bamboo_backup.ps1:28 char:1
+ $zipArchive.Dispose()
+ ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
    + FullyQualifiedErrorId : InvokeMethodOnNull

Backup created at: C:\Users\cboya1\BambooConfigBackups\bamboo_configs_20250403.zip
Contents:
Exception calling "OpenRead" with "1" argument(s): "Could not find file 'C:\Users\cboya1\BambooConfigBackups\bamboo_configs_20250403.zip'."
At C:\Users\cboya1\bamboo_backup.ps1:33 char:1
+ [System.IO.Compression.ZipFile]::OpenRead($ZIP_PATH).Entries | Select ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException
