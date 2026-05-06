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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Search the codebase for any usage of APIs that are not supported in cross-platform .NET, such as:

- `System.Web` namespaces (commonly used in legacy ASP.NET projects)
- `HttpContext` usage that relies on `System.Web.HttpContext` rather than `Microsoft.AspNetCore.Http.HttpContext`
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain.CurrentDomain.SetupInformation`

These may not produce build errors but can cause runtime failures.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally hosted URL and verify that core functionality, routing, and pages load as expected.

### 6. Review Configuration Files

Confirm that `appsettings.json` contains the necessary configuration that may have previously resided in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings keys
- Authentication configuration

If a `Web.config` file still exists, verify whether its contents have been fully migrated to `appsettings.json` and the ASP.NET Core middleware pipeline.

### 7. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the migration or tests that require updating to reflect the new project structure.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection string in `appsettings.json` is correct and that the application can connect and perform basic read/write operations at runtime.

### 9. Check Static Files and wwwroot

If this is a web project, ensure that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder, as this is the expected convention for ASP.NET Core applications.

### 10. Review Middleware and Startup Configuration

If the project previously used `Global.asax` or `Startup.cs` in a legacy format, confirm that the middleware pipeline in the current `Program.cs` or `Startup.cs` correctly registers:

- Routing
- Authentication and authorization
- Static file serving
- Any custom HTTP modules or handlers that were migrated