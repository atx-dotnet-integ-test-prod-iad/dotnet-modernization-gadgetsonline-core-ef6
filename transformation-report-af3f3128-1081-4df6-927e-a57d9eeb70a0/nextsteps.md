# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to the latest supported long-term support (LTS) release.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application locally to confirm runtime behavior is as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality, such as product listings, cart operations, and any checkout flows, behave correctly.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in the .NET Framework but have changed or been removed in modern .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in modern .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext` usage patterns.
- Any use of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- `Global.asax` logic, which should be migrated to `Program.cs` and middleware pipeline configuration.

### 7. Review Static Files and wwwroot

Ensure that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, which is the expected location for static files in ASP.NET Core.

### 8. Validate Database Connectivity

If the application uses Entity Framework or direct database connections, verify that:

- The connection string is correctly configured in `appsettings.json`.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Review Middleware and Startup Configuration

Confirm that `Program.cs` (or `Startup.cs` if still present) correctly configures all required middleware, including authentication, authorization, routing, and any custom middleware that was previously configured in `Global.asax` or `Web.config`.

### 10. Inspect web.config Transformation

If a `web.config` file is still present, review it to ensure any settings it contained have been migrated to `appsettings.json` or the appropriate ASP.NET Core configuration mechanism. The `web.config` in modern .NET is primarily used for IIS hosting configuration and should not contain application settings.

## Deployment

Once all validation steps above have been completed and the application runs correctly locally, proceed with the following:

1. Publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

2. Deploy the contents of the `./publish` folder to your target hosting environment, such as IIS, Azure App Service, or a self-hosted server.

3. If deploying to IIS, ensure the ASP.NET Core Hosting Bundle is installed on the server to support the modern .NET runtime.