(Get-Content .\AboutInfo.cs).Replace('[[BuildName]]', '${bamboo.buildPlanName}') | Set-Content .\AboutInfo.cs
(Get-Content .\AboutInfo.cs).Replace('[[GitRevision]]', '${bamboo.planRepository.revision}') | Set-Content .\AboutInfo.cs
(Get-Content .\AboutInfo.cs).Replace('[[VersionInfo]]', '${bamboo.buildNumber}') | Set-Content .\AboutInfo.cs
(Get-Content .\AboutInfo.cs).Replace('[[BuildTime]]', '${bamboo.buildTimeStamp}') | Set-Content .\AboutInfo.cs
