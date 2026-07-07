# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to `net8.0-windows` or another platform-specific moniker and cross-platform support is required, update it accordingly and rebuild.

### 4. Run Unit Tests

If the solution contains test projects, execute all tests to verify runtime behavior matches expectations:

```bash
dotnet test --configuration Release
```

Review any failing tests and address the underlying logic or configuration issues they expose.

### 5. Check for Removed or Replaced APIs

Even when a project builds successfully, certain APIs that existed in .NET Framework may have been replaced or removed in cross-platform .NET. Manually review the following areas:

- **`System.Web` usages**: These are not available in cross-platform .NET. If any remain, they must be replaced with ASP.NET Core equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Ensure these reference `Microsoft.AspNetCore.Http` and not `System.Web`.
- **Configuration**: Verify that `Web.config` based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` APIs.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that all migrations are valid.

### 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application manually and verify that core functionality, routing, authentication, and data access behave as expected.

### 7. Verify Static Files and Middleware

If this is a web project, confirm that static files, middleware registration, and routing are configured correctly in `Program.cs` or `Startup.cs`. Ensure the middleware pipeline order is appropriate for the application's requirements.

### 8. Review Logging and Error Handling

Confirm that logging is configured using `Microsoft.Extensions.Logging` and that any legacy logging frameworks have been properly replaced or integrated. Test error handling paths to ensure exceptions surface correctly.

### 9. Validate Database Connectivity

If the application connects to a database, verify that the connection strings in `appsettings.json` are correct and that the application can successfully connect and perform queries in the target environment.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required assets, configuration files, and binaries are present before deploying to the target environment.