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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's supported runtime version.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves the same as the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences introduced during the migration.

### 6. Check for Windows-Specific Dependencies

Review the codebase for any remaining Windows-specific APIs or libraries, such as:

- References to `System.Web` (not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- COM interop components
- `HttpContext` usage patterns specific to ASP.NET (non-Core)

Replace or abstract any such dependencies with cross-platform equivalents.

### 7. Verify Static Files and Configuration

Confirm that the following have been correctly migrated:

- `web.config` settings have been translated to `appsettings.json` where applicable
- Static files are served correctly via the middleware pipeline
- Connection strings and environment-specific configuration are functioning as expected

### 8. Test on a Non-Windows Platform (Optional but Recommended)

Since the goal is cross-platform compatibility, consider running the application on Linux or macOS to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Address any runtime exceptions that appear exclusively on non-Windows environments.

### 9. Review Publish Output

Perform a publish to verify the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required files, assemblies, and assets are present.

### 10. Deploy

Once all of the above steps have been validated, deploy the published output to your target environment by copying the contents of the `./publish` directory to the server or hosting location and configuring the runtime environment as needed.