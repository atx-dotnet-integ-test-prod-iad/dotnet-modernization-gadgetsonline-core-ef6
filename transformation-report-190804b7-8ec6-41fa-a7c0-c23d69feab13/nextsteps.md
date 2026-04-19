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

Review the output for any warnings related to package compatibility or missing packages that may not have surfaced as build errors.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is not what you intended, update it and re-run `dotnet restore` and `dotnet build`.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 5. Check for Runtime-Only Issues

Some issues do not surface at build time. Pay attention to the following areas that commonly differ between .NET Framework and cross-platform .NET:

- **`System.Configuration`**: `ConfigurationManager` requires the `System.Configuration.ConfigurationManager` NuGet package on cross-platform .NET.
- **`HttpContext` and `System.Web`**: Any remaining dependencies on `System.Web` will not function and need to be replaced with ASP.NET Core equivalents.
- **Registry and Windows-specific APIs**: These will not work on non-Windows platforms.
- **Entity Framework**: If using EF6, consider whether migration to EF Core is required for full cross-platform support.
- **Globalization and encoding**: Cross-platform .NET has different defaults. Verify any encoding or culture-sensitive logic behaves as expected.

### 6. Run the Application Locally

Start the application and manually exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that pages load, data access works, and no unhandled exceptions occur at runtime.

### 7. Review Transformed Configuration Files

Check that `appsettings.json` (or equivalent) contains all configuration values that were previously in `Web.config` or `App.config`. Connection strings, application settings, and custom configuration sections should all be accounted for.

### 8. Verify Static Files and Web Assets

If this is a web project, confirm that static files (CSS, JavaScript, images) are being served correctly under the ASP.NET Core static file middleware. Ensure `app.UseStaticFiles()` is present in the application startup pipeline.

### 9. Validate Database Connectivity

If the application uses a database, confirm the connection string is correct in the new configuration format and that the application can connect and perform basic read/write operations.

### 10. Deploy to a Staging Environment

Once local validation is complete, deploy the application to a staging environment that mirrors production. Run the same validation steps in that environment before promoting to production.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying.