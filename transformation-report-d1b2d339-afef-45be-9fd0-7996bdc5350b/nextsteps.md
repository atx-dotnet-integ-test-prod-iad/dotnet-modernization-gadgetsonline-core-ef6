# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the version of the .NET runtime installed on your target environment.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves the same as it did in the legacy project.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Replaced APIs

Review the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed behavior in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET pipeline components
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` methods

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to identify any remaining compatibility concerns.

### 7. Validate Configuration Files

Confirm that `appsettings.json` (or equivalent) is present and correctly replaces any legacy `Web.config` or `App.config` settings. Verify that connection strings, application settings, and environment-specific values are all accounted for.

### 8. Test on Target Operating Systems

Since the goal of the migration is cross-platform compatibility, run the application on each operating system you intend to support (Windows, Linux, macOS) to identify any platform-specific issues.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to file path handling, case sensitivity on Linux, and any platform-specific library dependencies.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files and assets are present before deploying to the target environment.