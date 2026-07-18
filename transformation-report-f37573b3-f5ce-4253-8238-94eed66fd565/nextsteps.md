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

Perform a full build to confirm there are no errors or warnings introduced at compile time:

```bash
dotnet build --configuration Release
```

Address any warnings that may surface, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime environment where the application will be deployed.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in the .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies (not available in cross-platform .NET)
- `HttpContext` and related types (replaced by ASP.NET Core equivalents)
- Windows-specific APIs such as the registry, WCF server-side, or `System.Drawing` (requires additional packages on non-Windows platforms)
- Configuration APIs (`System.Configuration.ConfigurationManager` requires the `System.Configuration.ConfigurationManager` NuGet package)

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

### 6. Run the Application Locally

Start the application locally and perform manual smoke testing of core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that:
- The application starts without runtime exceptions
- Core user-facing features function as expected
- Database connections and data access layers operate correctly
- Any authentication or session management behaves as intended

### 7. Review Static Files and Middleware Configuration

If this is an ASP.NET Core web application, confirm that middleware is configured correctly in `Program.cs` or `Startup.cs`, including:

- Static file serving (`UseStaticFiles`)
- Routing (`UseRouting`, `MapControllers`, or `MapRazorPages`)
- Authentication and authorization middleware order

### 8. Validate Configuration Files

Ensure that `appsettings.json` contains all necessary configuration values that were previously stored in `web.config` or `app.config`. Connection strings, application settings, and environment-specific values should all be accounted for.

### 9. Test on Target Platform

If the goal is cross-platform deployment, test the application on the intended target operating system (Linux or macOS) to surface any remaining platform-specific issues that would not appear during development on Windows.