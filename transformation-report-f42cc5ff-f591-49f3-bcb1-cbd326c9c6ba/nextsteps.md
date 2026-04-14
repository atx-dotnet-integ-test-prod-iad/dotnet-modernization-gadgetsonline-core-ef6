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

Review the output for any warnings related to missing or incompatible packages.

### 2. Build the Solution
Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally
Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary features to confirm runtime behavior matches the legacy version.

### 5. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies** — these are not available in cross-platform .NET. Confirm any usages have been properly replaced (e.g., with ASP.NET Core equivalents).
- **Windows-specific APIs** — any calls to registry, Windows identity, or COM interop may fail at runtime on non-Windows platforms.
- **Configuration** — ensure `web.config` settings have been migrated to `appsettings.json` and that `IConfiguration` is used throughout.
- **Session and Authentication** — verify that session management and authentication middleware are correctly configured in `Program.cs` or `Startup.cs`.

### 6. Run Existing Tests
If a test project exists in the solution, execute the tests to validate core logic:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the migration.

### 7. Database Connectivity
If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the application can connect and perform queries at runtime. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update
```

### 8. Static Files and Bundling
Confirm that static assets (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files must reside in the `wwwroot` folder and the middleware must be enabled:

```csharp
app.UseStaticFiles();
```

### 9. Deployment
Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy it to the target hosting environment (e.g., IIS, Linux server). If deploying to IIS, ensure the ASP.NET Core Hosting Bundle is installed on the server.