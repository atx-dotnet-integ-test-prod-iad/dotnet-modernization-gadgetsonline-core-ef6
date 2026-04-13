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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention even if they do not block compilation.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that core functionality behaves as expected.

### 5. Review Removed or Changed APIs

Check for any usages of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in .NET Core and later
- `HttpContext` and related types, which may behave differently
- Windows-specific APIs such as the registry or certain `System.Drawing` features
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package

### 6. Verify Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated appropriately to `appsettings.json` or `appsettings.{Environment}.json`. Confirm that the application reads configuration values correctly at runtime.

### 7. Check Static Files and wwwroot

If this is a web project, verify that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly by the application.

### 8. Run Existing Tests

If a test project exists in the solution, execute the test suite to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime or by incomplete migration steps.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, including configuration files and static assets, are present.

### 10. Verify on Target Operating System

If the goal of the migration was cross-platform support, run the published output on the target operating system (Linux or macOS) to confirm there are no platform-specific runtime issues:

```bash
dotnet ./publish/GadgetsOnline.dll
```