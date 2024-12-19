Here is the contents of the csproj file.

<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net6.0</TargetFramework>
    <DockerComposeProjectPath>..\..\docker-compose.dcproj</DockerComposeProjectPath>

    <RuntimeIdentifiers>win10-x64;win10-x86;centos.7-x64;</RuntimeIdentifiers>
    <SuppressDockerTargets>True</SuppressDockerTargets>

    <GenerateAssemblyConfigurationAttribute>false</GenerateAssemblyConfigurationAttribute>
    <GenerateAssemblyCompanyAttribute>false</GenerateAssemblyCompanyAttribute>
    <GenerateAssemblyProductAttribute>false</GenerateAssemblyProductAttribute>
  </PropertyGroup>

  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|AnyCPU'">
    <DocumentationFile>bin\Debug\net6.0\VPay.DocSys.Parsing.Api.xml</DocumentationFile>
    <NoWarn>1701;1702;1705;1591</NoWarn>
  </PropertyGroup>

  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|AnyCPU'">
    <DocumentationFile>bin\Release\net6.0\VPay.DocSys.Parsing.Api.xml</DocumentationFile>
    <NoWarn>1701;1702;1705;1591;NU1701</NoWarn>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="FluentValidation.AspNetCore" Version="11.2.2" />
    <PackageReference Include="GlobalExceptionHandler" Version="4.0.2" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.Versioning" Version="5.0.0" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.NewtonsoftJson" Version="6.0.13" />
    <PackageReference Include="Microsoft.Extensions.Hosting" Version="7.0.0" />
    <PackageReference Include="Microsoft.Extensions.Configuration" Version="7.0.0" />
    <PackageReference Include="Microsoft.Extensions.Configuration.Abstractions" Version="7.0.0" />
    <PackageReference Include="Microsoft.Extensions.Configuration.Binder" Version="7.0.0" />
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.4.0" />
    <PackageReference Include="VPay.DocSys.HealthChecks" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.AspNetcore" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.FileSystem" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.HttpEndpoint" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.Network" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.Odbc" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.RabbitMQ" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.SqlServer" Version="2.1.9" />
    <PackageReference Include="VPay.DocSys.HealthChecks.StorageManager" Version="2.1.9" />
    <PackageReference Include="VPay.Queuing.DependencyInjection" Version="1.3.1" />
    <PackageReference Include="VPay.Extensions.Logging.GrayLog" Version="0.6.7" />
  </ItemGroup>
  <ItemGroup>
    <ProjectReference Include="..\VPay.DocSys.Parsing\VPay.DocSys.Parsing.csproj" />
  </ItemGroup>
</Project>


Here is the dotnet publish command
dotnet publish ./src/VPay.DocSys.Parsing.Api/VPay.DocSys.Parsing.Api.csproj -c Release -r centos.7-x64 -o ./artifacts
