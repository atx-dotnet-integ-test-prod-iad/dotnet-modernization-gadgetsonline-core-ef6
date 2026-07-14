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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`). Ensure it is not still referencing a legacy framework moniker such as `net48` or `netcoreapp3.1`.

### 4. Check for Replaced or Removed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET types (should now use `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-only APIs such as the registry or certain `System.Drawing` methods

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the key areas of the application to verify that runtime behavior matches expectations from the original project.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests to determine whether failures are due to migration-related changes or pre-existing issues.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are placed under the `wwwroot` folder if this is an ASP.NET Core web project.
- Check that connection strings and environment-specific settings are correctly configured.

### 8. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm that:

- The correct EF Core packages are referenced (not EF 6 packages, unless intentionally retained).
- Migrations are up to date by running:

```bash
dotnet ef database update
```

- Connection strings in `appsettings.json` point to the correct database instances.

### 9. Check Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order.
- Services such as authentication, authorization, and session management are properly configured.
- Any custom HTTP modules or handlers from the legacy project have been converted to middleware.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.