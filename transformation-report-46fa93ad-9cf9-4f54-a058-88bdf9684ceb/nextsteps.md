# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate compatibility concerns with the target framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and trace them back to API or behavioral differences introduced by the framework migration.

### 5. Check for Removed or Changed APIs

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to identify any API usage that may have changed behavior at runtime even though it compiled successfully:

```bash
dotnet tool install -g dotnet-apicompat
```

Pay particular attention to:
- `System.Web` references that may have been shimmed
- Any usage of `HttpContext`, `Session`, or `FormsAuthentication` which behave differently outside of ASP.NET Classic
- Any reflection-based code that may be affected by trimming or assembly loading changes

### 6. Validate Application Startup

Run the application locally and verify it starts without exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Check the console output and any configured logging sinks for startup errors or middleware configuration issues.

### 7. Test Core Functionality

Manually exercise the primary workflows of the application, including:
- Any authentication or authorization flows
- Database connectivity and query execution
- Key page routes or API endpoints
- Static file serving, if applicable

### 8. Review `appsettings.json`

Confirm that configuration values previously stored in `web.config` or `app.config` have been correctly migrated to `appsettings.json` or environment variables, including:
- Connection strings
- Application-specific keys
- Logging configuration

### 9. Verify Database Migrations

If the project uses Entity Framework, confirm that existing migrations are compatible with the new runtime and that the database schema is up to date:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once all validation steps pass, produce a release publish artifact:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all expected files are present before deploying to the target environment.