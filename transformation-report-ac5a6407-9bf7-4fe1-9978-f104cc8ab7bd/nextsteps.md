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

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another .NET Framework moniker, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Inspect the codebase for usage of APIs that are not available in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available outside of ASP.NET on .NET Framework
- `HttpContext` and related types, which may have changed namespaces or behavior
- Windows-specific APIs such as the registry, WMI, or COM interop
- Any third-party libraries that may still target .NET Framework only

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to assist with this review.

### 7. Verify Configuration Files

Confirm that configuration has been properly migrated:

- `Web.config` or `App.config` settings should be moved to `appsettings.json` if they have not been already
- Connection strings, application settings, and environment-specific values should be present and correct
- Middleware and startup configuration in `Startup.cs` or `Program.cs` should reflect the intended application behavior

### 8. Test on Target Platform

If cross-platform support is a goal, run and validate the application on the target operating system (e.g., Linux or macOS) in addition to Windows to surface any platform-specific issues.

### 9. Deployment

Once all validation steps pass, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy them to your target hosting environment, such as IIS, a Linux server with the .NET runtime installed, or Azure App Service.