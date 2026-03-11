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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider upgrading to the latest supported LTS release.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to check for any runtime errors that would not have been caught at compile time.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and application behavior:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Some APIs available in .NET Framework are not present or have changed in cross-platform .NET. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in modern .NET. Ensure any usages have been replaced with `Microsoft.AspNetCore` equivalents.
- **`HttpContext` and related types**: Confirm these are sourced from `Microsoft.AspNetCore.Http`.
- **Configuration**: Verify that `web.config`-based configuration has been migrated to `appsettings.json` and the `Microsoft.Extensions.Configuration` system.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated from EF6 to EF Core and that database migrations are functioning correctly.

### 7. Verify Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, which is the expected location for static files in ASP.NET Core.

### 8. Test on Target Platforms

Since the goal of the migration is cross-platform support, run and validate the application on each intended target operating system (e.g., Windows, Linux, macOS) to confirm there are no platform-specific runtime issues.

### 9. Publish the Application

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.