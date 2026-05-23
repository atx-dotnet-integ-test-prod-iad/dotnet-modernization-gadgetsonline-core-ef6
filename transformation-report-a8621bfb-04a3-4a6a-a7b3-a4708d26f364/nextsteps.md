# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as it did in the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate business logic and integration points:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in modern .NET. Common areas to check include:

- `System.Web` references (not available in modern .NET)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` (replaced by `Program.cs` and middleware pipeline)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) if a deeper API compatibility scan is needed.

### 7. Validate Configuration Files

Ensure that `appsettings.json` contains all configuration values that were previously in `web.config` or `app.config`. Verify connection strings, application settings, and any environment-specific values are correctly migrated.

### 8. Test on Target Platform

If cross-platform support was a goal of this migration, run and test the application on the intended target operating systems (e.g., Linux, macOS) to surface any platform-specific issues.

### 9. Review Static Files and Web Assets

If this is a web application, confirm that static files (CSS, JavaScript, images) are being served correctly and that the `wwwroot` folder is structured appropriately for ASP.NET Core conventions.

### 10. Publish the Application

Once all validation steps pass, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all necessary files are present before deploying to the target environment.