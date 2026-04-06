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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality, particularly any areas that relied on Windows-specific APIs in the legacy project, such as authentication, session management, or file I/O.

### 5. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check in a web application like GadgetsOnline include:

- `System.Web` references — these are not available in .NET Core/.NET 5+. Ensure they have been replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext` usage — verify it is accessed via dependency injection rather than `HttpContext.Current`.
- `ConfigurationManager` — this should be replaced with `IConfiguration` from `Microsoft.Extensions.Configuration`.
- `FormsAuthentication` — this should be replaced with ASP.NET Core cookie authentication middleware.

### 6. Run Existing Tests

If the solution contains a test project, execute the tests to validate application behavior:

```bash
dotnet test
```

Review any failing tests and determine whether they represent genuine regressions introduced during the migration or tests that need to be updated to reflect new API usage.

### 7. Verify Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, which is the expected location in ASP.NET Core. In .NET Framework projects, these files were often served directly from the project root.

### 8. Review Middleware Configuration

Open `Program.cs` or `Startup.cs` and verify that the middleware pipeline is correctly configured. Ensure the following are present where applicable:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
```

The order of middleware registration is significant in ASP.NET Core and incorrect ordering can cause unexpected behavior.

### 9. Database Connectivity

If the application uses Entity Framework or direct database access, verify the connection string is correctly defined in `appsettings.json` and that the database provider package targets .NET-compatible versions. Run any pending migrations if applicable:

```bash
dotnet ef database update
```

### 10. Publish a Release Build

Once the above steps are validated, produce a published output to confirm the application can be packaged correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all expected files are present.