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

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues in the relevant `.csproj` file(s).

### 2. Build the Solution

Perform a full build to confirm there are no compile-time errors:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest Long-Term Support (LTS) release.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify runtime behavior has not been affected by the migration:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are caused by migration-related changes or pre-existing issues.

### 5. Verify Runtime Behavior

Launch the application locally and manually exercise the core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and any Entity Framework migrations if applicable
- Authentication and session handling
- Any file system paths that may have been hardcoded for Windows

### 6. Check for Windows-Specific API Usage

Search the codebase for APIs that may not behave consistently across platforms, including:

- `System.Windows` namespaces
- `Microsoft.Win32` registry access
- Hardcoded Windows-style file paths using backslashes (`\`)
- `Path.DirectorySeparatorChar` assumptions

Replace any such usages with cross-platform equivalents where necessary.

### 7. Review Configuration Files

Ensure that `appsettings.json` (and any environment-specific variants such as `appsettings.Production.json`) are present and correctly configured. Confirm that any settings previously stored in `Web.config` or `App.config` have been properly migrated.

### 8. Deployment

Once all validation steps pass, publish the application using the following command, targeting your intended runtime:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Adjust the `--runtime` flag to match your target deployment environment (e.g., `win-x64`, `linux-x64`, `osx-x64`). Review the output directory to confirm all required files are present before deploying to the target environment.