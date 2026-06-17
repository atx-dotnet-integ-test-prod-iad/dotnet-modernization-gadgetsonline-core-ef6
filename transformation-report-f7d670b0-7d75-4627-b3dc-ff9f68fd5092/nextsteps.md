# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm that behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage (not available in .NET Core/.NET 5+)
- `HttpContext` and related types (replaced by ASP.NET Core equivalents)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or WCF server-side components

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tool to identify any remaining compatibility issues.

### 7. Verify Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Ensure connection strings, application settings, and environment-specific values are correctly represented in the new configuration system.

### 8. Test Data Access Layer

If the project uses Entity Framework or another ORM, verify that:

- Migrations run successfully: `dotnet ef database update`
- Queries return expected results against the target database
- Connection strings point to the correct database instance

### 9. Validate Static Assets and Views

If this is a web project, manually verify that:

- All pages render without errors
- Static files (CSS, JavaScript, images) are served correctly
- Routing behaves as expected

### 10. Review Deployment Target

Confirm the target runtime and deployment model in the project file. For a self-contained deployment:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained true
```

Adjust the `--runtime` identifier to match your target environment (e.g., `linux-x64`, `osx-x64`).