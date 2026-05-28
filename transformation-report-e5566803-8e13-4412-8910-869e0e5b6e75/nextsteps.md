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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm that the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the core functionality to check for any runtime exceptions that would not have been caught at compile time.

### 5. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usages, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have changed
- Windows-specific APIs such as the registry, WCF, or remoting
- `ConfigurationManager` usage, which requires the `System.Configuration.ConfigurationManager` NuGet package

### 6. Review Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Cross-platform .NET primarily uses `appsettings.json` for configuration. Verify that connection strings, application settings, and environment-specific values are correctly represented.

### 7. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect and perform queries as expected. If Entity Framework is in use, check whether any pending migrations need to be applied:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify this with:

```bash
dotnet --list-runtimes
```

Start the application on the target environment and perform a final round of smoke testing to confirm the deployment is functioning correctly.