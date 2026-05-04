# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally hosted URL and exercise the core functionality of the application to check for any runtime errors that would not surface at compile time.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 6. Check for Removed or Changed APIs

Cross-platform .NET does not support certain Windows-specific or legacy .NET Framework APIs. Review the code for any usage of the following, which are common sources of runtime issues even when the build succeeds:

- `System.Web` namespaces (largely unavailable outside of ASP.NET Core)
- `HttpContext` usage patterns specific to `System.Web.HttpContext` rather than `Microsoft.AspNetCore.Http.HttpContext`
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` members that are not supported on .NET Core and later
- Any third-party libraries that were targeting .NET Framework exclusively

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to surface any remaining compatibility issues.

### 7. Verify Configuration

If the project previously used `Web.config` or `App.config`, confirm that configuration has been migrated to `appsettings.json` or environment variables, as `Web.config` is not used for application configuration in ASP.NET Core.

### 8. Validate Static Assets and Middleware

If the project is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs` using the ASP.NET Core pipeline, rather than relying on IIS-specific configuration.

### 9. Test on Target Platform

If cross-platform support is a goal, run and test the application on the target operating system (Linux or macOS) to surface any platform-specific issues that would not appear when testing on Windows.

### 10. Publish the Application

Once all validation steps pass, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents to your target environment.