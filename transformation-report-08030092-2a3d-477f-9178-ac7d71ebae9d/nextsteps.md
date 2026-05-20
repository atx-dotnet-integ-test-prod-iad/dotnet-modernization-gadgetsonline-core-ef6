# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-specific framework such as `net48` or `net472`, update it accordingly.

### 4. Check for Windows-Specific Dependencies

Inspect the project's NuGet package references and code for any APIs or libraries that are Windows-only. Common areas to check include:

- `System.Web` namespace usage, which is not available in cross-platform .NET
- Windows Registry access via `Microsoft.Win32`
- Any packages that have not been updated to support cross-platform .NET

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify platform-specific calls.

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failures before proceeding.

### 6. Run the Application Locally

Start the application locally to confirm it runs as expected on the target platform:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's primary workflows and verify that core functionality behaves correctly.

### 7. Review Configuration Files

Check `appsettings.json` or any other configuration files to ensure that:

- Connection strings are valid and updated for the new environment
- Any file paths use platform-agnostic separators (`/` or `Path.Combine`)
- Environment-specific settings are correctly separated using `appsettings.Development.json` and `appsettings.Production.json`

### 8. Publish the Application

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.