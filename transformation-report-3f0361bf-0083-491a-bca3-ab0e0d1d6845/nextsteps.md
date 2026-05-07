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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and application behavior:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET pipeline APIs
- Windows-specific APIs such as the registry, `System.Drawing` (GDI+), or WCF server-side components
- Configuration APIs (`System.Configuration.ConfigurationManager` requires the `System.Configuration.ConfigurationManager` NuGet package)

### 7. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` (or equivalent configuration file) are correct and that the application can connect to the database successfully at runtime.

### 8. Test on Target Platform

If the goal of the migration is to run on a non-Windows operating system, run the application on the target platform (Linux or macOS) to surface any remaining platform-specific dependencies.