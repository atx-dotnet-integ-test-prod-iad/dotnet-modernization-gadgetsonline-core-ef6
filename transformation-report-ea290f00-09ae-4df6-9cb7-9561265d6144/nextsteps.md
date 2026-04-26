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

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only TFM such as `net48` or `net472`.

### 4. Check for Runtime-Specific Code
Even without build errors, there may be runtime issues caused by Windows-specific APIs that compile successfully but fail at runtime on Linux or macOS. Search the codebase for usages of:

- `System.Web` types that may have been shimmed
- `HttpContext` usage patterns from classic ASP.NET
- `Server.MapPath` or `HttpServerUtility`
- Windows registry access (`Microsoft.Win32.Registry`)
- COM interop or P/Invoke calls targeting Windows libraries

### 5. Run the Application Locally
Start the application and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the main workflows of the application (e.g., product browsing, cart, checkout if applicable) and confirm pages render and data loads correctly.

### 6. Check Static Files and wwwroot
Verify that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, which is the expected location in cross-platform .NET web projects. Confirm that the application serves them correctly at runtime.

### 7. Review Configuration Files
- Ensure `appsettings.json` (and `appsettings.Development.json`) contain the correct connection strings and application settings that were previously in `Web.config`.
- Confirm that `Web.config` transforms or entries (such as custom error pages, HTTP handlers, or modules) have been migrated to the appropriate middleware registrations in `Program.cs` or `Startup.cs`.

### 8. Database Connectivity
If the application uses a database, verify the connection string in `appsettings.json` is correct and that the application can connect successfully at runtime. If Entity Framework is in use, confirm that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Run Existing Tests
If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and address them before considering the migration complete.

### 10. Deployment
Once local validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the output to the target hosting environment (e.g., IIS with the ASP.NET Core Hosting Bundle installed, or a Linux server with the .NET runtime installed).