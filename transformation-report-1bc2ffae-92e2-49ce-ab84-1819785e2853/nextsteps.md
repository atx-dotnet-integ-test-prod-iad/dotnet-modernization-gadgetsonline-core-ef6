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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary features to confirm they behave as expected.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate functional correctness:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Windows-Specific APIs

Search the codebase for any usage of Windows-specific APIs that may not be available on Linux or macOS. Common areas to check include:

- `Microsoft.Win32` namespace usage
- Registry access
- Windows-specific file path assumptions (e.g., hardcoded backslashes)
- `System.Drawing` (GDI+), which has limited cross-platform support and may require replacement with a library such as `SkiaSharp` or `ImageSharp`

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` (or equivalent configuration files) are present and correctly configured for the target environment.
- Verify that any static web assets are included in the project output.

### 8. Publish the Application

Once local validation is complete, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.