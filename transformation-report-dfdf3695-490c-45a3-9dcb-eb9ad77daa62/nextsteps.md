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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it still references `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality to confirm runtime behavior is consistent with the original.

### 5. Check for Removed or Changed APIs

Even with a clean build, certain APIs behave differently on cross-platform .NET. Pay attention to:

- **`System.Web` dependencies**: These are not available on .NET Core/5+. If any remain, they will need to be replaced with ASP.NET Core equivalents.
- **Windows-specific APIs**: Any usage of the Windows registry, `System.Drawing` (GDI+), or COM interop may require platform-specific guards or alternative libraries.
- **Configuration**: Ensure `Web.config` transforms have been replaced with `appsettings.json` and the appropriate `IConfiguration` setup.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate business logic:

```bash
dotnet test
```

Review test results and investigate any failures that may point to behavioral differences between .NET Framework and the new target framework.

### 7. Verify Database Connectivity

If the application uses Entity Framework or direct database access, confirm that:

- The connection strings in `appsettings.json` are correct.
- The correct database provider NuGet package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).
- Any pending migrations are applied:

```bash
dotnet ef database update
```

### 8. Static Files and Middleware

If this is a web application, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs` using the ASP.NET Core pipeline, rather than relying on legacy `HttpModule` or `HttpHandler` configurations.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required assets, configuration files, and binaries are present before deploying to the target environment.