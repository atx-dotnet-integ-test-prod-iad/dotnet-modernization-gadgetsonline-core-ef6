# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts that may need to be addressed.

### 2. Build the Solution
Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Ensure it is not still referencing a legacy `net48` or `netcoreapp` moniker unless that is intentional.

### 4. Check for Deprecated or Incompatible NuGet Packages
Run the following to identify outdated packages:

```bash
dotnet list package --outdated
```

Replace any packages that relied on Windows-specific APIs or that have known incompatibilities with cross-platform .NET. Common examples include:
- `System.Web` dependencies (not available on .NET Core/5+)
- `Microsoft.AspNet.*` packages (should be replaced with `Microsoft.AspNetCore.*`)

### 5. Run the Application Locally
Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm expected behavior.

### 6. Execute Existing Tests
If a test project exists in the solution, run the test suite to catch any runtime regressions:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a code issue or a test configuration issue introduced during migration.

### 7. Verify Static Assets and Configuration Files
- Confirm that `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that connection strings, app settings, and environment-specific values have been correctly migrated.
- Check that `wwwroot` contains all necessary static files (CSS, JavaScript, images) if this is a web project.

### 8. Test on a Non-Windows Platform (if applicable)
Since the goal is cross-platform compatibility, run the application on Linux or macOS if possible:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Watch for any `PlatformNotSupportedException` or file path issues (e.g., hardcoded backslashes) that only surface on non-Windows systems.

### 9. Publish the Application
Once validation is complete, publish a release build:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present before deploying to the target environment.