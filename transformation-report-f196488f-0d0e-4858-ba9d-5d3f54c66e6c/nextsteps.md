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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Windows-Specific Dependencies

Review the project's NuGet package references and any direct code usage for APIs that are Windows-only, such as:

- `System.Drawing.Common` (requires additional configuration on Linux/macOS)
- `Microsoft.Win32` namespaces
- COM interop or P/Invoke calls targeting Windows libraries

Use the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) to identify any remaining platform-specific code.

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm baseline functionality is intact.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 7. Review Configuration Files

- Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and correctly structured.
- If the legacy project used `Web.config` or `App.config`, verify that the relevant settings have been migrated to `appsettings.json` or the appropriate .NET configuration system.
- Check connection strings and ensure they are valid for the target environment.

### 8. Verify Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly at runtime.

### 9. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any remaining platform-specific issues.