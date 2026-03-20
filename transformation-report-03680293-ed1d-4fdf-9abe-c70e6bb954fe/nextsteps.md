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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as expected compared to the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review the results for any failing tests that may indicate runtime regressions introduced during the migration.

### 6. Check for Windows-Specific APIs

Search the codebase for any APIs that were specific to the .NET Framework and may not be fully supported on cross-platform .NET. Common areas to check include:

- `System.Web` references (should be replaced with `Microsoft.AspNetCore` equivalents)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- `AppDomain.GetCurrentThreadId()` or other obsolete threading APIs

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility issues.

### 7. Validate Configuration

Confirm that any configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or environment variables, and that the application reads these values correctly at runtime.

### 8. Publish the Application

Once all validation steps pass, publish the application to verify the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all expected assets, static files, and dependencies are present before deploying to your target environment.