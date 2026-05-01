# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation

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

Address any warnings that surface, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this matches the .NET SDK version installed on your machine by running:

```bash
dotnet --version
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 5. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed behavior or been removed in cross-platform .NET. Key areas to check include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which may have changed namespaces or signatures
- Configuration APIs (`ConfigurationManager`), which require the `System.Configuration.ConfigurationManager` NuGet package
- Any Windows-specific APIs (registry access, WCF server-side, etc.) that may not function on non-Windows platforms

### 6. Run the Application Locally

Start the application and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the primary workflows of the application and confirm expected behavior.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`.
- Verify that any static files, views, or content files are included in the project and are being served correctly.

### 8. Publish the Application

Once validation is complete, publish the application to a target folder:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.