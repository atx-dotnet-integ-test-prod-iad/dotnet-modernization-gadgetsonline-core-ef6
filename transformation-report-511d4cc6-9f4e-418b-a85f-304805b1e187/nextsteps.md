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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest supported LTS release.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to check for any runtime exceptions or unexpected behavior that would not surface at compile time.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and integration points:

```bash
dotnet test --configuration Release
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Removed Windows-Specific APIs

Even without build errors, certain APIs that were available in .NET Framework may have been replaced or removed in cross-platform .NET. Manually review the code for usage of the following, as they can cause runtime failures on non-Windows platforms:

- `System.Web` types (e.g., `HttpContext`, `HttpRequest` from `System.Web`)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain.GetCurrentThreadId()`
- WCF server-side components
- Any P/Invoke calls targeting Windows-specific native libraries

### 7. Review `web.config` or `app.config` Migrations

Configuration in cross-platform .NET is typically handled via `appsettings.json` rather than `web.config` or `app.config`. Confirm that:

- Connection strings have been moved to `appsettings.json`
- Any custom configuration sections have been migrated to the `Microsoft.Extensions.Configuration` model
- The application reads configuration using `IConfiguration` rather than `ConfigurationManager` where applicable

### 8. Verify Database Connectivity

If the application uses a database, confirm the connection strings are correct in the new configuration files and that the application can successfully connect and perform queries at runtime.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, views, and static files are present before deploying to the target environment.