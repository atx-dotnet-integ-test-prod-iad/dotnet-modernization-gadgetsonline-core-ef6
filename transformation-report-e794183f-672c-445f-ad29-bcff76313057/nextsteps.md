# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your team's supported runtime version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application manually and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test --configuration Release
```

Review test results for any failures that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed behavior or reduced functionality in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (GDI+)
- Any third-party libraries that may have been targeting .NET Framework and have not been updated

### 7. Validate Data Access Layer

If the project uses Entity Framework, confirm the version in use is Entity Framework Core and that migrations are compatible with the target database. Run the following to check pending migrations:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Test on Target Operating Systems

Since the goal is cross-platform compatibility, run and validate the application on each operating system your team intends to support (Windows, Linux, macOS) to surface any platform-specific runtime issues.

### 9. Review Configuration Files

Confirm that `web.config` or `app.config` settings have been properly migrated to `appsettings.json` and that environment-specific configuration is handled using the `IConfiguration` abstraction provided by `Microsoft.Extensions.Configuration`.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all required assets, static files, and dependencies are present before deploying to your target environment.