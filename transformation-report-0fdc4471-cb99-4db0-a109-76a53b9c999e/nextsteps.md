# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without introducing any compilation errors.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Project
Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate compatibility concerns worth addressing.

### 3. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is set to `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are out of long-term support.

### 4. Run the Application Locally
Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm runtime behavior matches the original legacy project.

### 5. Execute Existing Tests
If the solution contains a test project, run the test suite to validate business logic and integration points:

```bash
dotnet test
```

Address any failing tests before proceeding to deployment.

### 6. Review Removed or Replaced APIs
Cross-platform .NET does not support certain Windows-specific APIs that were available in .NET Framework. Manually review the codebase for any of the following that may have been silently replaced or stubbed during transformation:

- `System.Web` references
- `HttpContext` usage patterns specific to ASP.NET (non-Core)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `System.Drawing` (GDI+) usage, which requires the `System.Drawing.Common` package and has platform restrictions

### 7. Verify Configuration Migration
Confirm that `web.config` or `app.config` settings have been properly migrated to `appsettings.json` and that the application reads them correctly at runtime. Check connection strings, application settings, and any environment-specific values.

### 8. Check Static Files and wwwroot
If this is a web project, verify that static assets (CSS, JavaScript, images) are present under the `wwwroot` folder and are being served correctly when the application runs.

### 9. Validate Database Connectivity
If the project uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 10. Publish the Application
Once local validation is complete, produce a published output to confirm the deployment artifact builds correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.