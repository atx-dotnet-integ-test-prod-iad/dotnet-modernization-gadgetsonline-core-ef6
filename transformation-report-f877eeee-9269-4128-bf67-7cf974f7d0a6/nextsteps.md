# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it references `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying particular attention to any features that relied on Windows-specific APIs in the legacy project.

### 5. Execute Unit Tests

If the solution contains test projects, run them to validate business logic and application behavior:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Incompatible APIs

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to identify any APIs that may have been silently replaced or stubbed during transformation:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

Review the generated report for any items that require manual remediation.

### 7. Validate Data Access Layer

If the project uses Entity Framework, confirm the version being referenced is compatible with the target framework (Entity Framework Core rather than EF 6 for full cross-platform support). Run any pending migrations and verify database connectivity:

```bash
dotnet ef database update
```

### 8. Test on Target Platforms

Since the goal is cross-platform support, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear at compile time.

### 9. Review Static Files and Configuration

Confirm that `appsettings.json`, connection strings, and any static web assets have been carried over correctly from the legacy project. Verify that configuration values are being read properly at runtime using the `IConfiguration` abstraction.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all expected files are present before deploying to the target environment.