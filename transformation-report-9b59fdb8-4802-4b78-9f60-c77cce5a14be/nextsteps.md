# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that may indicate deprecated APIs or compatibility concerns that did not surface as hard errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them with:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the transformation or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in the legacy .NET Framework but have changed behavior in cross-platform .NET. Common areas to inspect include:

- `System.Web` references or any remaining dependencies on ASP.NET Web Forms or `HttpContext` usage patterns specific to .NET Framework
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry, certain `System.Drawing` methods, or COM interop
- Any `App.config` or `Web.config` entries that may need to be migrated to `appsettings.json`

### 7. Verify Static Assets and Configuration Files

Ensure that any static files, connection strings, and application settings have been correctly moved to the appropriate configuration format for cross-platform .NET, such as `appsettings.json` or environment variables.

### 8. Test on Target Platform

If the intent is to run on a non-Windows operating system, test the application explicitly on that platform to surface any remaining platform-specific dependencies that may not cause build errors but will cause runtime failures.

```bash
dotnet publish --configuration Release --runtime linux-x64
```

Adjust the runtime identifier (`--runtime`) to match your intended deployment target.