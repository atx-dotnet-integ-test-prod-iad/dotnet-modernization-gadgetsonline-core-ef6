# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's key workflows to confirm expected behavior.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Verify Static Assets and Configuration Files

- Confirm that `appsettings.json` and any environment-specific variants (e.g., `appsettings.Production.json`) are present and contain the correct configuration values.
- Verify that any static files (CSS, JavaScript, images) are located under the `wwwroot` folder if this is an ASP.NET Core web project.
- Check that connection strings and other environment-specific settings are correctly configured for the target deployment environment.

### 7. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in .NET Core or later.
- `HttpContext` and related types, which have changed in ASP.NET Core.
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (which requires additional packages on non-Windows platforms).

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to identify any remaining compatibility concerns.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.