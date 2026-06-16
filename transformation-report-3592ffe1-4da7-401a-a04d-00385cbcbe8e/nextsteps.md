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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Windows-Specific APIs

Search the codebase for any usage of Windows-specific APIs that may not be available on Linux or macOS. Common areas to check include:

- `Microsoft.Win32` namespace usage
- Registry access
- Windows-specific file path assumptions (e.g., backslash separators)
- `System.Drawing` (GDI+) usage, which requires additional native dependencies on non-Windows platforms

Use the .NET Compatibility Analyzer or review the output of:

```bash
dotnet build /p:EnableNETAnalyzers=true
```

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` (or equivalent configuration files) are present and correctly configured for the target environment.
- Verify that any static files, views, or resources are included in the project and copied to the output directory as expected.

### 8. Publish the Application

Once validation is complete, publish the application for the target platform:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.