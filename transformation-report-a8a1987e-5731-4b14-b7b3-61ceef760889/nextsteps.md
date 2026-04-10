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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a legacy `net48` or `netcoreapp` value).

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If a test project exists in the solution, run the test suite to catch any runtime or logic regressions:

```bash
dotnet test
```

Review the results and address any failing tests before proceeding.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` (replaced by `Program.cs` and `Startup.cs` or top-level statements)
- Windows-specific APIs such as the registry or certain `System.Drawing` features

### 7. Verify Static Files and Configuration

- Confirm that `wwwroot` contains the necessary static assets (CSS, JavaScript, images).
- Verify that `appsettings.json` contains the configuration values that were previously in `Web.config` or `App.config`.
- Ensure connection strings and environment-specific settings are correctly migrated.

### 8. Test Against a Real Database

If the application uses a database, run the application against a real or staging database instance and verify:

- Connections are established correctly.
- Queries return expected results.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.