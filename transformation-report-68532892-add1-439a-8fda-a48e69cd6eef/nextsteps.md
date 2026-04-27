# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime version installed on your target environment.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as it did in the legacy project.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate existing behavior:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Windows-Specific API Usage

Even without build errors, the code may reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET compatibility analyzer or search the codebase for common problematic namespaces such as:

- `Microsoft.Win32`
- `System.Windows.Forms`
- `System.Drawing` (without the cross-platform NuGet package)
- `System.Web` (legacy ASP.NET, not ASP.NET Core)

Address any findings by replacing them with cross-platform equivalents.

### 7. Validate Configuration Files

Check that configuration files such as `appsettings.json` are present and contain the correct values. Legacy projects often relied on `Web.config` or `App.config`, which may not be fully carried over. Ensure connection strings, application settings, and environment-specific values are correctly migrated.

### 8. Test on Target Platform

If the goal is to run on a non-Windows operating system, deploy and run the application on that platform to catch any runtime issues that static analysis may not surface:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Transfer the published output to the target machine and run it to verify behavior.

### 9. Review Publish Output

Inspect the published output to confirm all required static assets, views, and configuration files are included. If any files are missing, update the `.csproj` to include them explicitly using `<Content>` or `<None>` items with `CopyToPublishDirectory` set appropriately.