# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly:

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

If the project is a web application, ensure it targets `net8.0` or another actively supported .NET version rather than a legacy `net4x` framework moniker.

### 4. Run the Application Locally

Start the application to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to check for runtime exceptions or unexpected behavior that would not surface at compile time.

### 5. Check for Removed or Changed APIs

Even with a clean build, certain APIs behave differently or have been removed in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- `System.Web` dependencies, which are not available in .NET Core or later. Any code relying on `HttpContext`, `HttpRequest`, or similar types from `System.Web` must be migrated to `Microsoft.AspNetCore.Http` equivalents.
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (GDI+). These may require replacement packages such as `System.Drawing.Common` or alternative libraries.
- Entity Framework: if the project used Entity Framework 6, confirm whether it has been migrated to Entity Framework Core and that database queries function correctly.

### 6. Run Existing Tests

If the solution contains a test project, execute the test suite to verify functional correctness:

```bash
dotnet test
```

Review failing tests carefully, as they may indicate runtime behavioral differences between .NET Framework and modern .NET.

### 7. Verify Static Assets and Configuration

For web projects, confirm the following:

- `web.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable.
- Connection strings are present and correct in the new configuration files.
- Middleware previously configured via `web.config` (such as URL rewriting or authentication modules) has been re-implemented using ASP.NET Core middleware in `Program.cs` or `Startup.cs`.

### 8. Test Against a Real Database

If the application connects to a database, run integration-level tests or manual verification against a real database instance to confirm that:

- Migrations apply correctly.
- Queries return expected results.
- No data access layer exceptions occur at runtime.

### 9. Publish the Application

Once local validation is complete, produce a published output to verify the deployment artifact builds correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.