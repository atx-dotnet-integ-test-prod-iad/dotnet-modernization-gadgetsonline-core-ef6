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

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating or replacing packages that may not be compatible with the target .NET version.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Review the output for any warnings, even if the build succeeds. Warnings related to deprecated APIs or obsolete members may indicate areas that need attention before deployment.

### 3. Run Unit Tests

If the solution contains test projects, execute all tests to verify that existing functionality behaves as expected:

```bash
dotnet test
```

Review the test results for any failures or skipped tests. If tests were previously written against .NET Framework-specific behavior, some may require updates to run correctly on cross-platform .NET.

### 4. Verify Runtime Behavior

Run the application locally and manually exercise the core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to the following areas that commonly surface runtime issues after migration:

- **Database connectivity**: Ensure connection strings are correct and the data access layer functions as expected.
- **Authentication and authorization**: Verify that any security middleware is configured correctly for ASP.NET Core if applicable.
- **Static files and routing**: Confirm that routes resolve correctly and static assets are served as expected.
- **Configuration**: Check that `appsettings.json` or environment variables are being read correctly, replacing any legacy `Web.config` or `App.config` values that may have been in use.

### 5. Check for Removed or Changed APIs

Review the code for any usage of APIs that existed in .NET Framework but behave differently or are absent in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with identifying these areas.

Common areas to check include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` usage patterns
- Any Windows-specific APIs if cross-platform support is required
- Third-party libraries that may have separate .NET-compatible versions

### 6. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project targets a version that is out of support, consider updating it to a current Long-Term Support (LTS) release.

### 7. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present before deploying to the target environment.