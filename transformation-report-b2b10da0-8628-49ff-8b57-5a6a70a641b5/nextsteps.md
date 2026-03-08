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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have been removed or changed in modern .NET. Common areas to check include:

- `System.Web` namespace usage (not available in modern .NET; replaced by `Microsoft.AspNetCore`)
- `HttpContext`, `HttpRequest`, `HttpResponse` — ensure these are the ASP.NET Core versions
- `ConfigurationManager` — replaced by `Microsoft.Extensions.Configuration`
- `Global.asax` — replaced by `Program.cs` and `Startup.cs` (or the minimal hosting model)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running URL (typically `http://localhost:5000` or `https://localhost:5001`) and verify that the application loads and core functionality works as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to verify that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences between .NET Framework and modern .NET.

### 7. Review Static Files and Content

If the project serves static files (CSS, JavaScript, images), confirm that the `wwwroot` folder is correctly structured and that the `UseStaticFiles()` middleware is registered in the application pipeline.

### 8. Verify Database Connectivity

If the application uses Entity Framework or another data access layer, confirm that:

- The connection strings in `appsettings.json` are correct
- The correct EF Core provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`)
- Any pending migrations are applied:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Review Application Configuration

Confirm that all configuration previously held in `Web.config` has been migrated to `appsettings.json`. Pay particular attention to:

- Connection strings
- Application settings (app keys/values)
- Any custom configuration sections

### 10. Test on Target Platform

If cross-platform support is a goal, run and test the application on the target operating system (Linux or macOS) to surface any platform-specific issues that may not appear on Windows.