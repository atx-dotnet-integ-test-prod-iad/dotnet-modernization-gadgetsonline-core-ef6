# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate framework.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as in the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate business logic and integration points:

```bash
dotnet test
```

Review the test results and address any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may need to be accessed differently in ASP.NET Core
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `App.config` or `Web.config` settings, which should be migrated to `appsettings.json`

### 7. Verify Static Files and Configuration

If this is a web project, confirm that `wwwroot` contains the expected static assets and that `appsettings.json` holds the correct configuration values for the target environment.

### 8. Test Against a Target Database

If the application uses a database, verify that connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

Confirm that data access operations function correctly end to end.