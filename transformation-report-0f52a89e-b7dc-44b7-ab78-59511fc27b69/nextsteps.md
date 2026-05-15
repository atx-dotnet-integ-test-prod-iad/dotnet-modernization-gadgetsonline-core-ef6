# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts. If any packages could not be resolved, update them using:

```bash
dotnet list package --outdated
dotnet add package <PackageName>
```

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally
Start the application locally and verify it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows (e.g., browsing products, cart, checkout) to confirm functional correctness after the migration.

### 5. Run Existing Tests
If the solution contains any test projects, execute them to validate that existing behavior has not regressed:

```bash
dotnet test
```

Review the test output for any failures or skipped tests that may indicate compatibility issues introduced during the migration.

### 6. Check for Removed or Changed APIs
Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the .NET Upgrade Assistant compatibility analyzer or the Platform Compatibility Analyzer to identify any runtime issues that would not surface as build errors:

```bash
dotnet add package Microsoft.DotNet.PlatformAbstractions
```

Additionally, review any usage of the following areas which commonly require attention after migration:

- `System.Web` references (should be replaced with ASP.NET Core equivalents)
- `HttpContext` and session handling
- Authentication and authorization middleware
- Entity Framework (ensure EF Core is used, not EF 6)
- `Web.config` settings (these should now be in `appsettings.json` and `Program.cs`)

### 7. Verify Configuration Migration
Confirm that all settings previously in `Web.config` have been correctly moved to `appsettings.json`. Check that connection strings, app settings, and any custom configuration sections are present and correctly read at runtime.

### 8. Deployment
Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy to your target environment (e.g., IIS, Azure App Service, or a Linux server). If deploying to IIS, ensure the ASP.NET Core Hosting Bundle is installed on the server.