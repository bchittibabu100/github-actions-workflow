Dec 18 23:02:22 asstglds03 systemd[1]: Stopped Runs the VPay DocSys Parsing API.
Dec 18 23:02:22 asstglds03 systemd[1]: Started Runs the VPay DocSys Parsing API.
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: Unhandled exception. System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.Extensions.Caching.Abstractions, Version=6.0.0.0, Culture=neutral, PublicKeyToken=adb9793829ddae60'. The system cannot find the file specified.
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: File name: 'Microsoft.Extensions.Caching.Abstractions, Version=6.0.0.0, Culture=neutral, PublicKeyToken=adb9793829ddae60'
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.DependencyInjection.MvcRazorMvcCoreBuilderExtensions.AddRazorViewEngineServices(IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.DependencyInjection.MvcRazorMvcCoreBuilderExtensions.AddRazorViewEngine(IMvcCoreBuilder builder)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.DependencyInjection.MvcServiceCollectionExtensions.AddControllersWithViewsCore(IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.DependencyInjection.MvcServiceCollectionExtensions.AddControllersWithViews(IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.DependencyInjection.MvcServiceCollectionExtensions.AddMvc(IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.DependencyInjection.MvcServiceCollectionExtensions.AddMvc(IServiceCollection services, Action`1 setupAction)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at VPay.DocSys.Parsing.Api.Startup.ConfigureServices(IServiceCollection services) in /home/gitrunner/actions-runner/_work/vpay-parsing/vpay-parsing/src/VPay.DocSys.Parsing.Api/Startup.cs:line 37
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at System.RuntimeMethodHandle.InvokeMethod(Object target, Span`1& arguments, Signature sig, Boolean constructor, Boolean wrapExceptions)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.AspNetCore.Hosting.ConfigureServicesBuilder.InvokeCore(Object instance, IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.AspNetCore.Hosting.ConfigureServicesBuilder.<>c__DisplayClass9_0.<Invoke>g__Startup|0(IServiceCollection serviceCollection)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.AspNetCore.Hosting.ConfigureServicesBuilder.Invoke(Object instance, IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.AspNetCore.Hosting.ConfigureServicesBuilder.<>c__DisplayClass8_0.<Build>b__0(IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.AspNetCore.Hosting.GenericWebHostBuilder.UseStartup(Type startupType, HostBuilderContext context, IServiceCollection services, Object instance)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.AspNetCore.Hosting.GenericWebHostBuilder.<>c__DisplayClass13_0.<UseStartup>b__0(HostBuilderContext context, IServiceCollection services)
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.Hosting.HostBuilder.InitializeServiceProvider()
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at Microsoft.Extensions.Hosting.HostBuilder.Build()
Dec 18 23:02:22 asstglds03 dotnet-vpay-docsys-parsing-api[96888]: at VPay.DocSys.Parsing.Api.Program.Main(String[] args) in /home/gitrunner/actions-runner/_work/vpay-parsing/vpay-parsing/src/VPay.DocSys.Parsing.Api/Program.cs:line 16
Dec 18 23:02:22 asstglds03 systemd[1]: kestrel-vpay-docsys-parsing-api.service: main process exited, code=killed, status=6/ABRT
Dec 18 23:02:22 asstglds03 systemd[1]: Unit kestrel-vpay-docsys-parsing-api.service entered failed state.
Dec 18 23:02:22 asstglds03 systemd[1]: kestrel-vpay-docsys-parsing-api.service failed.
