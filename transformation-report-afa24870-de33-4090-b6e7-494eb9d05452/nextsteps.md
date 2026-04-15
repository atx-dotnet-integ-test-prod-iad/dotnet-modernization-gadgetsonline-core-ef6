# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Ensure there are no warnings about missing packages or version conflicts.

### 2. Build the Solution
Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that may indicate deprecated APIs or compatibility concerns that did not surface as hard errors.

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only TFM such as `net48` or `net472`, update it accordingly.

### 4. Check for Windows-Specific APIs
Even without build errors, the code may contain Windows-specific API calls (e.g., `System.Drawing`, `Microsoft.Win32`, registry access) that will fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer to surface these:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
dotnet build
```

Review any `CA1416` platform compatibility warnings that appear.

### 5. Run the Application Locally
Start the application and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Walk through the primary user flows (browsing products, cart, checkout if applicable) to confirm runtime behavior matches the legacy version.

### 6. Run Existing Tests
If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Address any failing tests before proceeding. If no tests exist, consider writing basic smoke tests covering critical paths.

### 7. Verify Static Assets and Configuration
- Confirm that `appsettings.json` (or `web.config` equivalents that were migrated) contain the correct connection strings and application settings.
- Verify that static files (CSS, JS, images) are served correctly by checking the `wwwroot` folder structure and any middleware configuration in `Program.cs` or `Startup.cs`.

### 8. Database Connectivity
If the application uses a database, confirm the connection string targets the correct server and that any Entity Framework migrations are up to date:

```bash
dotnet ef database update
```

Test basic read and write operations through the application to confirm data access is functioning.

### 9. Cross-Platform Smoke Test
If cross-platform support is a goal, run the application on a non-Windows OS (Linux or macOS) to surface any remaining platform-specific issues that the build process would not catch.