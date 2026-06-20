# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net9.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the use of `net8.0` or later and that the appropriate web SDK is referenced:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Cross-platform .NET does not include certain APIs that were available in .NET Framework. Review the code for usage of the following common problem areas:

- `System.Web` namespace (not available in .NET Core/5+)
- `HttpContext` usage outside of ASP.NET Core patterns
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Drawing` (requires the `System.Drawing.Common` NuGet package on non-Windows platforms, with limitations)
- Windows Registry APIs (`Microsoft.Win32.Registry`)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformCompat.Analyzer` NuGet package to surface any remaining compatibility issues.

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows and confirm that core functionality behaves correctly.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they represent regressions introduced during migration or pre-existing issues.

### 7. Verify Configuration Files

- Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) contain the correct configuration values previously held in `web.config` or `app.config`.
- Ensure connection strings, application settings, and any custom configuration sections have been correctly migrated.

### 8. Validate Static Files and Middleware (If Web Project)

If `GadgetsOnline` is a web application:

- Confirm that static files (CSS, JavaScript, images) are located under the `wwwroot` folder.
- Review `Program.cs` or `Startup.cs` to ensure middleware is configured correctly, including routing, authentication, and static file serving.

### 9. Cross-Platform Smoke Test

If cross-platform support is a goal, run the application on a non-Windows operating system (Linux or macOS) to identify any platform-specific issues that may not surface on Windows.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to file path separators, case-sensitive file systems, and any Windows-only library dependencies.

### 10. Review Published Output

Publish the application and review the output to ensure all required files are present:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify that the published folder contains the expected binaries, configuration files, and static assets before deploying to the target environment.