# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages. Address any packages that may have been targeting the old .NET Framework and require updated cross-platform equivalents.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings introduced at compile time:

```bash
dotnet build --configuration Release
```

Review any warnings in the output, as some may indicate deprecated APIs or compatibility concerns that could surface at runtime.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected on the new runtime:

```bash
dotnet test
```

Review test results carefully. Any failures should be investigated to determine if they are caused by behavioral differences between the old and new target frameworks.

### 4. Review Runtime Dependencies

Check for any dependencies that relied on Windows-specific APIs or libraries (e.g., `System.Drawing`, COM interop, registry access, or Windows-only NuGet packages). These may not produce build errors but can cause runtime failures on non-Windows platforms.

### 5. Run the Application Locally

Start the application locally and manually exercise its core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and any Entity Framework migrations
- File system paths that may have been hardcoded using Windows-style separators
- Authentication and session handling
- Any HTTP handlers or modules that may have been replaced by middleware

### 6. Review Configuration Files

Inspect `appsettings.json` and any environment-specific configuration files to confirm that settings previously stored in `web.config` or `app.config` have been correctly migrated. Verify connection strings, application settings, and any custom configuration sections.

### 7. Check Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly by the static files middleware.

### 8. Verify Logging

Confirm that any logging configuration previously set up (e.g., via `log4net`, `NLog`, or `System.Diagnostics`) has been migrated to or replaced by the `Microsoft.Extensions.Logging` infrastructure, or that the existing logging library is functioning correctly under the new framework.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assemblies, and assets are present before deploying to the target environment.