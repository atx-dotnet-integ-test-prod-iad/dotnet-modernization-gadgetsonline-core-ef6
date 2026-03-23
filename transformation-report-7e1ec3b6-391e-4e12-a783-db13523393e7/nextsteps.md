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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or target framework compatibility.

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

Navigate through the application and verify that core functionality works as expected, including any database connections, authentication, and page rendering.

### 5. Check for Removed or Changed APIs

Legacy ASP.NET projects often rely on APIs that have changed or been removed in cross-platform .NET. Review the following areas manually:

- **`HttpContext` usage**: Ensure `HttpContext.Current` has been replaced with dependency-injected `IHttpContextAccessor`.
- **`Session` and `Cache`**: Confirm these are configured through the middleware pipeline in `Program.cs` or `Startup.cs`.
- **`System.Web` references**: Verify there are no remaining references to `System.Web`, as it is not available in cross-platform .NET.

### 6. Execute Unit Tests

If the solution contains test projects, run them to validate that existing logic behaves correctly after migration:

```bash
dotnet test
```

Review any failing tests and determine whether they are failing due to migration-related changes or pre-existing issues.

### 7. Validate Database Connectivity

If the project uses Entity Framework or direct database access, confirm the connection strings in `appsettings.json` are correct and that the database provider package is compatible with the target framework. Run any pending migrations if applicable:

```bash
dotnet ef database update
```

### 8. Review Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as this is required for cross-platform .NET web applications to serve static files correctly.

### 9. Deployment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment. Ensure the hosting environment has the appropriate .NET runtime installed and that the web server (IIS, Nginx, or Apache) is configured to forward requests to the Kestrel process or serve the application directly.