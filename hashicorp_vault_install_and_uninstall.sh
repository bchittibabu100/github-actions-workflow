
#!/bin/bash

path="./"  # Adjust this to your base directory if needed

find "$path" -type f -name "*.Tests.csproj" | while read -r file; do
    name=$(basename "$file")
    echo "$name"
    dotnet test "$file" \
        --no-restore \
        --logger "trx;LogFileName=${bamboo_build_working_directory}/TestResults/${name}.trx" \
        --filter "Category!=Integration"
done
