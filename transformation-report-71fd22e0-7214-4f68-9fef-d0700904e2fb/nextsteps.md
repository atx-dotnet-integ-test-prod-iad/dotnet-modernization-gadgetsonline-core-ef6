# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate and supported version of .NET, such as `net8.0`. Ensure it is not targeting an end-of-life version like `net5.0` or `net6.0` unless there is a specific reason.

### 4. Run the Application Locally

Start the application using the .NET CLI to confirm it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's primary features to verify that core functionality behaves as expected.

### 5. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` methods

### 6. Review Configuration Files

Ensure that `appsettings.json` (or `appsettings.Development.json`) contains all configuration values that were previously held in `Web.config` or `App.config`. Confirm that connection strings, app settings, and environment-specific values have been migrated correctly.

### 7. Run Existing Tests

If the solution contains test projects, execute them to validate that business logic has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 8. Verify Static Files and Middleware

If `GadgetsOnline` is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Check that the following are present and properly ordered:

- `app.UseStaticFiles()`
- `app.UseRouting()`
- `app.UseAuthentication()` and `app.UseAuthorization()` if applicable
- `app.MapControllers()` or `app.MapRazorPages()` as appropriate

### 9. Test Database Connectivity

If the application uses a database, verify that the connection string is correct and that Entity Framework Core migrations (if applicable) are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

Confirm that data reads and writes function correctly through the application.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify that all required files, including static assets and configuration files, are present before deploying to the target environment.