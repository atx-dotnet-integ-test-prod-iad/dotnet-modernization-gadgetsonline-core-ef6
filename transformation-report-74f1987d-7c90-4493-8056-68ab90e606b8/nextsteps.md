# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the correct SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages that may need to be updated to ASP.NET Core patterns.
- Any usage of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- Windows-specific APIs such as the registry, WMI, or Windows-only cryptography providers.

### 5. Run the Application Locally

Start the application using the .NET CLI to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary features to confirm expected behavior.

### 6. Execute Existing Tests

If the solution contains test projects, run them to verify that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression or a test that requires updating due to the migration.

### 7. Review Configuration Files

Ensure that configuration files have been correctly migrated:

- `Web.config` or `App.config` settings should be moved to `appsettings.json` if they have not been already.
- Connection strings, application settings, and environment-specific values should be verified in the new configuration structure.

### 8. Verify Static Files and Content

If the project serves static files, confirm that the `wwwroot` folder is correctly structured and that static file middleware is configured in the application startup.

### 9. Check Logging Configuration

Confirm that any legacy logging frameworks have been replaced or integrated with `Microsoft.Extensions.Logging`, and that log output is functioning as expected when the application runs.

### 10. Publish the Application

Once the application has been validated locally, produce a published output to confirm the deployment artifact builds correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files, assemblies, and assets are present before deploying to the target environment.