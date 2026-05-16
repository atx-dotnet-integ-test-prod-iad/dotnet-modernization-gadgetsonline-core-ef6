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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the restore and build steps.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality behaves as it did in the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures.

### 6. Check for Windows-Specific Dependencies

Even without build errors, the project may still reference Windows-specific APIs or libraries that will fail at runtime on non-Windows platforms. Review the code and project references for any of the following:

- `System.Web` references or types (e.g., `HttpContext`, `HttpServerUtility`)
- Windows Registry access (`Microsoft.Win32.Registry`)
- COM interop or P/Invoke calls targeting Windows-only DLLs
- Any NuGet packages that have platform restrictions

Replace or abstract any such dependencies with cross-platform equivalents where necessary.

### 7. Review Configuration Files

Ensure that configuration files have been migrated correctly:

- Confirm that `Web.config` or `App.config` settings have been moved to `appsettings.json` or environment variables as appropriate.
- Verify connection strings, application settings, and any custom configuration sections are present and correctly formatted.

### 8. Validate Static Assets and Views

If this is a web project, manually verify that:

- Static files (CSS, JavaScript, images) are served correctly.
- Razor views or other view templates render without errors.
- Routing behaves as expected for all major endpoints.

### 9. Publish the Application

Once the above steps are completed satisfactorily, publish the application to a local folder to verify the published output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present, then deploy the contents to your target environment.