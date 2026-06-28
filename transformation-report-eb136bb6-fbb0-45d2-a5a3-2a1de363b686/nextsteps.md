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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and that the appropriate meta-packages such as `Microsoft.AspNetCore.App` are referenced correctly.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage, which may need to be updated to ASP.NET Core equivalents
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `Global.asax`, which should be replaced with `Program.cs` and `Startup.cs` patterns or the minimal hosting model

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected. Check the console output for any runtime errors or unhandled exceptions.

### 6. Review Static Files and Configuration

Ensure that static files, connection strings, and application settings have been migrated correctly:

- `Web.config` settings should be moved to `appsettings.json`
- Static files should be served via the `UseStaticFiles()` middleware
- Any transforms or environment-specific config previously handled by `Web.config` transforms should now use environment-specific `appsettings.{Environment}.json` files

### 7. Run Existing Tests

If the solution contains test projects, run them to verify that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures to determine whether they are caused by the migration or pre-existing issues.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect and perform queries as expected. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update
```