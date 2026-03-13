# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework is outdated (e.g., `net6.0`), consider updating it to the latest supported LTS release.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application locally to confirm it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows to check for any runtime exceptions or unexpected behavior.

### 6. Review Removed or Replaced APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Manually review the following areas for potential runtime issues that would not surface as build errors:

- **`System.Web` dependencies**: Any remaining references or usage patterns that were shimmed during transformation should be tested thoroughly.
- **Windows-specific APIs**: Features such as the Windows Registry, WCF server-side components, or Windows Authentication may require additional configuration or replacement.
- **Configuration system**: Ensure the application has been migrated from `Web.config`/`App.config` to `appsettings.json` and that all configuration values are correctly read at runtime.
- **Static file handling and routing**: If this is a web application, verify that routes, middleware, and static file serving behave correctly under the new ASP.NET Core pipeline.

### 7. Check Application Logs

After running the application, review the output logs for any warnings or errors that indicate misconfigured services, missing middleware registrations, or unhandled exceptions.

### 8. Deployment

Once the application has been validated locally, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target hosting environment and configure the web server (e.g., IIS, Nginx, or Kestrel as a standalone server) to serve the application according to the [official Microsoft deployment documentation](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/).