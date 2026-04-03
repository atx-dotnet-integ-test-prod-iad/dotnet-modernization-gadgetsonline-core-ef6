# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an actively supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version (e.g., `netcoreapp3.1` or `net5.0`), update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Check for Removed or Changed APIs

Use the .NET Upgrade Assistant compatibility analyzer or review the official [.NET breaking changes documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/) to identify any APIs that were available in the legacy .NET Framework but have been removed or altered in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific APIs that may not function on Linux or macOS
- Any use of `HttpContext`, `HttpRequest`, or `HttpResponse` from the legacy `System.Web` namespace, which should be replaced with their `Microsoft.AspNetCore.Http` equivalents

### 6. Verify Application Configuration

Check that configuration files have been properly migrated:

- `Web.config` or `App.config` settings should be moved to `appsettings.json`
- Connection strings should be present in `appsettings.json` or managed via environment variables
- Confirm that `Program.cs` and `Startup.cs` (if applicable) are correctly configured for the ASP.NET Core pipeline

### 7. Run the Application Locally

Start the application using the .NET CLI and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key features and confirm that core functionality, such as data access, routing, and any e-commerce workflows, operates as expected.

### 8. Review Static Files and Bundling

If the project previously used `System.Web.Optimization` for bundling and minification, confirm that an equivalent mechanism such as `WebOptimizer` or manual bundling has been configured, as the original library is not compatible with cross-platform .NET.

### 9. Validate Database Connectivity

If the application uses Entity Framework or ADO.NET, confirm that:

- The correct provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`)
- Migrations are up to date by running:

```bash
dotnet ef database update
```

- The connection string in `appsettings.json` points to the correct database instance

### 10. Test on Target Platform

If the intent is to run the application on a non-Windows platform, perform a test run on that platform (Linux or macOS) to surface any remaining platform-specific issues that would not appear during Windows development.