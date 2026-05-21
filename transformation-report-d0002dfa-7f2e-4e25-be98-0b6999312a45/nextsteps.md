# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility, deprecated packages, or unresolved dependencies.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate modern .NET version rather than a legacy `net48` or `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm basic functionality is intact.

### 5. Check for Windows-Specific APIs

Even without build errors, the project may reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Search the codebase for usages of the following:

- `System.Web` namespaces (outside of ASP.NET Core equivalents)
- `Microsoft.Win32`
- `System.Drawing` (without the `System.Drawing.Common` NuGet package)
- Registry access or Windows file path assumptions

Replace or abstract any such usages with cross-platform alternatives.

### 6. Review Configuration Files

Ensure that configuration has been migrated from `Web.config` or `App.config` to `appsettings.json`. Verify that:

- Connection strings are present and correct in `appsettings.json`
- Environment-specific settings use `appsettings.Development.json` or equivalent
- Any `<appSettings>` or `<connectionStrings>` entries from the old config file have been carried over

### 7. Database Connectivity

If the project uses a database, verify the connection string is valid for the current environment and run the application against the database to confirm queries execute without error. If Entity Framework is in use, run:

```bash
dotnet ef database update
```

### 8. Run Existing Tests

If a test project exists within the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the migration.

### 9. Review Static Files and Middleware

If this is a web project, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Ensure that the middleware pipeline order is appropriate for the application's requirements.

### 10. Publish a Release Build

Once local validation is complete, produce a published output to verify the deployment artifact is generated correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present.