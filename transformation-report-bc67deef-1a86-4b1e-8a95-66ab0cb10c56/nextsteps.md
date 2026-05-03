# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime environment where the application will be hosted.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in the .NET Framework but behave differently or are absent in cross-platform .NET. Common areas to check in a web project include:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` usage patterns
- `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`
- `Global.asax` replaced by `Program.cs` and `Startup.cs` or the minimal hosting model

### 5. Verify Static Files and Configuration

- Confirm that `wwwroot` contains all necessary static assets (CSS, JavaScript, images).
- Verify that `appsettings.json` contains the configuration values that were previously in `Web.config`.
- Check that connection strings have been correctly migrated to `appsettings.json`.

### 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL indicated in the console output and manually verify that core pages and functionality load correctly.

### 7. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that require updating due to API changes.

### 8. Validate Database Connectivity

If the application uses Entity Framework or direct database access, confirm that:

- The connection string in `appsettings.json` is correct.
- Migrations (if using Entity Framework Core) are up to date by running:

```bash
dotnet ef database update
```

### 9. Review Middleware and Request Pipeline

If the project was migrated from ASP.NET MVC or Web Forms to ASP.NET Core, verify that the middleware pipeline in `Program.cs` or `Startup.cs` includes the necessary components:

- Authentication and authorization middleware
- Routing configuration
- Session and cookie handling
- Error handling middleware

### 10. Deploy to Target Environment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target hosting environment and verify the application runs correctly there.