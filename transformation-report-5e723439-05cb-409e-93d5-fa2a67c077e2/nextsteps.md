# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the core functionality, such as product browsing, cart operations, and any checkout flows.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and address them individually. Failures at this stage may indicate runtime behavioral differences between the legacy framework and the new target framework.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently or have been removed in cross-platform .NET compared to .NET Framework. Areas to review manually include:

- **`HttpContext` and `Session`**: Session handling configuration has changed. Confirm `services.AddSession()` and `app.UseSession()` are present in the startup configuration.
- **`System.Web` dependencies**: Any remaining references to `System.Web` types that were shimmed during transformation should be reviewed and replaced with their `Microsoft.AspNetCore` equivalents.
- **`App_Start` configuration**: Confirm that any logic previously in `RouteConfig`, `BundleConfig`, or `FilterConfig` has been properly moved into the ASP.NET Core middleware pipeline.
- **`Web.config`**: ASP.NET Core does not use `Web.config` for application configuration. Confirm that connection strings and application settings have been migrated to `appsettings.json`.

### 7. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm the connection string in `appsettings.json` is correct and that the database is reachable from the new runtime environment:

```bash
dotnet ef database update
```

If Entity Framework Core was introduced during the migration, verify that any existing migrations are compatible or regenerate them as needed.

### 8. Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been moved to the `wwwroot` folder, which is the expected location for static files in ASP.NET Core. Verify that `app.UseStaticFiles()` is present in the middleware pipeline.

### 9. Deployment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and deploy them to the target hosting environment, such as IIS, a Linux server, or Azure App Service. For IIS hosting, confirm that the ASP.NET Core Hosting Bundle is installed on the server.