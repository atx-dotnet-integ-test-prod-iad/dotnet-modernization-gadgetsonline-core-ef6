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

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as it did in the legacy version.

### 5. Execute Existing Tests

If the solution contains any test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results for any failures that may indicate regressions introduced during the transformation.

### 6. Check for Windows-Specific APIs

Even when a project builds successfully, it may still contain APIs that are Windows-specific and will fail at runtime on other platforms. Use the .NET Compatibility Analyzer or review the code manually for usages such as:

- `Microsoft.Win32` namespace references
- `System.Windows.Forms` or `System.Drawing` (non-cross-platform versions)
- Registry access
- Windows-specific file path assumptions (e.g., backslashes, drive letters)

Run the following command to surface platform compatibility warnings:

```bash
dotnet build --configuration Release /p:EnableNETAnalyzers=true
```

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `web.config` (if applicable), and any static assets are present and correctly referenced. In cross-platform .NET, `web.config` is largely replaced by `appsettings.json` and middleware configuration in `Program.cs` or `Startup.cs`.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is compatible with the target framework version.

Run any pending migrations if Entity Framework Core is in use:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any runtime issues that are not caught at compile time.