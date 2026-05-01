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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and re-run the build.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they will need to be replaced with ASP.NET Core equivalents.
- **`HttpContext`**, **`HttpRequest`**, and **`HttpResponse`** usages should use the ASP.NET Core versions.
- **`ConfigurationManager`**: Replace with `Microsoft.Extensions.Configuration`.
- **`System.Drawing`**: If used, replace with a cross-platform alternative such as `SkiaSharp` or `ImageSharp`.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally hosted URL and verify that core functionality, routing, and pages load as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during migration or pre-existing issues.

### 7. Review Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed in the `wwwroot` folder, which is the expected location for static files in ASP.NET Core.

### 8. Verify Configuration Files

- Ensure `appsettings.json` contains the necessary configuration values previously held in `web.config` or `app.config`.
- Connection strings, application settings, and environment-specific values should be present and correctly formatted.

### 9. Database Connectivity

If the application uses a database, verify that:

- The connection string in `appsettings.json` is correct.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 10. Manual Functional Testing

Walk through the primary user-facing workflows of the application manually to confirm end-to-end behavior is functioning correctly after the migration.