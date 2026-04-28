# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings about missing or incompatible packages. Pay attention to any packages that may have been replaced with newer equivalents during the transformation, as behavioral differences can exist between legacy and modern versions.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Confirm that the output shows zero errors and review any warnings, as some warnings in .NET may indicate deprecated APIs or patterns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`).

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is not what you intended, update it accordingly and re-run the restore and build steps.

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality, particularly any areas that relied on Windows-specific APIs in the legacy project, such as:

- Authentication and session management
- Database connectivity
- File I/O operations
- Any HTTP handlers or modules that were migrated to middleware

### 5. Check for Removed or Changed APIs

Legacy ASP.NET projects often use APIs that do not exist in cross-platform .NET. Manually review the following areas if they exist in the project:

- **`HttpContext`** usage — ensure access is done via dependency injection rather than `HttpContext.Current`
- **`System.Web` references** — these are not available in cross-platform .NET and should have been replaced
- **`ConfigurationManager`** — this should be replaced with `IConfiguration` and `appsettings.json`
- **`Global.asax`** — this should have been migrated to `Program.cs` and `Startup.cs` or the minimal hosting model

### 6. Verify Static Files and Views

If the project is a web application, confirm that static files (CSS, JavaScript, images) are being served correctly and that views render as expected. Check that the `wwwroot` folder is structured correctly and that the static file middleware is configured.

### 7. Run Unit Tests

If the solution contains test projects, run them to confirm existing test coverage passes.

```bash
dotnet test
```

Review any failing tests, as they may indicate behavioral differences introduced by the migration.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect and perform operations as expected. If Entity Framework is used, verify that migrations are up to date.

```bash
dotnet ef database update
```

### 9. Test on Target Platforms

Since the goal of the transformation is cross-platform compatibility, run and validate the application on each platform you intend to support (Windows, Linux, macOS) to confirm there are no platform-specific runtime issues.

### 10. Review Application Logs

Run the application and review the output logs for any runtime warnings or errors that do not surface during the build. Pay particular attention to middleware configuration issues, missing configuration keys, or unhandled exceptions.