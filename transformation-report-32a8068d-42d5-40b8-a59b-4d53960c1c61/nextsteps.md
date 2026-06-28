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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or another .NET Framework moniker, update it accordingly.

### 4. Check for Windows-Specific Dependencies

Inspect the project's NuGet references and code for any APIs or packages that are Windows-only. Common areas to check include:

- `System.Web` usage (not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- WCF server-side components
- Any package that has not been updated to support .NET 6/7/8

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify these.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify runtime behavior has not changed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between .NET Framework and cross-platform .NET.

### 6. Verify Application Startup

Run the application locally and confirm it starts without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Check the console output and application logs for any runtime errors, particularly around:

- Middleware configuration
- Database connectivity and Entity Framework migrations
- Static file serving
- Authentication and authorization setup

### 7. Test Core Functionality

Manually exercise the primary features of the application, such as:

- Product browsing and search
- Shopping cart operations
- Checkout and order processing
- User authentication and account management

Compare behavior against the legacy application to confirm functional parity.

### 8. Review Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) contain all configuration values that were previously held in `web.config` or `app.config`. Pay particular attention to:

- Connection strings
- Application-specific settings
- Logging configuration

### 9. Database Migrations

If Entity Framework Core is in use, verify that all migrations are up to date and apply them against the target database:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

If the project migrated from Entity Framework 6, confirm that the migration to EF Core was completed and that the model matches the existing schema.