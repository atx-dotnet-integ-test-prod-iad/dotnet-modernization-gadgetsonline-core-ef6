# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The `GadgetsOnline/GadgetsOnline.csproj` project compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform target, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it is using `net8.0` or the appropriate modern TFM rather than any legacy `net4x` target.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary features to confirm runtime behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and address them individually.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay attention to the following areas:

- **File paths**: Ensure no hardcoded Windows-style paths (`\`) are used. Replace with `Path.Combine` or forward slashes.
- **Configuration**: Confirm that `Web.config` or `App.config` settings have been migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Authentication/Authorization**: If the project uses Windows Authentication or `System.Web` membership providers, verify that replacements using ASP.NET Core Identity or equivalent are functioning.
- **Session and HttpContext**: Confirm that any usage of `HttpContext.Current` has been replaced with the injected `IHttpContextAccessor`.
- **Entity Framework**: If using Entity Framework, confirm the project has migrated to EF Core and that existing migrations are compatible.

### 7. Review Middleware Pipeline

If this is a web application, open `Program.cs` or `Startup.cs` and confirm the middleware pipeline is correctly ordered, including:

- `UseRouting`
- `UseAuthentication` (if applicable)
- `UseAuthorization` (if applicable)
- `UseStaticFiles` (if applicable)
- `UseEndpoints` or minimal API mappings

### 8. Validate Static Files and Assets

Confirm that static assets such as CSS, JavaScript, and images are being served correctly. These should reside under the `wwwroot` folder in an ASP.NET Core project.

### 9. Database Connectivity

If the application connects to a database, verify the connection string in `appsettings.json` is correct and that the application can connect and perform queries as expected in your target environment.

### 10. Deploy to Target Environment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to your target server and confirm the application starts and operates correctly in that environment.