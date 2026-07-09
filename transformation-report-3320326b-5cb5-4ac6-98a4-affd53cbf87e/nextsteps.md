# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm expected behavior.

### 5. Run Existing Tests

If a test project exists within the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral changes introduced during the migration or pre-existing issues.

### 6. Review Removed or Changed APIs

Check for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` dependencies (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET types
- Windows-specific APIs (e.g., registry access, WCF server-side, `System.Drawing` on non-Windows)
- Configuration APIs (`ConfigurationManager` vs. `Microsoft.Extensions.Configuration`)

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `wwwroot` contents, and any other static resources were carried over correctly and are included in the project output.

### 8. Test on Target Platform

If the goal is cross-platform support, run and validate the application on each intended operating system (e.g., Linux, macOS) to surface any platform-specific runtime issues that would not appear during a Windows build.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.