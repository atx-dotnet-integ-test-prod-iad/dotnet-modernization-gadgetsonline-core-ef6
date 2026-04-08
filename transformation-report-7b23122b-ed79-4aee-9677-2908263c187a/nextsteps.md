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

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Check for Windows-Specific Dependencies

Review the project's NuGet package references and code for any APIs or packages that are Windows-specific (e.g., `System.Drawing.Common`, `Microsoft.Win32`, registry access). These will compile but may fail at runtime on non-Windows platforms.

Use the compatibility analyzer by adding the following to the `.csproj` if not already present:

```xml
<EnableNETAnalyzers>true</EnableNETAnalyzers>
<AnalysisMode>All</AnalysisMode>
```

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm core functionality is intact.

### 6. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Configuration Files

- Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and correctly configured.
- If the project previously used `Web.config` or `App.config`, verify that relevant settings have been migrated to `appsettings.json` or the appropriate .NET configuration system.
- Check that connection strings and any environment-specific values are correct.

### 8. Verify Static Files and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`, particularly if the project was migrated from ASP.NET (System.Web) to ASP.NET Core.

### 9. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear during compilation.

### 10. Review Removed or Changed APIs

Consult the [.NET Upgrade Assistant migration documentation](https://learn.microsoft.com/en-us/dotnet/core/porting/) and the [breaking changes reference](https://learn.microsoft.com/en-us/dotnet/core/compatibility/breaking-changes) to identify any APIs used in the project that have been removed or have changed behavior in the target .NET version.