# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a Windows-specific TFM unless Windows-only APIs are required).

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm behavior matches the legacy version.

### 5. Run Existing Tests

If a test project exists within the solution, execute the test suite:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in cross-platform .NET)
- `HttpContext` and related ASP.NET types (replaced by ASP.NET Core equivalents)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` usage
- Binary serialization (`BinaryFormatter`, which is obsolete and disabled by default)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling if a thorough API compatibility check is needed.

### 7. Verify Configuration Files

Confirm that any configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or equivalent ASP.NET Core configuration sources. Check that connection strings, application settings, and environment-specific values are all present and correct.

### 8. Test Data Access

If the project uses a database, verify that:

- Connection strings are correctly configured for the new environment.
- Migrations (if using Entity Framework Core) are up to date by running:

```bash
dotnet ef database update
```

- Data reads and writes function correctly through manual or automated testing.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to the target environment.