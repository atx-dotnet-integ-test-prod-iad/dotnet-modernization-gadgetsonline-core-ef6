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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm basic functionality is intact.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`
- `Global.asax` replaced by `Program.cs` and `Startup.cs` (or the minimal hosting model)
- Windows-specific APIs such as the registry or certain cryptography providers

### 7. Verify Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, application settings, and environment-specific values should be present and correctly structured.

### 8. Check Static Files and wwwroot

If the project is a web application, verify that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder and are being served correctly when the application runs.

### 9. Validate Database Connectivity

If the application uses a database, confirm that the connection string is correct and that the application can connect successfully. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once the application has been validated locally, publish it to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.