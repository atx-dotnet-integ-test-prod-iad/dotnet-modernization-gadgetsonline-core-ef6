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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, certain APIs that existed in .NET Framework may have been replaced or have different behavior in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET and should have been replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should now reference `Microsoft.AspNetCore.Http`.
- Any calls to the Windows registry, Windows-specific file paths, or COM interop, as these will not function on non-Windows platforms.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running application and verify that core functionality such as page rendering, routing, and data access behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that behavior has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests that may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Verify Database Connectivity

If the application uses Entity Framework or another data access layer, confirm that:

- The connection string in `appsettings.json` (or equivalent configuration file) is correct.
- Migrations are up to date by running:

```bash
dotnet ef database update
```

- Data access operations function correctly when the application is running.

### 8. Review Configuration Files

Confirm that `web.config` settings that were relevant to the application have been migrated to `appsettings.json` or `appsettings.{Environment}.json`. The `web.config` file in cross-platform .NET is used only for IIS hosting configuration and should not contain application settings.

### 9. Test on Target Platform

If the intent is to run the application on a non-Windows operating system, perform a test run on that platform to surface any remaining platform-specific dependencies that may not have been caught during the build phase.