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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it to the current Long Term Support (LTS) release.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures before proceeding.

### 5. Verify Runtime Behavior

Run the application locally to confirm it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Manually exercise the key workflows of the application and compare behavior against the original legacy version.

### 6. Check for Platform-Specific Code

Search the codebase for any APIs or libraries that were specific to the legacy .NET Framework and may not behave identically on cross-platform .NET. Common areas to review include:

- `System.Web` references or usages
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- `AppDomain` usage
- Any P/Invoke calls targeting Windows-only native libraries

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility concerns.

### 7. Review Configuration Files

Ensure that any configuration previously held in `Web.config` or `App.config` has been properly migrated to `appsettings.json` or the appropriate .NET configuration provider. Verify connection strings, application settings, and any custom configuration sections are functioning correctly at runtime.

### 8. Validate NuGet Package Compatibility

Review all third-party NuGet packages referenced in the project and confirm they support the target .NET version. Packages that only target `net45` or similar legacy monikers may require updates or replacements.

```bash
dotnet list package --outdated
```

Update packages where appropriate and re-run the build and tests after doing so.