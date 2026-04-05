# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and not a legacy `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows, such as browsing products, adding items to a cart, and completing a checkout if applicable.

### 5. Check for Runtime Errors

Even with a clean build, runtime issues can surface. Pay attention to:

- Missing configuration values in `appsettings.json` that may have previously lived in `Web.config` or `App.config`
- Connection strings that reference SQL Server or other data sources — verify these are correctly migrated to `appsettings.json`
- Any `<appSettings>` or `<system.web>` entries from the legacy `Web.config` that need to be manually ported

### 6. Verify Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, as ASP.NET Core serves static files from there by default.

### 7. Review Authentication and Session Configuration

Legacy ASP.NET projects often use `FormsAuthentication` or `SessionState` configured in `Web.config`. Confirm these have been replaced with the appropriate ASP.NET Core middleware in `Program.cs` or `Startup.cs`, for example:

```csharp
builder.Services.AddSession();
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie();
```

### 8. Run Unit Tests

If the solution contains test projects, execute them to validate that existing logic behaves correctly:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the migration.

### 9. Review Middleware Pipeline

In `Program.cs`, confirm the middleware pipeline is ordered correctly. A typical order for a web application is:

```csharp
app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.UseSession();
app.MapControllerRoutes(...);
```

### 10. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` folder to confirm all expected files are present before deploying to the target environment.