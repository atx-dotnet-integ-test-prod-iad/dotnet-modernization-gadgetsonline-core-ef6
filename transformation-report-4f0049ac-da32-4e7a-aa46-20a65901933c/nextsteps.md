# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are properly restored.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Confirm that the build completes with `0 Error(s)`.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the target framework is set to a supported cross-platform version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Check for Removed or Replaced APIs

Even without build errors, some APIs that existed in the legacy .NET Framework may behave differently or have been replaced in cross-platform .NET. Areas to review include:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If the project is a web application, confirm it has been migrated to ASP.NET Core equivalents.
- **Configuration**: Ensure `System.Configuration.ConfigurationManager` usage has been replaced with `Microsoft.Extensions.Configuration` where appropriate.
- **Database access**: Verify any Entity Framework usage has been updated to Entity Framework Core.
- **HTTP clients**: Confirm `HttpClient` is used in place of `WebClient` or `HttpWebRequest` where applicable.

### 5. Run the Application Locally

Start the application and verify it runs without runtime exceptions.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows and confirm expected behavior.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness.

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences introduced during migration.

### 7. Review Runtime Behavior for Platform-Specific Code

Check for any code paths that may have relied on Windows-specific behavior, such as:

- File path separators (use `Path.Combine` rather than hardcoded `\`)
- Windows Registry access
- Windows-specific authentication mechanisms
- COM interop

Replace or conditionally compile any such code to ensure cross-platform compatibility.

### 8. Validate Static Assets and Configuration Files

If this is a web application, confirm that:

- `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`
- Static files are served correctly under `wwwroot`
- Connection strings are properly defined and accessible at runtime

### 9. Publish the Application

Once local validation is complete, publish the application for deployment.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.