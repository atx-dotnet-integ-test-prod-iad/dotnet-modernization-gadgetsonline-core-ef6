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

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and re-run the build.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they will need to be replaced with ASP.NET Core equivalents.
- **`HttpContext` and related types**: Ensure these have been migrated to their ASP.NET Core counterparts.
- **Configuration**: Verify that `web.config` based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` APIs.
- **Database access**: If Entity Framework is used, confirm the project is using Entity Framework Core and not the legacy `System.Data.Entity` namespace.

### 5. Run Unit Tests

If the solution contains test projects, execute them to validate runtime behavior:

```bash
dotnet test
```

Review test results for any failures that may indicate behavioral differences introduced by the migration.

### 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Manually navigate through the key areas of the application to verify that pages load correctly, data access works as expected, and no runtime exceptions occur.

### 7. Review Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order.
- Services such as authentication, authorization, and session management are properly configured.
- Static file serving is enabled if the application serves front-end assets.

### 8. Verify Logging

Confirm that logging has been migrated from any legacy logging frameworks (e.g., `log4net`, `NLog` with legacy configuration) to use `Microsoft.Extensions.Logging` or a compatible modern provider.

### 9. Check Connection Strings and Environment Configuration

Ensure that connection strings previously defined in `web.config` have been moved to `appsettings.json` or environment variables, and that they are being read correctly at runtime.

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  }
}
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.