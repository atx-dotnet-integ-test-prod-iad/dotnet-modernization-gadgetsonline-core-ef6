# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about missing packages, deprecated packages, or version conflicts that may need to be resolved manually.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

Address any warnings that surface during the build, as some may indicate compatibility issues that did not produce hard errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is not what was intended, update it and re-run `dotnet restore` and `dotnet build`.

### 4. Check for Removed or Replaced APIs

Some APIs available in .NET Framework are not present or have changed in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should now reference `Microsoft.AspNetCore.Http`.
- Any `ConfigurationManager` usages should be replaced with `Microsoft.Extensions.Configuration`.
- `System.Drawing` may require the `System.Drawing.Common` NuGet package and has platform-specific limitations on non-Windows systems.

### 5. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the key areas of the application in a browser to confirm expected behavior, including:

- Home page and navigation
- Product listing and detail pages
- Shopping cart functionality
- Any authentication or account management flows

### 6. Execute Existing Tests

If the solution contains test projects, run them to verify functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as this is the expected location in ASP.NET Core. If assets are missing or returning 404 responses, move them to `wwwroot` and verify the static files middleware is enabled in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correctly configured and that the application can connect at runtime. If Entity Framework is used, verify that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Deployment

Once the application has been validated locally, publish a release build to prepare for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present before copying them to the target hosting environment.