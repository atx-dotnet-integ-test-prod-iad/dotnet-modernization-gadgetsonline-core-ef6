# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running the project, ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about missing or incompatible packages. Pay attention to any packages that may have been replaced with compatibility shims during the transformation, as these may need to be updated to their modern equivalents.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm the build output reports zero errors and review any warnings, as some warnings may indicate deprecated APIs or patterns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Avoid using end-of-life versions such as `net5.0` or `net6.0` if possible.

### 4. Check for Windows-Specific Dependencies

Since this was a legacy project, verify that no remaining dependencies rely on Windows-only APIs (e.g., `System.Web`, `Microsoft.Web.Infrastructure`, or the full `System.Drawing`). Search the project file and source code for these references:

```bash
grep -r "System.Web" ./GadgetsOnline
```

Replace or remove any Windows-specific dependencies with their cross-platform equivalents where applicable.

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm that behavior matches the original legacy project.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review test results and investigate any failures, as these may point to behavioral differences introduced during the migration.

### 7. Review Configuration Files

Legacy projects often rely on `Web.config` or `App.config`. Confirm that configuration has been properly migrated to `appsettings.json` and that all connection strings, application settings, and environment-specific values are present and correct.

### 8. Validate Database Connectivity

If the application uses a database, confirm that connection strings in `appsettings.json` are correct and that the application can connect and perform operations as expected. If Entity Framework is in use, verify that any pending migrations are applied:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.