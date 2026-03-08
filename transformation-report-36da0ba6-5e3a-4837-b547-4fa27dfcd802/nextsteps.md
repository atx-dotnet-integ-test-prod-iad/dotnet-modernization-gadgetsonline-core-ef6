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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's intended runtime target.

### 4. Run the Application Locally

Start the application using the .NET CLI to confirm it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and verify that behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Windows-Specific APIs

Search the codebase for any usage of Windows-specific APIs that may not be available on Linux or macOS. Common areas to check include:

- `Microsoft.Win32` namespace usage
- Registry access
- Windows-specific file path assumptions (e.g., backslashes, drive letters)
- `System.Drawing` (GDI+) if used for image processing

Replace or abstract any such usages with cross-platform alternatives where necessary.

### 7. Verify Static Files and Configuration

Confirm that `appsettings.json`, static web assets, and any other content files are present and correctly referenced in the `.csproj` file with appropriate build actions such as `Content` or `EmbeddedResource`.

### 8. Test on a Non-Windows Platform

If cross-platform support is a requirement, run and test the application on a Linux or macOS environment to surface any platform-specific runtime issues that would not appear during a Windows build.

### 9. Review Deprecated NuGet Packages

Check for any NuGet packages that were used in the legacy project and may have been replaced or deprecated in modern .NET. Use the following command to inspect outdated packages:

```bash
dotnet list package --outdated
```

Update packages where appropriate, verifying compatibility with the target framework after each update.