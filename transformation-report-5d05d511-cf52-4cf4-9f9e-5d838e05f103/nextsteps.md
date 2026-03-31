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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that pages load and core functionality behaves as expected.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` dependencies, which are not available in .NET Core or later
- `HttpContext` and related types, which may have different namespaces or behaviors
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `Global.asax` logic, which should be migrated to `Program.cs` or `Startup.cs` middleware

### 6. Verify Configuration Files

Ensure that `web.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, app settings, and custom configuration sections should be reviewed and confirmed to load correctly at runtime.

### 7. Test Data Access

If the project uses Entity Framework or another ORM, verify that:

- Migrations are up to date by running `dotnet ef migrations list`
- The database connection is established correctly at runtime
- Basic CRUD operations function as expected

### 8. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate application logic:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to legitimate regressions or test code that itself requires updating for the new framework.

### 9. Check Static Assets and Middleware

For web projects, confirm that static files, routing, and middleware are configured correctly in `Program.cs`. Verify that the application serves static assets and that routing behaves as expected for all defined endpoints.

### 10. Review Event Log and Console Output

During local testing, monitor the console output and any application logs for runtime exceptions or warnings that would not surface during a build, such as missing configuration values or failed service registrations.