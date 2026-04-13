# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that all pages, routes, and features behave as expected compared to the legacy version.

### 5. Check for Runtime Errors

After starting the application, review the console output and application logs for any runtime exceptions or warnings that would not have been caught at compile time. Pay particular attention to:

- Database connection strings and Entity Framework migrations
- Authentication and session configuration
- Static file serving
- Any third-party integrations or external service calls

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 7. Verify Configuration Files

Check that `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) contain the correct configuration values, as legacy `Web.config` or `App.config` entries may not have been fully migrated automatically.

### 8. Check for Removed or Changed APIs

Review the code for any usages of APIs that behave differently in cross-platform .NET compared to .NET Framework. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry or certain cryptography providers
- `HttpContext` and related middleware patterns

### 9. Test on Target Platform

If the intent is to run the application on a non-Windows operating system, test the application explicitly on that platform to surface any remaining platform-specific issues.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy the output to your target environment according to your hosting setup (e.g., IIS, Kestrel, or a reverse proxy configuration).