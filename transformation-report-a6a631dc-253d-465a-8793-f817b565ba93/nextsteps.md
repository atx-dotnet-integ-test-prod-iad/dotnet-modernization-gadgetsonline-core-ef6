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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as `net8.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are no longer supported.

### 4. Run Unit Tests

If the solution contains any test projects, execute them to verify that existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures before proceeding.

### 5. Verify Runtime Behavior

Run the application locally and manually exercise the primary workflows to confirm runtime behavior matches expectations from the legacy version:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and any Entity Framework migrations if applicable
- Authentication and authorization flows
- Any file system paths that may have been hardcoded for Windows and need to be made cross-platform using `Path.Combine`
- Any use of `Windows Registry`, `COM interop`, or other Windows-specific APIs that would not function on Linux or macOS

### 6. Check for Platform-Specific Code

Search the codebase for any remaining Windows-specific dependencies that may not surface as build errors but could cause runtime failures on non-Windows platforms:

- `Microsoft.Win32` namespace usage
- `System.Drawing` (GDI+) which requires additional native dependencies on Linux
- Hardcoded Windows-style file paths (e.g., `C:\`)
- P/Invoke calls to Windows native libraries

### 7. Review NuGet Package Compatibility

Verify that all referenced NuGet packages support the target framework. You can check compatibility on [nuget.org](https://www.nuget.org) or by reviewing the output of:

```bash
dotnet list package --outdated
```

Update any packages that have newer versions with improved cross-platform support.

### 8. Publish the Application

Once validation is complete, publish the application for the target runtime:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required assets and dependencies are present before deploying to the target environment.