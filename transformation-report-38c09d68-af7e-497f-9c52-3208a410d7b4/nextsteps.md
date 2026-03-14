# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm runtime behavior matches the legacy version.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to migration changes or pre-existing issues.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to scan for any runtime-level incompatibilities that would not surface as build errors:

```bash
dotnet tool install -g dotnet-compatibility
```

Pay particular attention to:
- `System.Web` dependencies that may have been replaced with ASP.NET Core equivalents
- Windows-specific APIs (e.g., registry access, `System.Drawing`) that may behave differently or require additional packages on non-Windows platforms
- Any use of `App.config` or `Web.config` that should be migrated to `appsettings.json`

### 7. Validate Configuration Files

Confirm that application configuration has been properly migrated:

- `Web.config` / `App.config` settings should be moved to `appsettings.json`
- Connection strings should be present in `appsettings.json` or environment variables
- Any `<system.web>` configuration should be replaced with ASP.NET Core middleware equivalents

### 8. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues.

### 9. Review Warnings

Even without errors, the build may have produced warnings. Review them with:

```bash
dotnet build 2>&1 | grep -i warning
```

Address any warnings related to nullable reference types, obsolete APIs, or package versions, as these can indicate future compatibility issues.