# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing dependencies.

### 2. Build the Project
Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets the intended cross-platform .NET version (e.g., `net8.0`). Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

### 4. Run Unit Tests
If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and trace them back to behavioral differences introduced by the migration.

### 5. Run the Application Locally
Start the application and confirm it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's core functionality and verify that pages load, data access works, and no runtime exceptions are thrown.

### 6. Check for Removed or Changed APIs
Even with a clean build, some .NET Framework APIs may have been replaced with alternatives that behave differently at runtime. Review the following areas manually:

- **HTTP modules and handlers**: These do not exist in cross-platform .NET. Confirm they have been replaced with equivalent middleware.
- **`System.Web` dependencies**: Any remaining references to `System.Web` types should be replaced with their `Microsoft.AspNetCore` equivalents.
- **Configuration system**: Confirm that `web.config`-based configuration has been migrated to `appsettings.json` and the `IConfiguration` API.
- **Session and authentication**: Verify that session state and authentication middleware are configured correctly in `Program.cs` or `Startup.cs`.

### 7. Verify Database Connectivity
If the application uses Entity Framework or direct database access, confirm that connection strings are correctly set in `appsettings.json` and that migrations (if applicable) are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Deployment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target server. Ensure the target server has the appropriate .NET runtime installed. You can verify the required runtime version with:

```bash
dotnet --list-runtimes
```

Confirm the hosting environment (IIS, Kestrel, etc.) is configured to serve the published output correctly. For IIS, ensure the ASP.NET Core Module (ANCM) is installed and the application pool is set to **No Managed Code**.