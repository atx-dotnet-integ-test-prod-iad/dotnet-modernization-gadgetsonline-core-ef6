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

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it is using `net8.0` or another currently supported .NET version rather than a legacy `net48` or `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as expected. Pay particular attention to any areas that relied on Windows-specific APIs or legacy ASP.NET features, as these are common sources of runtime issues that do not always surface as build errors.

### 5. Review `web.config` and `app.config` Usage

Cross-platform .NET does not use `web.config` for application configuration at runtime in the same way as .NET Framework. Confirm that configuration has been migrated to `appsettings.json` and that `IConfiguration` is being used appropriately throughout the application.

### 6. Check for Windows-Specific API Usage

Even without build errors, the code may reference APIs that only function correctly on Windows. Run the .NET compatibility analyzer if it is not already enabled by adding the following to the `.csproj`:

```xml
<EnableNETAnalyzers>true</EnableNETAnalyzers>
<AnalysisMode>All</AnalysisMode>
```

Rebuild and review any new analyzer warnings related to platform compatibility.

### 7. Run Existing Tests

If the solution contains test projects, execute them to validate that business logic has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the transformation or pre-existing issues.

### 8. Verify Database Connectivity

If the application uses Entity Framework or direct database access, confirm that the connection strings in `appsettings.json` are correct and that the application can connect to the database and perform standard operations such as queries and migrations.

If using Entity Framework Core, apply any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Review Static Files and Bundling

If the project previously used `System.Web.Optimization` for bundling and minification, confirm that this has been replaced with a supported alternative such as the ASP.NET Core built-in static file middleware or a tool like `libman` or `npm`-based bundling.

### 10. Publish the Application

Once local validation is complete, produce a published output to confirm the deployment artifact is generated correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all expected assets, configuration files, and binaries are present before deploying to the target environment.