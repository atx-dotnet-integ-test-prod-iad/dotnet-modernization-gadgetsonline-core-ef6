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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, certain APIs that existed in .NET Framework may have been removed or changed in cross-platform .NET. Run the .NET Upgrade Assistant compatibility analyzer or the platform compatibility analyzer to surface any runtime concerns:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality such as routing, database access, and authentication behaves correctly.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and investigate any failures that may point to behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Configuration Files

- Confirm that `web.config` settings that were relevant to the application have been migrated to `appsettings.json` or `appsettings.{Environment}.json`.
- Verify that connection strings, application settings, and environment-specific values are correctly represented.
- Ensure that any HTTP modules or HTTP handlers from the legacy project have been replaced with the equivalent ASP.NET Core middleware.

### 8. Validate Static Assets and Views

If the project uses Razor views or static files, confirm that:

- The `wwwroot` folder contains the expected static assets.
- Razor views render correctly and Razor syntax is compatible with the current version.
- Bundling and minification configurations have been updated if previously using `System.Web.Optimization`.

### 9. Database and Entity Framework Compatibility

If the project uses Entity Framework, confirm whether it was migrated from Entity Framework 6 to Entity Framework Core. If so:

- Verify that all `DbContext` configurations are correct.
- Run any pending migrations or validate the schema against the existing database.
- Test all data access paths to confirm queries return expected results.

### 10. Deployment

Once all validation steps pass:

- Publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

- Copy the contents of the `./publish` folder to the target server or hosting environment.
- Ensure the target environment has the appropriate .NET runtime installed. You can verify the required runtime version from the project file's `<TargetFramework>` value.