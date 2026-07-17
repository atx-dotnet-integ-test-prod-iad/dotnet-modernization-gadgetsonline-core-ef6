# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about missing or incompatible packages. If any packages are flagged as incompatible with the new target framework, check [NuGet.org](https://www.nuget.org) for updated versions.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or other concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your intended deployment environment.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that core functionality behaves as it did in the legacy version.

### 5. Check for Removed or Changed APIs

Cross-platform .NET does not include certain APIs that were available in .NET Framework. Use the .NET Upgrade Assistant compatibility analyzer or review the Microsoft documentation on [.NET Framework to .NET compatibility](https://learn.microsoft.com/en-us/dotnet/core/porting/net-framework-tech-unavailable) to identify any runtime issues that would not surface as build errors, such as:

- `System.Web` dependencies replaced by `Microsoft.AspNetCore`
- Windows-specific APIs (registry access, `System.Drawing`, etc.)
- `HttpContext` or session handling differences

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Verify Static Assets and Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are correctly included in the project output.
- Check that connection strings and environment-specific settings are properly configured.

### 8. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to your target environment.