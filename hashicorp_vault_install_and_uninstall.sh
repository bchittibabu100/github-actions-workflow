Dec 19 16:30:28 asstglds03 systemd[1]: Stopped Outbound Redcard Data Driver Queue Consumer 3.Dec 19 16:30:28 asstglds03 systemd[1]: Started Outbound Redcard Data Driver Queue Consumer 3.Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: Unhandled exception. System.ArgumentNullException: Value cannot be null. (Parameter 'Dsn')Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at System.Data.Common.ADP.CheckArgumentNull(Object value, String parameterName)Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at System.Data.Odbc.OdbcConnectionStringBuilder.SetValue(String keyword, String value)Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at System.Data.Odbc.OdbcConnectionStringBuilder.set_Dsn(String value)Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at VPay.Data.Db2.Odbc.Helpers.OdbcHelpers.GetConnectionString(OdbcConnectionConfig connectionConfig)Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at VPay.DocSys.Parsing.DependencyInjectionHelper.ConfigureDataConnections(IServiceCollection services, IConfiguration configuration) in /home/gitrunner/actions-runner/_work/vpay-parsing/vpay-parsing/src/VPay.DocSys.Parsing/DependencyInjectionHelper.cs:line 137Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor.Startup.AddServices(IServiceCollection services, IConfiguration configuration) in /home/gitrunner/actions-runner/_work/vpay-parsing/vpay-parsing/src/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor/Startup.cs:line 49Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor.Program.<>c.<CreateHostBuilder>b__5_2(HostBuilderContext hostBuilderContext, IServiceCollection serviceCollection) in /home/gitrunner/actions-runner/_work/vpay-parsing/vpay-parsing/src/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor/Program.cs:line 32Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at Microsoft.Extensions.Hosting.HostBuilder.InitializeServiceProvider()Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at Microsoft.Extensions.Hosting.HostBuilder.Build()Dec 19 16:30:29 asstglds03 outbound-redcard-data-driver-queue[47335]: at VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor.Program.Main(String[] args) in /home/gitrunner/actions-runner/_work/vpay-parsing/vpay-parsing/src/VPay.DocSys.Parsing.OutboundRedCardDataQueueProcessor/Program.cs:line 14Dec 19 16:30:29 asstglds03 systemd[1]: outbound-redcard-data-driver-queue@3.service: main process exited, code=killed, status=6/ABRTDec 19 16:30:29 asstglds03 systemd[1]: Unit outbound-redcard-data-driver-queue@3.service entered failed state.Dec 19 16:30:29 asstglds03 systemd[1]: outbound-redcard-data-driver-queue@3.service failed.Dec 19 16:30:39 asstglds03 systemd[1]: outbound-redcard-data-driver-queue@3.service holdoff time over, scheduling restart.Dec 19 16:30:39 asstglds03 systemd[1]: Stopped Outbound Redcard Data Driver Queue Consumer 3.Dec 19 16:30:39 asstglds03 systemd[1]: Started Outbound Redcard Data Driver Queue Consumer 3.Dec 19 16:30:39 asstglds03 systemd[1]: outbound-redcard-data-driver-queue@3.service: main process exited, code=killed, status=6/ABRTDec 19 16:30:39 asstglds03 systemd[1]: Unit outbound-redcard-data-driver-queue@3.service entered failed state.Dec 19 16:30:39 asstglds03 systemd[1]: outbound-redcard-data-driver-queue@3.service failed.
#!/bin/bash

# Define the folders
folder1="path/to/folder1"
folder2="path/to/folder2"

# Verify that the folders exist
if [[ ! -d "$folder1" || ! -d "$folder2" ]]; then
  echo "Error: One or both folders do not exist."
  exit 1
fi

# Loop through all files in folder1
for file1 in "$folder1"/*; do
  filename=$(basename "$file1")
  file2="$folder2/$filename"
  
  # Check if the corresponding file exists in folder2
  if [[ -f "$file2" ]]; then
    # Calculate checksums
    checksum1=$(sha256sum "$file1" | awk '{print $1}')
    checksum2=$(sha256sum "$file2" | awk '{print $1}')
    
    # Compare checksums
    if [[ "$checksum1" == "$checksum2" ]]; then
      echo "MATCH: $filename"
    else
      echo "DIFFERENT: $filename"
    fi
  else
    echo "MISSING in folder2: $filename"
  fi
done

# Check for files in folder2 that are not in folder1
for file2 in "$folder2"/*; do
  filename=$(basename "$file2")
  file1="$folder1/$filename"
  
  if [[ ! -f "$file1" ]]; then
    echo "MISSING in folder1: $filename"
  fi
done
