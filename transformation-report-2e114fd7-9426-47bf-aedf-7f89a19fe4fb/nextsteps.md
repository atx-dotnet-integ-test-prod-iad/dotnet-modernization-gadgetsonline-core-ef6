# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing or incompatible packages. If any packages are flagged as incompatible with the new target framework, locate them in the relevant `.csproj` file and search [NuGet.org](https://www.nuget.org) for a compatible version.

### 2. Build the Solution

Perform a full solution build to confirm there are no residual issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to an appropriate and supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET Support Policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to confirm the selected framework version is still under active support.

### 4. Run the Application Locally

Start the application locally to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Check for Removed or Changed APIs

Legacy .NET Framework projects often rely on APIs that have been removed or significantly changed in cross-platform .NET. Manually review the codebase for usage of the following common problem areas:

- `System.Web` namespace (not available in .NET Core/5+)
- `HttpContext` usage outside of dependency injection
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `BinaryFormatter` (removed in .NET 9, deprecated earlier)
- Windows-only APIs such as the registry or certain `System.Drawing` features

### 6. Verify Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. In cross-platform .NET, `appsettings.json` is the standard configuration mechanism:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string"
  }
}
```

Confirm that the application reads configuration correctly at runtime.

### 7. Test Data Access

If the project uses Entity Framework or another ORM, verify the following:

- Migrations are up to date by running:

```bash
dotnet ef migrations list
```

- The database schema matches expectations by running:

```bash
dotnet ef database update
```

- Basic CRUD operations function correctly against the target database.

### 8. Execute Existing Tests

If a test project exists in the solution, run all tests to confirm no regressions have been introduced:

```bash
dotnet test
```

Review the test results and investigate any failures. Pay particular attention to integration tests that may depend on infrastructure or configuration that has changed during migration.

### 9. Deployment

Once the above steps are completed and the application is stable:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

Replace `win-x64` with the appropriate runtime identifier (e.g., `linux-x64`, `osx-x64`) based on your deployment target.

2. Copy the contents of the `publish` output directory to your hosting environment.

3. Verify the application starts and operates correctly in the target environment before directing any traffic to it.