# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate framework-specific packages rather than legacy `System.Web` assemblies.

### 4. Check for Removed or Incompatible APIs

Search the codebase for any usage of APIs that were removed in cross-platform .NET, including:

- `System.Web.HttpContext` (replaced by `Microsoft.AspNetCore.Http.HttpContext`)
- `System.Web.SessionState`
- `ConfigurationManager` (requires the `System.Configuration.ConfigurationManager` NuGet package if still needed)
- `System.Drawing` (requires the `System.Drawing.Common` NuGet package on non-Windows platforms)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm runtime behavior matches expectations from the legacy version.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they represent genuine regressions or tests that require updating due to API or behavior changes in the new framework.

### 7. Validate Configuration Files

- Confirm that `Web.config` or `App.config` settings have been migrated to `appsettings.json` where applicable.
- Verify that connection strings, application settings, and environment-specific values are correctly represented in the new configuration system.
- Ensure `Startup.cs` or the top-level `Program.cs` properly registers all required services and middleware.

### 8. Check Static Assets and Routing

If this is a web application, verify that:

- Static files (CSS, JavaScript, images) are served correctly.
- All routes resolve as expected and return correct HTTP status codes.
- Any bundling or minification previously handled by legacy tooling has been replaced with a suitable alternative.

### 9. Review Logging and Error Handling

Confirm that logging previously configured through legacy mechanisms (e.g., `log4net`, `NLog` with older adapters) has been updated to integrate with `Microsoft.Extensions.Logging` or the chosen logging provider.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is self-contained and deployable:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.