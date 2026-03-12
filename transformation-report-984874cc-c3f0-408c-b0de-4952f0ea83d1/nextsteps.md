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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating to the latest supported LTS release.

### 4. Run Unit Tests

If the solution contains any test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and address any failing tests before proceeding.

### 5. Check for Removed or Changed APIs

Even without build errors, certain APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Verify that any former `System.Web` usage has been fully replaced, for example with ASP.NET Core equivalents.
- **Windows-specific APIs**: Any calls to Windows Registry, `System.Drawing` (GDI+), or COM interop may require additional NuGet packages or may not function on non-Windows platforms.
- **Configuration**: Ensure `web.config` or `app.config` settings have been migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Authentication/Authorization**: If the project used ASP.NET Membership or Forms Authentication, verify these have been replaced with ASP.NET Core Identity or equivalent middleware.

### 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application manually and verify that core functionality, routing, data access, and any external integrations behave as expected.

### 7. Review Static Files and Bundling

If the project previously used `System.Web.Optimization` for bundling and minification, confirm that this has been replaced with a supported alternative such as LibMan, npm-based tooling, or ASP.NET Core's built-in static file middleware.

### 8. Validate Database Connectivity

If the project uses Entity Framework or direct ADO.NET connections:

- Confirm connection strings in `appsettings.json` are correct.
- Run any pending migrations if using Entity Framework Core:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present before deploying to the target environment.