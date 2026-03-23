# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating or replacing packages in the relevant `.csproj` files.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm the build completes with zero errors and review any warnings, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the target framework is set to an appropriate and supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is correct (e.g., `net8.0` rather than a legacy `net48` or similar).

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying particular attention to any areas that relied on Windows-specific APIs or legacy ASP.NET features prior to migration.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences introduced by the migration.

### 6. Check for Removed or Changed APIs

Review the code for usage of any APIs that may have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in .NET Core or later
- Windows Registry access (`Microsoft.Win32.Registry`)
- `HttpContext` and related ASP.NET pipeline APIs that have changed
- Any P/Invoke calls targeting Windows-only native libraries

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility concerns.

### 7. Verify Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values that were previously held in `web.config` or `app.config`. The `System.Configuration.ConfigurationManager` API has limited support in cross-platform .NET, and configuration should be migrated to the `Microsoft.Extensions.Configuration` model where applicable.

### 8. Test on Target Platform

If the intended deployment target is Linux or macOS, run and test the application on that platform explicitly to surface any remaining platform-specific issues that would not appear on Windows.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay attention to file path separators, case-sensitive file systems, and any OS-specific behavior differences.

### 9. Review Publish Output

Perform a publish to verify the output is complete and correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files, static assets, and dependencies are present before deploying to the target environment.