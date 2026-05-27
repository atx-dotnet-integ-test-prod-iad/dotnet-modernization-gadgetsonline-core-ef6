# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, certain APIs that existed in .NET Framework may have been silently replaced or may behave differently on cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should now reference `Microsoft.AspNetCore.Http`.
- Any Windows-specific APIs such as the registry, WMI, or Windows-only cryptography providers.
- `ConfigurationManager` should be replaced with `Microsoft.Extensions.Configuration`.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running application and verify that core functionality, routing, and pages behave as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to confirm existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression introduced during the migration or a pre-existing issue.

### 7. Review Database Connectivity

If the application uses a data access layer, verify the following:

- Connection strings in `appsettings.json` are correctly configured, as `web.config` connection strings are not used in cross-platform .NET by default.
- Entity Framework, if used, has been updated to Entity Framework Core and migrations are in a valid state. Run the following to verify:

```bash
dotnet ef database update
```

### 8. Static Files and Configuration

- Confirm that `wwwroot` contains all required static assets.
- Verify that `appsettings.json` and `appsettings.{Environment}.json` contain all configuration values previously held in `web.config` or `app.config`.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.