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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure no legacy `<TargetFrameworkVersion>` elements remain from the original project format.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to verify that runtime behavior matches the original legacy version.

### 5. Review Static Files and Configuration

- Confirm that `appsettings.json` (and `appsettings.Development.json`) are present and contain the correct configuration values that were previously in `Web.config` or `App.config`.
- Verify that any connection strings, application settings, and environment-specific values have been correctly migrated.
- Check that static files (CSS, JavaScript, images) are located under `wwwroot` if this is a web project.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but behave differently in cross-platform .NET, including:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` usage patterns
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (GDI+)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool to surface any remaining compatibility issues.

### 7. Execute Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review test results and address any failures that may indicate behavioral differences between .NET Framework and the new target framework.

### 8. Verify Database Connectivity

If the application uses Entity Framework or direct database access, confirm that:

- The correct EF Core packages are referenced (not EF 6 targeting .NET Framework).
- Migrations are up to date by running:

```bash
dotnet ef database update
```

- Connection strings point to the correct database instances for the target environment.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files, assemblies, and assets are present before deploying to the target environment.