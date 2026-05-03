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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm existing behavior is preserved:

```bash
dotnet test
```

Review the test results for any failures that may indicate regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET pipeline APIs if this is a web project
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (which requires additional packages on non-Windows platforms)
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package

### 7. Verify Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. In cross-platform .NET, `appsettings.json` is the standard configuration mechanism for most application types.

### 8. Check Database Connectivity

If the application uses a database, verify that the connection strings in `appsettings.json` are correct and that the application can connect and perform basic operations against the database.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Deploy

Copy the contents of the `./publish` directory to the target hosting environment. Ensure the target environment has the correct .NET runtime installed. You can verify the required runtime version from the `<TargetFramework>` value in the project file and download the appropriate runtime from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).