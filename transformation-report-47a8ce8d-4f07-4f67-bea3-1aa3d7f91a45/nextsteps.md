# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to identify any runtime exceptions that would not surface at build time.

### 5. Check for Removed or Changed APIs

Legacy ASP.NET projects often rely on APIs that have changed or been removed in cross-platform .NET. Specifically, review the following areas:

- **`System.Web` dependencies**: These do not exist in .NET Core or later. Confirm no remaining references exist.
- **`HttpContext` usage**: Ensure access is done via dependency injection rather than `HttpContext.Current`.
- **`ConfigurationManager`**: This should be replaced with `Microsoft.Extensions.Configuration` if not already done.
- **`Global.asax`**: This should have been replaced by `Program.cs` and `Startup.cs` (or the minimal hosting model in .NET 6+).

### 6. Validate Configuration Files

Ensure `appsettings.json` contains all configuration values that were previously in `web.config`. Connection strings, application settings, and environment-specific values should all be accounted for.

### 7. Test Data Access

If the project uses Entity Framework, confirm the version being used is Entity Framework Core and not the legacy Entity Framework 6 (unless EF6 cross-platform support was intentionally retained). Run any existing database migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate that business logic has not been affected by the migration:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to migration-related changes or pre-existing issues.

### 9. Review Static Files and Middleware

Confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Legacy projects using `RouteConfig.cs` or `BundleConfig.cs` will need their equivalents configured using the middleware pipeline.

### 10. Publish the Application

Once all validation steps pass, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required assets, configuration files, and binaries are present before deploying to the target environment.