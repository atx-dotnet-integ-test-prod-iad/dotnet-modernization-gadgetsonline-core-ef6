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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas that were not fully modernized.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is set to an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to check for any runtime exceptions that would not have been caught at build time.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by the migration or represent pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed behavior or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references — these are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `ConfigurationManager` — should be replaced with `Microsoft.Extensions.Configuration`.
- `HttpContext.Current` — should be replaced with injected `IHttpContextAccessor`.
- Windows-specific APIs such as the registry or certain `System.Drawing` features.

### 7. Review Static Files and Configuration

Verify that `appsettings.json` contains all configuration values that were previously in `web.config` or `app.config`. Confirm that connection strings, application settings, and any custom configuration sections have been correctly migrated.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection string in `appsettings.json` is correct for the target environment and that the ORM or data access layer functions as expected at runtime.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to the target environment.