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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or another legacy framework moniker, update it accordingly.

### 4. Check for Platform-Specific Code

Search the codebase for any APIs that were specific to Windows or the legacy .NET Framework that may not throw build errors but could cause runtime failures. Common areas to check include:

- `System.Web` references or usages
- Windows Registry access
- `HttpContext` and related ASP.NET Web Forms constructs
- `ConfigurationManager` and `app.config` / `web.config` usage, which should be migrated to `appsettings.json` and `IConfiguration`

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm expected behavior at runtime.

### 6. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate functional correctness:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 7. Review Configuration Files

Ensure that any configuration previously held in `web.config` or `app.config` has been properly migrated to `appsettings.json`. Verify that connection strings, application settings, and environment-specific values are correctly represented and loaded at runtime.

### 8. Validate Static Assets and Views

If the project is a web application, manually verify that static assets (CSS, JavaScript, images) are served correctly and that all views or pages render without errors.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Deploy to Target Environment

Copy the published output to the target hosting environment. Ensure the correct .NET runtime version is installed on that environment by running:

```bash
dotnet --info
```

Start the application and perform a final round of smoke testing against the deployed instance.