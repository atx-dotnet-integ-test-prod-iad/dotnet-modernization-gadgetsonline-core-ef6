# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages, deprecated package versions, or target framework incompatibilities.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate and supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Check the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the following command:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that all pages, routes, and features behave as expected compared to the original legacy version.

### 5. Check for Runtime Errors

Pay close attention to the following areas at runtime, as these are common sources of issues after a cross-platform migration:

- **File paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) exist in configuration or code. Replace with `Path.Combine` or relative paths.
- **Database connections**: Verify that connection strings in `appsettings.json` or `web.config` are valid and accessible from the new runtime environment.
- **Authentication and session handling**: Confirm that any authentication middleware has been correctly migrated to the ASP.NET Core equivalents.
- **Static files**: Ensure static assets are being served correctly and that `wwwroot` is structured as expected.

### 6. Execute Unit and Integration Tests

If a test project exists in the solution, run all tests to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and address them individually, as they may surface runtime or logic issues not caught at compile time.

### 7. Review Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Review the code for usage of any of the following, which commonly require attention after migration:

- `System.Web` namespaces — these should be replaced with ASP.NET Core equivalents.
- `HttpContext.Current` — replace with injected `IHttpContextAccessor`.
- `ConfigurationManager` — replace with `IConfiguration` from `Microsoft.Extensions.Configuration`.
- `Global.asax` — replace with `Program.cs` and `Startup.cs` (or the minimal hosting model).

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) if a more thorough API audit is needed.

### 8. Validate Configuration Files

Ensure that `appsettings.json` contains all necessary configuration values that were previously in `web.config` or `app.config`. Confirm environment-specific settings are handled using `appsettings.Development.json` or environment variables where appropriate.

### 9. Test on the Target Platform

If the intended deployment platform is Linux or macOS, run and test the application on that operating system specifically, as some issues only surface outside of Windows due to case-sensitive file systems or platform-specific dependencies.