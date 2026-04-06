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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only framework such as `net48`.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm runtime behavior matches the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that business logic has been preserved:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Windows-Specific API Usage

Even without build errors, the code may reference APIs that compile successfully but fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer or review the code manually for usages such as:

- `System.Windows.Forms`
- `Microsoft.Win32` registry access
- Windows-specific file path assumptions (e.g., backslash separators)
- Platform-specific interop (`DllImport` with Windows DLLs)

Run the following to surface platform compatibility warnings:

```bash
dotnet build /p:EnableNETAnalyzers=true
```

### 7. Verify Static Assets and Configuration

If this is a web application, confirm the following:

- `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder
- Connection strings and environment-specific settings are correctly migrated

### 8. Test on Target Platform

If cross-platform support is a goal, run and test the application on the intended non-Windows operating system (e.g., Linux or macOS) to surface any runtime-only platform issues that static analysis may not catch.

### 9. Review Deprecated NuGet Packages

Check for any packages that have known incompatibilities with modern .NET. Pay particular attention to packages that were originally designed for .NET Framework and may have only partial support under .NET 5+.

```bash
dotnet list package --outdated
```

Update packages where appropriate and re-run the build and tests after each update.