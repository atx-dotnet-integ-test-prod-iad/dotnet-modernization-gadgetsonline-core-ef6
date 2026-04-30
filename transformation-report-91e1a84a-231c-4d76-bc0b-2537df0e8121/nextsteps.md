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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Even without build errors, certain APIs behave differently or have been removed in cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Ensure any prior usage has been replaced with ASP.NET Core equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Confirm these now reference `Microsoft.AspNetCore.Http` namespaces.
- **`Session` and `Authentication`**: Verify middleware configuration in `Program.cs` or `Startup.cs` covers session, authentication, and authorization.
- **`Web.config`**: Configuration should now be handled via `appsettings.json` and the `IConfiguration` interface. Confirm no runtime settings are still relying on `Web.config`.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output and verify that the application loads and core functionality operates as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that business logic has not been affected by the migration:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

### 7. Verify Database Connectivity

If the application uses Entity Framework or direct database access, confirm the following:

- The connection string in `appsettings.json` is correct and accessible from the new runtime environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- If using Entity Framework Core, confirm that the project does not reference the older `EntityFramework` (non-Core) package, as that is not compatible with cross-platform .NET.

### 8. Static Files and Middleware Pipeline

Confirm that static files (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files must be explicitly enabled in the middleware pipeline:

```csharp
app.UseStaticFiles();
```

Verify this call exists in `Program.cs` or `Startup.cs`.

### 9. Review Event Log and Runtime Errors

Run the application and interact with its major features. Monitor the console output for any runtime exceptions that would not have surfaced during the build phase, such as missing configuration values, unresolved services, or middleware ordering issues.