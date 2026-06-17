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

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it targets `net8.0` or the appropriate modern TFM rather than a legacy `net48` or `netcoreapp` value.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that functionality behaves as expected compared to the legacy version.

### 5. Review Configuration Files

Check that `appsettings.json` (and `appsettings.Development.json` if present) contains all configuration values that were previously held in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings keys
- Authentication or authorization configuration

### 6. Verify Database Connectivity

If the application uses a database, confirm that the connection string in `appsettings.json` is correct and that the application can connect and perform queries at runtime. If Entity Framework is in use, run any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 7. Execute Existing Tests

If a test project exists within the solution, run all tests to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures before proceeding.

### 8. Inspect Runtime Warnings

Even with a clean build, runtime warnings may surface. Run the application with the `Development` environment to capture detailed diagnostic output:

```bash
set ASPNETCORE_ENVIRONMENT=Development
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

On Linux or macOS:

```bash
ASPNETCORE_ENVIRONMENT=Development dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to the target environment.