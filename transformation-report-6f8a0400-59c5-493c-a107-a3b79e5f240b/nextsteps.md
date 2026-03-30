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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as the legacy version.

### 5. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET types
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (requires additional packages on non-Windows platforms)
- Entity Framework version compatibility if the project uses a database

### 6. Run Existing Tests

If the solution contains a test project, execute the tests to verify functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are caused by behavioral differences in the new runtime or pre-existing issues.

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` (or equivalent) contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are included correctly in the project and are accessible at runtime.

### 8. Test on Target Platforms

Since the goal is cross-platform support, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific runtime issues.