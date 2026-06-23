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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest supported LTS release.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to confirm it behaves as expected.

### 6. Review Replaced or Removed APIs

Check the codebase for any usage of APIs that were commonly removed or changed in the migration from .NET Framework to cross-platform .NET, including:

- `System.Web` namespaces (e.g., `HttpContext`, `HttpRequest`) — these should have been replaced with `Microsoft.AspNetCore.Http` equivalents.
- `ConfigurationManager` — should be replaced with `Microsoft.Extensions.Configuration`.
- `BinaryFormatter` — removed in modern .NET; replace with a supported serialization mechanism if used.
- Windows-only APIs — verify these are either removed, replaced, or conditionally compiled if cross-platform support is required.

### 7. Review Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable. Confirm that connection strings, application settings, and environment-specific values are correctly represented.

### 8. Verify Static Files and Middleware

If this is an ASP.NET Core web application, confirm that the `Program.cs` or `Startup.cs` file correctly configures middleware, static file serving, routing, and authentication in the order expected by ASP.NET Core.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it operates correctly outside of the development environment:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Verify that the application starts without errors and responds as expected.