# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to your intended .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment where the application will be deployed.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves the same as in the legacy version.

### 5. Check for Runtime-Only Issues

Some issues do not surface at build time. Pay attention to the following areas during local testing:

- **Database connectivity**: Confirm connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date. Run `dotnet ef database update` if applicable.
- **Authentication and authorization**: Verify that any authentication middleware (e.g., cookies, JWT) is correctly configured for the new .NET pipeline.
- **Static files and routing**: Confirm that static assets are served correctly and that all routes resolve as expected.
- **Configuration**: Ensure that settings previously in `Web.config` have been properly migrated to `appsettings.json` or environment variables.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the migration or tests that require updating due to API changes.

### 7. Review Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Manually review the code for usage of the following common problem areas:

- `System.Web` namespace references
- `HttpContext` usage patterns
- `ConfigurationManager` (replaced by `IConfiguration`)
- Any Windows-specific APIs (e.g., registry access, Windows identity impersonation)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility concerns.

### 8. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all necessary files are present before deploying to the target environment.