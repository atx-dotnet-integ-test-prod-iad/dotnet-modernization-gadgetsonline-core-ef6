# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-breaking, may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected after the transformation:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework runtime and the new cross-platform .NET runtime.

### 4. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and currently supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET release schedule](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure the targeted version is not end-of-life.

### 5. Check for Runtime-Specific Behavior

Some APIs behave differently on cross-platform .NET compared to .NET Framework, even when they compile without errors. Pay particular attention to:

- **File system paths**: Ensure no hardcoded Windows-style paths (e.g., backslashes) exist in the codebase.
- **Registry access**: `Microsoft.Win32.Registry` is not available on Linux/macOS.
- **Windows-specific APIs**: Any P/Invoke calls or APIs under `System.Windows` namespaces may not function on non-Windows platforms.
- **Configuration**: Verify that `Web.config` or `App.config` based configuration has been migrated to `appsettings.json` or equivalent if applicable.

### 6. Run the Application Locally

Start the application using the .NET CLI and exercise the primary workflows manually:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Confirm that all major features, routes, and data access operations function as expected.

### 7. Review NuGet Package Compatibility

Inspect the `.csproj` file for any NuGet packages that may have been carried over from the legacy project. Verify each package supports the new target framework. Packages that previously relied on .NET Framework-specific implementations may require upgrading to newer versions or replacing with supported alternatives.

```bash
dotnet list package --outdated
```

### 8. Address Any Compiler Warnings

While the build has no errors, review compiler warnings produced during the build step. Warnings related to nullable reference types, obsolete APIs, or platform compatibility attributes should be assessed and resolved where practical.