# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the `.csproj` file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Review the following areas:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm they have been fully replaced with ASP.NET Core equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Ensure usages reference `Microsoft.AspNetCore.Http` and not `System.Web`.
- **`ConfigurationManager`**: This has been replaced by `Microsoft.Extensions.Configuration`. Confirm `appsettings.json` is in place and being read correctly.
- **`Global.asax`**: This should have been replaced by `Program.cs` and `Startup.cs` (or the minimal hosting model in `Program.cs`).

### 5. Run the Application Locally

Start the application and verify it runs without runtime errors.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows, such as browsing products, adding items to a cart, and any checkout or account functionality if present.

### 6. Execute Unit Tests

If there are test projects in the solution, run them to validate business logic.

```bash
dotnet test
```

Review the test results and address any failing tests that may point to behavioral differences introduced during migration.

### 7. Verify Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as this is the expected location for static files in ASP.NET Core.

### 8. Review Middleware and Application Configuration

In `Program.cs` or `Startup.cs`, confirm that the middleware pipeline is correctly configured. Key middleware to verify includes:

- `app.UseStaticFiles()`
- `app.UseRouting()`
- `app.UseAuthentication()` and `app.UseAuthorization()` if the application uses identity or auth
- `app.UseSession()` if session state is used

### 9. Database Connectivity

If the application uses Entity Framework or direct database connections, verify the connection string in `appsettings.json` is correct and that the application can connect to the database at runtime. If using Entity Framework Core, confirm that any required migrations are up to date.

```bash
dotnet ef database update
```

### 10. Test on Target Platform

If the goal of the migration was to run on a non-Windows platform (Linux or macOS), run and test the application on that target platform to confirm there are no platform-specific runtime issues.