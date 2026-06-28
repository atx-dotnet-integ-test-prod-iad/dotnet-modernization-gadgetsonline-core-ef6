# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about missing or incompatible packages. Pay attention to any packages that may have been replaced with compatibility shims during the transformation, as these may need to be updated to their cross-platform equivalents.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings, as some warnings may indicate deprecated APIs or platform-specific code paths that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework moniker (TFM) is set to an appropriate cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure it is not still referencing a Windows-only TFM such as `net48` or `net472`.

### 4. Check for Windows-Specific Dependencies

Search the codebase for any remaining Windows-specific APIs or packages that may not have been caught during transformation:

- References to `System.Web` (not supported in .NET Core and later)
- Usage of the Windows Registry (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- Any P/Invoke calls targeting Windows-only DLLs

```bash
grep -rn "System.Web" --include="*.cs"
grep -rn "Microsoft.Win32" --include="*.cs"
```

### 5. Run the Application Locally

Start the application to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that core functionality is intact.

### 6. Run Existing Tests

If the solution contains test projects, execute the test suite:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the transformation.

### 7. Verify Configuration Files

Check that configuration has been properly migrated:

- If the project previously used `Web.config` or `App.config`, confirm that settings have been moved to `appsettings.json` or environment variables.
- Verify connection strings, API keys, and other environment-specific values are correctly referenced in the new configuration system.

### 8. Validate Static Assets and Views

If `GadgetsOnline` is a web application, manually verify that:

- Static files (CSS, JavaScript, images) are served correctly.
- All views or Razor pages render without errors.
- Any bundling or minification configuration has been updated to use the .NET tooling equivalents.

### 9. Test on Target Platforms

Since the goal of the transformation is cross-platform support, run and validate the application on each intended target operating system (e.g., Linux, macOS) to surface any platform-specific runtime issues that would not appear on Windows.

### 10. Review Deprecated or Removed APIs

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to scan for any API usage that is present but marked as obsolete in the new target framework:

```bash
dotnet build /warnaserror:nullable
```

Address any reported obsolete API usages by replacing them with their recommended modern equivalents.