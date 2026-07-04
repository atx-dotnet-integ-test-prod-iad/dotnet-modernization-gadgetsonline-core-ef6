# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to identify any usage of APIs that have been removed or altered between the legacy .NET Framework version and the current .NET version:

```bash
dotnet tool install -g dotnet-apicompat
```

Address any flagged incompatibilities in the source code.

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review test results and investigate any failures, as they may indicate behavioral differences between .NET Framework and modern .NET.

### 6. Verify Runtime Behavior

Run the application locally and exercise its core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to:
- Database connectivity and ORM behavior (e.g., Entity Framework query translation differences)
- Authentication and session management
- Any file system or path operations that may behave differently across platforms
- HTTP pipeline middleware if this is an ASP.NET Core project

### 7. Review `web.config` / `app.config` Migration

If the original project used `web.config` or `app.config`, confirm that all relevant configuration values have been migrated to `appsettings.json` or environment variables, as these are the standard configuration mechanisms in modern .NET.

### 8. Validate Static Assets and Views

If this is a web project, manually browse through the application to confirm that:
- Razor views render correctly
- Static files (CSS, JavaScript, images) are served properly
- Routing behaves as expected

### 9. Check Platform-Specific Code

Since this was a cross-platform migration, search the codebase for any remaining Windows-specific dependencies:

```bash
grep -rn "System.Web" ./GadgetsOnline
grep -rn "Registry" ./GadgetsOnline
grep -rn "System.Drawing" ./GadgetsOnline
```

Any matches should be reviewed and replaced with cross-platform alternatives where necessary.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.