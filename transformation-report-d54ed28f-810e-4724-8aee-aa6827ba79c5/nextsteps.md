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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the appropriate local URL (e.g., `https://localhost:5001`) and verify that core functionality behaves correctly.

### 5. Execute Unit Tests

If the solution contains test projects, run them to validate that existing logic has not been broken during the migration:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 6. Check for Removed or Changed APIs

Even without build errors, certain APIs that existed in .NET Framework may behave differently or have subtle breaking changes in cross-platform .NET. Review the following areas manually:

- **HTTP and Session handling**: Confirm `HttpContext`, `Session`, and related APIs function correctly.
- **Database access**: If Entity Framework is used, verify that the correct version of EF Core is referenced and that migrations are up to date.
- **Configuration**: Ensure `Web.config` settings have been properly migrated to `appsettings.json` and that the configuration is being read correctly at runtime.
- **Authentication and Authorization**: Verify that any membership, identity, or authentication middleware is correctly configured for ASP.NET Core.

### 7. Review Static Files and Routing

Confirm that static files (CSS, JavaScript, images) are being served correctly and that all routes resolve as expected. In ASP.NET Core, static files must be placed in the `wwwroot` folder and the middleware must be enabled in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

### 8. Validate Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the application can connect successfully at runtime. Run any pending migrations if using EF Core:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Deploy to Target Environment

Once all of the above steps have been validated, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to your target hosting environment and verify the application starts and operates correctly in that environment.