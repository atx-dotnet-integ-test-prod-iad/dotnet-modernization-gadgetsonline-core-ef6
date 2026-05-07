# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it targets `net8.0` or the appropriate modern TFM rather than a legacy `net48` or `netcoreapp` value.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its primary features to confirm runtime behavior matches the legacy version.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any were replaced during transformation, verify the replacements behave correctly at runtime.
- **Windows-specific APIs**: Any code relying on the Windows registry, `System.Drawing` (GDI+), or COM interop should be tested explicitly on the target platform.
- **Configuration**: Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` and are being read correctly.
- **Authentication and Session**: If the project uses ASP.NET membership, forms authentication, or session state, verify these were migrated to their ASP.NET Core equivalents and function correctly.

### 6. Run Existing Tests

If the solution contains a test project, run all tests to validate logic correctness:

```bash
dotnet test
```

Review any failing tests and address regressions introduced by the migration.

### 7. Database Connectivity

If the project connects to a database, verify:

- Connection strings in `appsettings.json` are correct for the target environment.
- Entity Framework or other ORM migrations are up to date by running:

```bash
dotnet ef database update
```

- Queries execute correctly and return expected results.

### 8. Static Files and Bundling

If the project serves static assets, confirm that static file middleware is configured in `Program.cs` or `Startup.cs` and that all CSS, JavaScript, and image assets are served correctly when the application runs.

### 9. Publish the Application

Once local validation is complete, produce a published output to confirm the release artifact is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the output to the target environment according to your standard deployment process.