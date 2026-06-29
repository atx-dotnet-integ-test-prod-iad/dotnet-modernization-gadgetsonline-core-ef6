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

Check the output for any warnings that, while non-fatal, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying particular attention to areas that relied heavily on Windows-specific APIs or legacy ASP.NET features prior to migration.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions introduced during migration or tests that require updating to align with the new framework.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were removed or significantly changed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in .NET Core and beyond
- `HttpContext` and related types, which have changed in ASP.NET Core
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (which requires additional packages on non-Windows platforms)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to surface any remaining compatibility issues.

### 7. Review Configuration Files

Ensure that `appsettings.json` contains all configuration values that were previously held in `Web.config` or `App.config`. Verify that connection strings, application settings, and environment-specific values have been correctly migrated.

### 8. Validate Static Files and Middleware

If this is a web application, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Verify that any custom HTTP handlers or modules from the legacy project have been replaced with the appropriate ASP.NET Core middleware equivalents.

### 9. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended target operating system (e.g., Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear at build time.

### 10. Publish the Application

Once validation is complete, publish the application using the following command, adjusting the runtime identifier as needed:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Review the publish output directory to confirm all required files are present before deploying to the target environment.