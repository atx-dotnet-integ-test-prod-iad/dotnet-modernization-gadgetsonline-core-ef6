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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `net8.0` or the appropriate modern TFM rather than a legacy `net48` or `netcoreapp` value.

### 4. Run Unit Tests

If the solution contains test projects, execute them to validate that existing functionality is preserved:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests that may indicate behavioral differences introduced by the migration.

### 5. Check for Removed or Changed APIs

Inspect the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage (not available in cross-platform .NET)
- `HttpContext`, `HttpRequest`, and `HttpResponse` — ensure these reference `Microsoft.AspNetCore.Http` equivalents
- `ConfigurationManager` — should be replaced with `Microsoft.Extensions.Configuration`
- `AppDomain` members that are no longer supported
- Windows-specific APIs such as the registry or WMI, which will not function on non-Windows platforms

### 6. Verify Application Configuration

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Cross-platform .NET does not rely on `web.config` for application configuration at runtime.

### 7. Run the Application Locally

Start the application and exercise its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core features behave as expected. Pay particular attention to:

- Database connectivity and queries
- Authentication and session management
- Static file serving
- Any third-party integrations

### 8. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues that would not appear in a single-OS build.

### 9. Review Warnings from Build Output

Even with zero errors, the build may produce warnings. Review these carefully as they can indicate:

- Nullable reference type mismatches
- Obsolete API usage
- Package version deprecations

Address warnings systematically to improve long-term maintainability.