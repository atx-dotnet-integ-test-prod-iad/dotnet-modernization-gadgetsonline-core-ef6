# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime environment where the application will be deployed.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to confirm that functionality has been preserved after the transformation.

### 5. Check for Removed or Changed APIs

Review any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry or certain I/O APIs
- Any third-party libraries that may have been targeting .NET Framework exclusively

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool to surface any remaining compatibility concerns.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests carefully, as failures may indicate behavioral differences between .NET Framework and cross-platform .NET rather than bugs in the tests themselves.

### 7. Verify Static Assets and Configuration

For web projects, confirm the following:

- `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`
- Static files, views, and other content files are present and correctly referenced
- Any connection strings or environment-specific settings have been migrated appropriately

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm whether it has been migrated to Entity Framework Core. Verify that:

- Database migrations are intact and functional
- Connection strings are correctly configured
- Any raw SQL queries or stored procedure calls behave as expected

Run a quick end-to-end test against a local or staging database to confirm data access is working correctly.