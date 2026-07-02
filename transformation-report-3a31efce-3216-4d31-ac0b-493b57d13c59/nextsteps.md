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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to verify that runtime behavior matches the original legacy project.

### 5. Check for Windows-Specific Dependencies

Even without build errors, the project may contain runtime dependencies that are Windows-specific, such as:

- `System.Drawing.Common` (has platform restrictions on non-Windows)
- Windows Registry access
- COM interop components
- `Microsoft.Web.Infrastructure` or legacy `System.Web` references

Search the codebase for these usages and replace them with cross-platform alternatives where applicable.

### 6. Review Static Files and Web Assets

If `GadgetsOnline` is a web project, verify that static files (CSS, JavaScript, images) are correctly placed under the `wwwroot` folder and are being served as expected when the application runs.

### 7. Database and Connection Strings

Check `appsettings.json` (or `appsettings.Development.json`) to confirm that connection strings have been updated from any legacy `Web.config` entries. Run any Entity Framework migrations if applicable:

```bash
dotnet ef database update
```

### 8. Execute Tests

If a test project exists in the solution, run the test suite to validate core functionality:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the migration or pre-existing issues.

### 9. Review Configuration Migration

Confirm that all settings previously in `Web.config` or `App.config` have been properly migrated to `appsettings.json`. Pay particular attention to:

- Authentication settings
- Application-specific keys
- Logging configuration
- SMTP or external service configuration

### 10. Deployment

Once the above steps have been validated, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and deploy to the target environment according to your hosting setup (IIS, Kestrel, etc.).