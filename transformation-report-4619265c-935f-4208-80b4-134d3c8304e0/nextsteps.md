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
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Ensure it is not targeting an outdated or unsupported version such as `netcoreapp3.1` or `net5.0`.

### 4. Run the Application Locally
Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key pages and features to confirm basic functionality is intact.

### 5. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **System.Web** usages — these are not available in modern .NET and may have been replaced by shims or workarounds during transformation that need review.
- **HttpContext** and session handling — verify these work as expected.
- **Entity Framework** — if the project uses EF6, confirm whether it was migrated to EF Core and test all database operations (queries, inserts, updates, deletes).
- **Authentication/Authorization** — test login, logout, and any role-based access control flows.

### 6. Run Existing Tests
If the solution contains test projects, execute them to catch any regressions:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 7. Verify Static Files and wwwroot
Confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder, as this is required for ASP.NET Core to serve them correctly. If assets are missing from expected locations, move them accordingly and verify they load in the browser.

### 8. Review Configuration Files
- Confirm that `appsettings.json` (and `appsettings.Development.json`) contain all necessary configuration values that were previously in `Web.config`.
- Verify connection strings are correct and the application can reach the database.
- Check that any environment-specific settings are properly separated.

### 9. Test Database Connectivity
Run the application and exercise any data-driven features to confirm the database connection is functional and migrations (if applicable) have been applied:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish a Release Build
Once all the above steps pass, produce a published output to verify the release artifact is complete:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Inspect the `./publish` folder to confirm all expected files are present, then test the published output in a staging environment before deploying to production.