# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The `GadgetsOnline/GadgetsOnline.csproj` project compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Run a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-fatal, may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Run the Test Suite

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework runtime and the new cross-platform .NET runtime.

### 4. Check for Runtime Compatibility Issues

Even with a clean build, certain APIs behave differently on cross-platform .NET. Review the following areas manually:

- **File system paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) exist in configuration files or code.
- **Registry access**: `Microsoft.Win32.Registry` is not supported on Linux/macOS. Remove or conditionally compile any registry-dependent code.
- **Windows-specific APIs**: Use the [.NET Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) to identify any remaining platform-specific API calls.
- **Configuration**: Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable.

### 5. Verify Entity Framework or Data Access Layer

If the project uses Entity Framework or another ORM, confirm the correct version is referenced:

- EF6 has limited cross-platform support. Consider migrating to EF Core if full cross-platform compatibility is required.
- Run any pending migrations and verify the database schema is intact:

```bash
dotnet ef database update
```

### 6. Run the Application Locally

Start the application and manually exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that:
- The application starts without exceptions.
- Core pages and features load correctly.
- Any authentication or session management behaves as expected.
- Static assets (CSS, JavaScript, images) are served correctly.

### 7. Review Publish Output

Publish the application to a local folder and inspect the output before deploying to any environment:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Confirm that all expected files, including configuration files and static assets, are present in the output directory.

### 8. Target Framework Confirmation

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and desired, update this value, then re-run restore and build to confirm compatibility.