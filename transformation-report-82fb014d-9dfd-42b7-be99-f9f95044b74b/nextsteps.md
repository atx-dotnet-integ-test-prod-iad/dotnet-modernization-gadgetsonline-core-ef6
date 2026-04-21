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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to check for any runtime errors that would not be caught at compile time.

### 5. Check for Runtime Compatibility Issues

Pay attention to the following areas that commonly surface at runtime after a cross-platform migration:

- **File path separators**: Ensure no hardcoded backslashes (`\`) are used in file path logic. Use `Path.Combine` or `Path.DirectorySeparatorChar` instead.
- **Windows-specific APIs**: Check for any calls to Windows registry, COM interop, or other platform-specific APIs that may throw `PlatformNotSupportedException` on non-Windows systems.
- **Configuration**: Verify that `appsettings.json` or equivalent configuration files are present and correctly structured, replacing any legacy `Web.config` or `App.config` values that may not have been migrated.
- **Entity Framework or data access**: If the project uses a database ORM, confirm the connection strings are valid and run any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 6. Execute Existing Tests

If a test project exists in the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral differences introduced by the migration.

### 7. Review Removed or Changed APIs

Cross-platform .NET removes or modifies certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to scan for any suppressed warnings or compatibility shims that may need to be addressed before the application is considered fully modernized.

### 8. Deploy to Target Environment

Once local validation is complete, publish the application using the appropriate runtime identifier for your target platform:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Adjust the `--runtime` flag to match your deployment target (e.g., `win-x64`, `osx-x64`). Copy the output from the `publish` folder to the target server and verify the application starts and responds correctly in that environment.