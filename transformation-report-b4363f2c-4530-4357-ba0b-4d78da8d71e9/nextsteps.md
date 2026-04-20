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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review any failing tests and address regressions introduced during the migration.

### 5. Check for Removed or Changed APIs

Even without build errors, runtime behavior may differ due to APIs that changed between .NET Framework and modern .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available on cross-platform .NET. These should have been replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages to confirm they reference the ASP.NET Core versions.
- Any use of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- Entity Framework 6 vs. Entity Framework Core differences if the project uses a data access layer.

### 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows manually to identify any runtime errors or unexpected behavior that unit tests may not cover.

### 7. Review Application Configuration

Confirm that configuration files have been migrated correctly:

- `Web.config` settings should be moved to `appsettings.json` or environment variables.
- Connection strings should be present and valid in `appsettings.json`.
- Any transforms previously handled by `Web.Release.config` should be handled through environment-specific `appsettings.{Environment}.json` files.

### 8. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files, static assets, and configuration files are present before deploying to the target environment.