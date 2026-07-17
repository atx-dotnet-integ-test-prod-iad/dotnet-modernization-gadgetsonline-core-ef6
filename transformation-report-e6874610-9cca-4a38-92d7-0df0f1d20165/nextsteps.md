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

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate cross-platform version your team has standardized on.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected compared to the legacy version.

### 5. Check for Runtime Errors

Even with a clean build, runtime issues can surface. Pay particular attention to:

- **Database connectivity**: Confirm connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date by running:
  ```bash
  dotnet ef database update
  ```
- **Static files and routing**: Verify that middleware configuration in `Program.cs` or `Startup.cs` correctly serves static files and maps routes.
- **Authentication/Authorization**: If the legacy project used `System.Web` membership or forms authentication, confirm these have been replaced with ASP.NET Core equivalents.

### 6. Execute Unit and Integration Tests

If a test project exists in the solution, run all tests to validate business logic:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the transformation.

### 7. Review Removed or Changed APIs

Cross-reference the codebase for any APIs that existed in the .NET Framework but behave differently in cross-platform .NET, including:

- `HttpContext` and `HttpRequest` usage
- `ConfigurationManager` replaced by `IConfiguration`
- `System.Web` references, which are not available in cross-platform .NET
- Any Windows-specific APIs such as the registry or Windows identity model

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required assets, configuration files, and binaries are present before deploying to the target environment.