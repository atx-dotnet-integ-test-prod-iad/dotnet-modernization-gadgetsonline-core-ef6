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

Review the output for any warnings about deprecated packages or version conflicts that may cause runtime issues even if they do not produce build errors.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). Avoid targeting end-of-life versions such as `net5.0` or `net6.0` unless there is a specific constraint.

### 4. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently or have been removed in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **System.Web** references — these are not available in cross-platform .NET. If any remain at runtime, they will cause failures.
- **Windows-specific APIs** — features such as the registry, certain cryptography providers, or Windows identity APIs may throw `PlatformNotSupportedException` on non-Windows systems.
- **HttpContext and Session** — usage patterns differ from ASP.NET to ASP.NET Core.

### 5. Run the Application Locally
Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows manually and check the console output for any runtime exceptions or warnings.

### 6. Review Configuration Files
Ensure that `web.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, application settings, and custom error pages are commonly missed during transformation. Verify the following:

- Database connection strings are present and correct in `appsettings.json`.
- Any environment-specific settings are handled using the appropriate ASP.NET Core environment configuration (`appsettings.Development.json`, etc.).

### 7. Validate Database Connectivity
If the project uses Entity Framework or direct ADO.NET connections, confirm the database provider package is compatible with cross-platform .NET. For example:

- Entity Framework Core requires the appropriate provider (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).
- Run any pending migrations if Entity Framework Core is in use:

```bash
dotnet ef database update
```

### 8. Execute Any Existing Tests
If the solution contains test projects, run them to identify any behavioral regressions:

```bash
dotnet test
```

Review failing tests carefully, as they may indicate runtime incompatibilities that were not caught at compile time.

### 9. Publish the Application
Once local validation is complete, produce a published output to confirm the deployment artifact builds correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files, static assets, and configuration files are present before deploying to the target environment.