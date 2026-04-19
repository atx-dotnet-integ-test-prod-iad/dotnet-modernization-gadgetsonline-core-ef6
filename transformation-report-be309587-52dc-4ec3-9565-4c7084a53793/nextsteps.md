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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Verify that this version is installed on your machine by running:

```bash
dotnet --list-sdks
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality is preserved:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 5. Check for Windows-Specific Dependencies

Inspect the project for any dependencies that were specific to the .NET Framework or Windows platform, such as:

- `System.Web` references
- Windows Registry access
- COM interop components
- `HttpContext` usage patterns specific to ASP.NET (non-Core)

These will not be available on cross-platform .NET and will require refactoring.

### 6. Review `web.config` or `app.config`

If the project previously relied on `web.config` or `app.config` for configuration, verify that settings have been migrated to `appsettings.json` and that the application reads configuration using `Microsoft.Extensions.Configuration`.

### 7. Run the Application Locally

Start the application locally to confirm it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's primary workflows and verify that core functionality behaves as expected.

### 8. Check Runtime Behavior for Data Access

If the project uses Entity Framework, confirm the version in use is Entity Framework Core and not the legacy Entity Framework 6. Run any pending migrations and verify database connectivity:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Review Static Files and Asset Paths

If this is a web project, confirm that static files (CSS, JavaScript, images) are being served correctly and that paths have not been broken during the transformation.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and well-formed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.