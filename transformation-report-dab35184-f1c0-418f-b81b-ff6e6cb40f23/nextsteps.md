# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. Avoid using `net5.0` or `net6.0` as these are out of support.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to check for runtime errors that would not surface at build time.

### 5. Check for Windows-Specific Dependencies

Since this was a legacy project, inspect the code and NuGet references for any remaining Windows-specific dependencies, such as:

- `System.Web` references (not available in .NET Core/5+)
- `Microsoft.Web.*` packages
- Windows Registry access (`Microsoft.Win32.Registry`)
- COM interop dependencies

These will not cause build errors on Windows but will fail on Linux or macOS.

### 6. Review Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, which is the expected location in ASP.NET Core.

### 7. Verify Configuration Migration

Check that configuration has been migrated from `Web.config` or `App.config` to `appsettings.json`. Confirm that the following are correctly configured:

- Connection strings
- Application settings
- Logging configuration
- Environment-specific settings (`appsettings.Development.json`, `appsettings.Production.json`)

### 8. Database Connectivity

If the application uses a database, run the application against a test database and verify:

- Connections are established successfully
- Queries execute as expected
- If using Entity Framework, run `dotnet ef database update` to apply any pending migrations

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Execute Existing Tests

If a test project exists in the solution, run all tests to validate application behavior:

```bash
dotnet test
```

Review any failing tests and determine whether they represent genuine regressions introduced during migration or tests that require updates to reflect new framework behavior.

### 10. Publish a Release Build

Once the above steps are completed, produce a published output to verify the deployment artifact is generated correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present.