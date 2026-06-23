# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas of the code that may behave differently on cross-platform .NET compared to .NET Framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the core functionality, paying attention to:

- Database connectivity and Entity Framework migrations (if applicable)
- Authentication and session handling
- Any file system operations that may use Windows-specific paths

### 5. Check for Windows-Specific APIs

Search the codebase for any remaining usage of Windows-specific APIs that may not have been caught during transformation. Common areas to check include:

- `System.Web` references (these are not available in cross-platform .NET)
- `Registry` access via `Microsoft.Win32`
- Windows-specific file path separators (use `Path.Combine` and `Path.DirectorySeparatorChar` instead)
- `HttpContext.Current` usage (replaced by dependency-injected `IHttpContextAccessor`)

### 6. Execute Unit Tests

If the solution contains test projects, run them to validate that existing logic behaves correctly:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are being served correctly by checking the `wwwroot` folder structure.
- Ensure connection strings have been correctly migrated to `appsettings.json`.

### 8. Test on a Non-Windows Environment (Optional but Recommended)

Since the goal is cross-platform compatibility, run the application on Linux or macOS if possible, to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Review Publish Output

Perform a publish to confirm the output is complete and self-contained:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files are present before deploying to the target environment.