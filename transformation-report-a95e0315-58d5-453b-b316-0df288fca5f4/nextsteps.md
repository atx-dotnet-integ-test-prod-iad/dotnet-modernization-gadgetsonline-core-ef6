# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should now reference `Microsoft.AspNetCore.Http`.
- Any Windows-specific APIs such as the registry, WMI, or COM interop, which will not function on non-Windows platforms.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm runtime behavior is correct.

### 6. Run Existing Tests

If the solution contains test projects, execute them to verify functional correctness:

```bash
dotnet test
```

Review the test results and address any failing tests that may indicate runtime regressions introduced during the migration.

### 7. Review Configuration Files

- Confirm that `web.config` settings have been migrated to `appsettings.json` where applicable.
- Verify that connection strings, application settings, and environment-specific values are correctly represented in the new configuration system.
- Ensure `Program.cs` and, if present, `Startup.cs` correctly configure services and middleware that were previously handled by `Global.asax` or `web.config` HTTP modules and handlers.

### 8. Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as this is required for ASP.NET Core to serve them correctly.

### 9. Database and Entity Framework

If the project uses Entity Framework, verify the following:

- The correct version of EF Core is referenced (not the legacy `EntityFramework` package unless intentionally retained).
- Migrations are present and up to date by running:

```bash
dotnet ef migrations list
```

- The database can be reached and updated:

```bash
dotnet ef database update
```