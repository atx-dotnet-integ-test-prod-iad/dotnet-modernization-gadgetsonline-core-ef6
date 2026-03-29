# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution appears to have completed successfully. There are no build errors present in the project `GadgetsOnline/GadgetsOnline.csproj` or anywhere else in the solution.

## Validation

Before deploying, follow these steps to validate that the migrated project behaves as expected.

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies. If any packages could not be resolved, check that their versions are compatible with your target .NET framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings, as some warnings may indicate runtime issues.

### 3. Run Unit Tests

If the solution contains any test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output and address any failing tests before proceeding.

### 4. Review Removed or Changed APIs

Cross-platform .NET removes or changes certain APIs that were available in .NET Framework. Manually review the following areas:

- Any usage of `System.Web` namespaces, as these are not available in cross-platform .NET. These would typically need to be replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should be verified to use the ASP.NET Core versions.
- Any `ConfigurationManager` usages should be replaced with `Microsoft.Extensions.Configuration`.
- `Global.asax` lifecycle events should be migrated to middleware or `Program.cs` startup logic.

### 5. Run the Application Locally

Start the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the primary user flows of the application, such as browsing products, adding items to a cart, and completing a purchase, to confirm the application behaves correctly.

### 6. Check Static Files and Assets

Verify that static files such as CSS, JavaScript, and images are being served correctly. In ASP.NET Core, static files must be placed in the `wwwroot` folder and the `UseStaticFiles()` middleware must be registered in the request pipeline.

### 7. Verify Configuration and Connection Strings

Confirm that your `appsettings.json` file contains the correct configuration values, including database connection strings, that were previously held in `Web.config`. Ensure environment-specific settings are handled using `appsettings.Development.json` or environment variables as appropriate.

### 8. Database Connectivity

If the application uses a database, verify that the connection is functioning correctly by exercising database-driven features of the application during local testing. If Entity Framework is in use, confirm that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Review Deployment Target Requirements

Before deploying, confirm the following on your target server or hosting environment:

- The appropriate .NET runtime is installed and matches the target framework of the project.
- Any required environment variables or configuration values are set.
- The web server (e.g., IIS, Kestrel behind a reverse proxy) is configured correctly for ASP.NET Core hosting.

For IIS hosting specifically, ensure the **ASP.NET Core Module** is installed and the application pool is set to **No Managed Code**.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all expected files are present before deploying to your target environment.