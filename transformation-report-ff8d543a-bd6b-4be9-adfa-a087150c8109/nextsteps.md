# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies that may not surface as hard build errors.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to confirm your chosen version is still within its support window.

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm expected behavior.

### 5. Execute Existing Tests

If the solution contains test projects, run them to verify functional correctness after the migration:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework runtime and the new cross-platform .NET runtime.

### 6. Check for Runtime Compatibility Issues

Some areas that commonly produce runtime issues after migration even when the build succeeds:

- **Configuration**: `System.Configuration.ConfigurationManager` behaves differently. Confirm that `appsettings.json` or equivalent configuration sources are wired up correctly if the project previously relied on `Web.config` or `App.config`.
- **HTTP Modules and Handlers**: If this is a web project, any legacy HTTP modules or handlers from ASP.NET (System.Web) will not function on ASP.NET Core. Verify these have been replaced with middleware equivalents.
- **Entity Framework**: If the project uses Entity Framework, confirm whether it was migrated to EF Core and run any pending migrations:
  ```bash
  dotnet ef database update
  ```
- **Static Files and Routing**: For web projects, verify that static file serving and route configurations are functioning as expected in the ASP.NET Core pipeline.

### 7. Review Removed or Changed APIs

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) to identify any APIs in use that are not supported on the target platform, which may only manifest at runtime.

### 8. Test on Target Platform

If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues.

### 9. Publish the Application

Once validation is complete, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required assets, configuration files, and dependencies are present before deploying to the target environment.