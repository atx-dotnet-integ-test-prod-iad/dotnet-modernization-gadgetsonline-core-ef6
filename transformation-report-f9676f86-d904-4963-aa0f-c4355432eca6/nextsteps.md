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

Confirm that the output shows zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

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

Search the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in modern .NET. Common areas to check include:

- `System.Web` namespace references (not available in modern .NET; replaced by `Microsoft.AspNetCore`)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` (replaced by `Program.cs` and `Startup.cs` or top-level statements)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output and verify that the application loads and functions as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 7. Review Configuration Files

Ensure that configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Verify that connection strings, application settings, and environment-specific values are all present and correct.

### 8. Validate Static Files and wwwroot

If the project serves static content, confirm that static files such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, and that static file serving middleware is enabled in the application pipeline.

### 9. Check Middleware and Startup Configuration

Review `Program.cs` (and `Startup.cs` if present) to confirm that all required middleware is registered, including:

- Routing
- Authentication and Authorization (if applicable)
- Session handling (if applicable)
- Error handling

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and verify that all expected files are present before deploying to the target environment.