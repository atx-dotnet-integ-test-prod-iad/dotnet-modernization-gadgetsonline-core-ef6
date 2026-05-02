# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate compatibility concerns with the target framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it still references `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify runtime behavior matches the legacy version. Pay particular attention to:

- Database connectivity and any Entity Framework migrations
- Authentication and session management
- Any file system operations that may have relied on Windows-specific paths

### 5. Execute Existing Tests

If a test project exists in the solution, run:

```bash
dotnet test
```

Review test results and address any failing tests that may reveal runtime regressions not caught at compile time.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may contain calls to Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer to surface these:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
```

Review any analyzer warnings that appear after adding this package and rebuilding.

### 7. Review `web.config` / `app.config` Usage

If the legacy project relied on `web.config` or `app.config` for configuration, verify that settings have been migrated to `appsettings.json` and that `IConfiguration` is being used to read them in the new project structure.

### 8. Verify Static Files and wwwroot

For web projects, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly by the middleware pipeline defined in `Program.cs` or `Startup.cs`.

### 9. Database Migrations

If Entity Framework Core is in use, verify that migrations are up to date:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

If the project migrated from Entity Framework 6 to Entity Framework Core, review the migration files manually for any unsupported constructs.

### 10. Cross-Platform Smoke Test

Run the application on each target operating system (Windows, Linux, macOS) to confirm there are no platform-specific runtime failures before considering the migration complete.