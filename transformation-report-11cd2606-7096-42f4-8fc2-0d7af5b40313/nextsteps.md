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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your deployment environment.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality to identify any runtime issues that would not surface at build time.

### 5. Execute Existing Tests

If the solution contains a test project, run the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET pipeline APIs if this is a web project
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (which requires additional packages on non-Windows platforms)
- Any third-party NuGet packages that may have been targeting .NET Framework only — verify their compatibility with the new target framework

### 7. Review Configuration Files

Confirm that configuration has been correctly migrated from `Web.config` or `App.config` to the `appsettings.json` format used by modern .NET. Verify that connection strings, application settings, and environment-specific values are present and correct.

### 8. Test on Target Platform

If the goal is cross-platform deployment, run and test the application on the intended target operating system (Linux or macOS) to surface any platform-specific runtime issues that would not appear on Windows.

### 9. Deployment

Once the application has been validated locally and all tests pass, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target server and run the application using:

```bash
dotnet GadgetsOnline.dll
```

Ensure the correct version of the .NET runtime is installed on the target server prior to deployment.