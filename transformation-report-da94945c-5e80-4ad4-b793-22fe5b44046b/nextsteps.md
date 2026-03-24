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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it targets `net8.0` or another actively supported .NET version rather than a legacy `net4x` framework moniker.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running application and verify that core functionality behaves as expected, including any database connections, authentication flows, and page rendering.

### 5. Review Configuration Files

Check that `appsettings.json` (and `appsettings.Development.json`) contain the correct configuration values that were previously held in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings keys
- Any environment-specific values

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` usage, which should now flow through dependency injection
- `ConfigurationManager`, which should be replaced with `IConfiguration`
- Any Windows-specific APIs such as the registry or `System.Drawing` (GDI+)

### 7. Run Existing Tests

If the solution contains test projects, execute them to confirm existing behavior is preserved:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 8. Verify Static Assets and Views

If this is a web application, manually verify that static assets (CSS, JavaScript, images) are served correctly and that all views or Razor pages render without errors.

### 9. Check Database Migrations

If the project uses Entity Framework, confirm that migrations are compatible with the new runtime:

```bash
dotnet ef database update
```

Verify the database schema matches expectations after the migration runs.

### 10. Deploy to a Staging Environment

Once all local validation steps pass, publish the application to a staging environment using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the output to the target hosting environment and perform a final round of functional testing before promoting to production.