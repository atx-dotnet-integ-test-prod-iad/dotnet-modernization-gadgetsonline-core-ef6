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

Review the output for any warnings about deprecated packages or version conflicts that may cause runtime issues even if they do not cause build errors.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). Avoid `net5.0` or `net6.0` as these are out of support.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally
Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key pages and features to confirm expected behavior.

### 5. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies** — these are not available in .NET Core/5+. Confirm no runtime references remain.
- **Windows-specific APIs** — any calls to registry, Windows identity, or COM interop may fail at runtime on non-Windows platforms.
- **`HttpContext` and session handling** — verify middleware is correctly configured in `Program.cs` or `Startup.cs`.
- **Entity Framework** — if the project uses EF6, confirm it has been migrated to EF Core or that EF6 compatibility is explicitly configured.

### 6. Check Application Configuration
Verify that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`, including:

- Connection strings
- Application settings keys
- Authentication/authorization settings

### 7. Run Unit Tests
If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests as they may indicate behavioral differences introduced during the migration.

### 8. Validate Database Connectivity
If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the application can connect and perform basic read/write operations at runtime.

### 9. Review Static Files and Bundling
If the project previously used ASP.NET bundling and minification (`System.Web.Optimization`), confirm that a replacement such as LibMan, npm, or manual file inclusion has been set up, as the original bundling system is not available in cross-platform .NET.

### 10. Test on Target Platform
If cross-platform support is a goal, run and test the application on the intended non-Windows platform (Linux or macOS) to surface any remaining platform-specific issues that would not appear during Windows development.