# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution. The `GadgetsOnline` project compiled without issues under the new cross-platform .NET target.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need to be updated.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas of the code that may behave differently on cross-platform .NET compared to .NET Framework.

### 3. Run Unit Tests

If the solution contains any test projects, execute them to verify that existing functionality is preserved:

```bash
dotnet test --configuration Release
```

Review test output carefully. A passing build does not guarantee runtime correctness, especially for code that previously relied on Windows-specific behavior.

### 4. Check for Runtime Dependencies

Review the application for any remaining dependencies on Windows-specific APIs or libraries, including:

- `System.Web` usage (not available in cross-platform .NET)
- Windows Registry access
- COM interop
- `HttpContext` usage patterns specific to ASP.NET (non-Core)
- Any third-party libraries that have not been updated for cross-platform .NET

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to identify any remaining compatibility concerns.

### 5. Run the Application Locally

Start the application locally and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that:
- The application starts without exceptions
- Database connections (if any) are functioning correctly
- Static files, routing, and middleware are behaving as expected
- Any authentication or session management works correctly under the new runtime

### 6. Review Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all necessary configuration values that were previously stored in `Web.config` or `App.config`. The transformation process may have partially migrated these, so a manual review is recommended.

Key areas to check:
- Connection strings
- Application settings / feature flags
- Logging configuration
- Authentication settings

### 7. Target Framework Verification

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and desired, update this value and re-run the build and test steps above.

### 8. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm that all required assets, configuration files, and dependencies are present before deploying to the target environment.