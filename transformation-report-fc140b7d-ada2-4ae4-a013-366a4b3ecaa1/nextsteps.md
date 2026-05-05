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

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform target, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only framework such as `net48`, the migration to cross-platform .NET is not yet complete.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review the test output for any failures or skipped tests that may indicate compatibility issues introduced during the migration.

### 6. Check for Runtime-Only Issues

Some issues do not surface at build time but appear at runtime. Pay particular attention to:

- **Configuration**: Verify that `appsettings.json` or equivalent configuration files are present and correctly structured, replacing any legacy `Web.config` or `App.config` entries where applicable.
- **Static files and wwwroot**: Confirm that static assets are located under `wwwroot` and are being served correctly.
- **Database connections**: If the project uses Entity Framework or ADO.NET, verify connection strings and run any pending migrations:
  ```bash
  dotnet ef database update
  ```
- **Windows-specific APIs**: Search the codebase for any usage of APIs that are Windows-only (e.g., `System.Web`, registry access, COM interop) and confirm they either have cross-platform alternatives or are conditionally compiled.

### 7. Publish the Application

Once the application has been validated locally, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.