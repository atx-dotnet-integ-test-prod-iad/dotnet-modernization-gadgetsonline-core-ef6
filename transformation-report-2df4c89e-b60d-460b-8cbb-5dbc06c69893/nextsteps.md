# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`.

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended runtime environment, update it accordingly and re-run the build.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- `System.Web` usages, which are not available in cross-platform .NET.
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (GDI+).
- Any third-party packages that may have been targeting .NET Framework only.

Run the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tool to surface any such issues.

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior is consistent with expectations.

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime.

### 6. Run the Application Locally

Start the application and exercise its primary functionality manually.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

If this is a web application, navigate through the key pages and workflows to confirm expected behavior. Check application logs for any runtime exceptions.

### 7. Verify Configuration Files

Ensure that configuration files have been correctly migrated. In cross-platform .NET, `Web.config` is replaced by `appsettings.json` for most application settings. Confirm that:

- Connection strings are present and correct in `appsettings.json`.
- Any environment-specific configuration is handled via `appsettings.{Environment}.json` or environment variables.
- `Web.config` transforms, if any existed, have been accounted for.

### 8. Validate Static Assets and Views

If this is a web project, confirm that all static assets (CSS, JavaScript, images) are served correctly and that all views render without errors.

### 9. Cross-Platform Verification

If one of the goals of this migration is to run on non-Windows operating systems, test the application on the target OS (Linux or macOS) to identify any remaining platform-specific dependencies.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay attention to file path separators, case-sensitive file systems, and any P/Invoke or native library dependencies.

### 10. Review Published Output

Publish the application and verify the output before deploying to any environment.

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present, including configuration files and static assets.