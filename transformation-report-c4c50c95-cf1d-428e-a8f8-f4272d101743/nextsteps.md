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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure the chosen framework version is still within Microsoft's support lifecycle.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to verify runtime behavior matches expectations from the legacy version.

### 5. Execute Existing Tests

If a test project exists in the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that need to be updated to reflect new cross-platform behavior.

### 6. Check for Windows-Specific Dependencies

Review the codebase for any remaining usage of Windows-specific APIs that may not behave correctly on Linux or macOS, including:

- `Microsoft.Win32` namespace references
- Registry access
- Windows file path assumptions (e.g., backslash separators)
- `System.Drawing` (GDI+) usage, which requires additional native dependencies on non-Windows platforms

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) contain correct values for the target environment.
- Verify that any static files, bundled assets, or wwwroot content are present and correctly referenced.

### 8. Publish the Application

Once the above steps are validated, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.