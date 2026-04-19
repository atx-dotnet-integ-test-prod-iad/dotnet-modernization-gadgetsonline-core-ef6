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
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported .NET version (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it as those versions are out of support.

### 4. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **System.Web** dependencies — these do not exist in cross-platform .NET. Confirm all usages have been replaced with `Microsoft.AspNetCore` equivalents.
- **HttpContext** and **HttpRequest** usage — verify these reference `Microsoft.AspNetCore.Http` and not `System.Web`.
- **Configuration** — ensure `Web.config` has been replaced with `appsettings.json` and that `IConfiguration` is used throughout.
- **Entity Framework** — if the project uses EF, confirm it has been migrated to EF Core and that migrations are up to date.

### 5. Run the Application Locally
Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary features to identify any runtime exceptions that would not surface at build time.

### 6. Execute Existing Tests
If the solution contains test projects, run them to verify functional correctness:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences introduced by the migration rather than pre-existing failures.

### 7. Review Static Files and wwwroot
Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, which is the expected location for static files in ASP.NET Core.

### 8. Validate Database Connectivity
If the application uses a database, verify the connection string in `appsettings.json` is correct and that the application can connect and perform basic read/write operations at runtime.

### 9. Check Middleware and Startup Configuration
Review `Program.cs` (and `Startup.cs` if present) to ensure middleware is registered in the correct order. Common issues include:

- Authentication/Authorization middleware being registered out of order.
- Missing calls to `app.UseStaticFiles()`, `app.UseRouting()`, or `app.UseEndpoints()`.

### 10. Deployment
Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to your target server. Ensure the target server has the appropriate .NET runtime installed and that the hosting environment (e.g., IIS, Kestrel) is configured correctly for ASP.NET Core.