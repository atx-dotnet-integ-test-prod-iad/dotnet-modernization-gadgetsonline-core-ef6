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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to confirm functional behavior is preserved from the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during the transformation or pre-existing issues.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` compatibility tooling to scan for any runtime usage of APIs that may not be available on non-Windows platforms.

Pay particular attention to:
- `System.Web` usages (not available in .NET Core/5+)
- Windows Registry access
- Windows-specific file path assumptions
- `HttpContext` and related ASP.NET types if this is a web project

### 7. Verify Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and contain the correct configuration values that were previously held in `Web.config` or `App.config`. Confirm that connection strings and application settings have been migrated correctly.

### 8. Test on Target Platform

If the goal is cross-platform support, run and test the application on the intended non-Windows platform (Linux or macOS) to surface any platform-specific issues that would not appear during Windows-based development.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Review Static Files and Middleware (If Web Project)

If `GadgetsOnline` is an ASP.NET Core web project, confirm that:
- Static file middleware is configured in `Program.cs` or `Startup.cs`
- Routing is correctly set up
- Authentication and authorization middleware, if used, has been migrated from the legacy OWIN/Katana pipeline to the ASP.NET Core middleware pipeline