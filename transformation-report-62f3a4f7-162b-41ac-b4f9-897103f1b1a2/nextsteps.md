# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest supported LTS release.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality to check for any runtime exceptions or behavioral regressions.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review the results and address any failing tests that may indicate regressions introduced during the transformation.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related types, which may behave differently in ASP.NET Core
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` methods

### 7. Verify Configuration Files

Ensure that `appsettings.json` (or equivalent) is present and contains the necessary configuration that was previously held in `Web.config` or `App.config`. Confirm that connection strings, application settings, and environment-specific values have been correctly migrated.

### 8. Check Static Files and wwwroot

If this is a web application, verify that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder, as required by ASP.NET Core.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify the required runtime version with:

```bash
dotnet --info
```

If the runtime is not installed, download it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).