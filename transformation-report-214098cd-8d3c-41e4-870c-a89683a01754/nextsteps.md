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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-specific framework such as `net48`, the migration to cross-platform .NET is not yet complete.

### 4. Check for Windows-Specific Dependencies

Inspect the project file and source code for any remaining references to Windows-specific libraries or APIs, such as:

- `System.Web` (not available in cross-platform .NET)
- `Microsoft.Web.*` packages
- Registry access or Windows-only P/Invoke calls
- Any `#if` directives targeting `NETFRAMEWORK`

Replace or remove these as appropriate using cross-platform equivalents.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 7. Verify Database Connectivity

If the application uses a database, confirm that:

- Connection strings in `appsettings.json` (or equivalent) are correctly configured for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 8. Review Application Configuration

Confirm that configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` and that the application reads these values correctly at runtime using `IConfiguration`.

### 9. Test on a Non-Windows Platform (Optional but Recommended)

Since the goal is cross-platform compatibility, consider running the application on Linux or macOS to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Address any runtime exceptions that appear only on non-Windows platforms.

### 10. Review Publish Output

Produce a published build to confirm the output is self-contained and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files are present before deploying to the target environment.