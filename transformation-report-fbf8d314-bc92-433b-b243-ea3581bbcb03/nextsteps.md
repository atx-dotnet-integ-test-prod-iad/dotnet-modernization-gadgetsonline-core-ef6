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

If the project is a web application, confirm that the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, certain APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in cross-platform .NET)
- `HttpContext` and related types (should now come from `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Drawing` (requires additional packages or platform-specific handling)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm runtime behavior matches expectations from the legacy version.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review the test results and address any failing tests that may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review `web.config` vs `appsettings.json`

If the original project used `web.config` for application settings, confirm that those settings have been migrated to `appsettings.json` and that the application reads them correctly using `IConfiguration`.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- Connection strings are correctly defined in `appsettings.json`
- The data access layer (Entity Framework or otherwise) is functioning correctly by exercising database-dependent features of the application

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.