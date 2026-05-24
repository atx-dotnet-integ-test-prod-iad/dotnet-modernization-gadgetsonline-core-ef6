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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas of the code that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net6.0` or `net7.0`, consider updating it, as those versions are out of support.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that functionality is intact after the migration.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate that existing behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that require updating due to the migration.

### 6. Check for Removed or Changed APIs

Review any usage of the following areas that commonly change between .NET Framework and cross-platform .NET:

- **`System.Web`**: This namespace is not available in cross-platform .NET. Any remaining references should have been replaced with ASP.NET Core equivalents.
- **`HttpContext`**, **`HttpRequest`**, **`HttpResponse`**: Ensure these are using the `Microsoft.AspNetCore.Http` versions and not the legacy `System.Web` versions.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that database migrations are functioning correctly.
- **Configuration**: Verify that `web.config`-based configuration has been replaced with `appsettings.json` and the `IConfiguration` pattern.

### 7. Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, which is the expected location in ASP.NET Core.

### 8. Verify Middleware Pipeline

Open `Program.cs` or `Startup.cs` and confirm the middleware pipeline is correctly configured, including:

- Authentication and authorization middleware
- Static file serving
- Routing
- Any custom middleware previously implemented in `HttpModule` or `HttpHandler` classes

### 9. Database Connectivity

If the application connects to a database, verify the connection string in `appsettings.json` is correct for the target environment and that the application can successfully connect and perform operations.

```json
"ConnectionStrings": {
  "DefaultConnection": "your-connection-string-here"
}
```

### 10. Review Deployment Target

Confirm the deployment target environment supports the chosen .NET version. Publish the application using the following command to produce deployment artifacts:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all expected files are present before deploying to the target environment.