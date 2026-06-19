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

Review the output for any warnings related to package compatibility or missing dependencies.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or deprecated APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that the application starts without runtime exceptions and that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and determine whether they are failing due to the migration or pre-existing issues.

### 6. Verify Static Assets and Configuration

- Confirm that `appsettings.json` and any environment-specific configuration files (e.g., `appsettings.Development.json`) are present and correctly structured.
- If the project previously used `Web.config`, verify that the relevant settings have been migrated to `appsettings.json` or the appropriate .NET configuration system.
- Check that static files (CSS, JavaScript, images) are served correctly by reviewing the `wwwroot` folder structure.

### 7. Review Middleware and Startup Configuration

If the project uses `Startup.cs` or a `Program.cs` entry point, review the middleware pipeline to ensure:

- Authentication and authorization middleware is configured correctly.
- Any previously used HTTP modules or HTTP handlers from the legacy project have been replaced with the equivalent ASP.NET Core middleware.

### 8. Database and Data Access Validation

- If Entity Framework is used, run the following to verify the model is consistent with the database schema:

```bash
dotnet ef migrations list
```

- Test database connectivity by exercising data-access paths through the running application.
- If connection strings were previously stored in `Web.config`, confirm they have been moved to `appsettings.json` or environment variables.

### 9. Manual Functional Testing

Walk through the primary user-facing features of the application manually to identify any runtime issues that automated tests may not cover, such as view rendering errors, broken routes, or missing resources.

### 10. Deployment

Once the above steps have been completed and the application is stable:

- Publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

- Copy the contents of the `./publish` folder to the target hosting environment (e.g., IIS, a Linux server, or Azure App Service).
- On IIS, ensure the ASP.NET Core Hosting Bundle is installed and the application pool is set to **No Managed Code**.
- Verify the deployed application is running correctly by performing the same functional checks described in step 9.