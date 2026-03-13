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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing a Windows-specific framework (e.g., `net472`), update it accordingly.

### 4. Check for Platform-Specific Code

Search the codebase for any APIs or libraries that were only available on Windows under .NET Framework. Common areas to review include:

- `System.Web` namespace usage (not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `HttpContext` and related ASP.NET types (ensure they have been migrated to ASP.NET Core equivalents)
- Any P/Invoke calls targeting Windows-only system libraries

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 7. Review Configuration Files

Ensure that configuration files have been properly migrated:

- `web.config` settings should be moved to `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings, app settings, and environment-specific values should be verified in the new configuration format
- Middleware previously configured in `web.config` (e.g., authentication, compression) should be confirmed as configured in `Program.cs` or `Startup.cs`

### 8. Verify Static Files and Routing

Confirm that static file serving and routing are functioning correctly under ASP.NET Core conventions. Check that `wwwroot` is properly structured and that any route configurations from the legacy project have been carried over.

### 9. Test on Target Platforms

Since the goal is cross-platform compatibility, test the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any remaining platform-specific issues.