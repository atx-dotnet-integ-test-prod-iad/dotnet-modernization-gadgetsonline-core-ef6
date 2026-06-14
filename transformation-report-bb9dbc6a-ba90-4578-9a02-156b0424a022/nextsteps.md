# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate compatibility concerns with the target framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by API differences between .NET Framework and modern .NET.

### 5. Check for Removed or Changed APIs

Even without build errors, certain APIs behave differently or have been removed in modern .NET. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` compatibility tooling to scan for runtime-level issues:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 6. Test Application Functionality Manually

Start the application locally and exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and migrations (if using Entity Framework)
- Authentication and session handling
- Any file system paths that may have been hardcoded for Windows

### 7. Review `web.config` / `app.config` Usage

Modern .NET does not use `web.config` for application configuration in the same way as .NET Framework. Confirm that configuration has been migrated to `appsettings.json` and that `IConfiguration` is used throughout the application where `ConfigurationManager` was previously used.

### 8. Verify Static Files and Middleware (If ASP.NET)

If this is a web project, confirm that middleware previously handled by IIS (e.g., static file serving, error pages, authentication modules) has been replaced with the equivalent ASP.NET Core middleware in `Program.cs` or `Startup.cs`.

### 9. Deployment

Once the above steps are completed and the application behaves as expected:

1. Publish the application using:
   ```bash
   dotnet publish --configuration Release --output ./publish
   ```
2. Verify the contents of the `./publish` directory contain all expected assemblies and static assets.
3. Deploy the published output to the target hosting environment (IIS with the ASP.NET Core Module, a Linux server, or Azure App Service).
4. For IIS hosting, ensure the **ASP.NET Core Hosting Bundle** is installed on the server, as it replaces the classic ASP.NET runtime.