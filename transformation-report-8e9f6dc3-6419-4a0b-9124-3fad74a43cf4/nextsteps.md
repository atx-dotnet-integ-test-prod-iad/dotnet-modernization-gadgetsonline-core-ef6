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

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

### 4. Run the Application Locally

Start the application locally to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality such as routing, data access, and any authentication mechanisms behave as expected.

### 5. Check for Removed or Changed APIs

Since this was a migration from legacy .NET Framework, review the code for usage of APIs that have been removed or significantly changed in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` and related types (now accessed via `IHttpContextAccessor`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` logic (should be moved to `Program.cs` or `Startup.cs`)

### 6. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm that:

- The connection strings in `appsettings.json` are correctly configured
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- The database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is compatible with the target framework version.

### 7. Execute Unit Tests

If a test project exists within the solution, run the test suite to catch any regressions introduced during the migration:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to migration-related changes or pre-existing issues.

### 8. Review Static Files and Web Assets

For web projects, confirm that static files (CSS, JavaScript, images) are located in the `wwwroot` folder, as this is the expected convention in cross-platform ASP.NET Core. Files outside of `wwwroot` will not be served by default.

### 9. Deployment

Once the above steps have been completed and the application is running correctly:

1. Publish the application using the following command, targeting your intended runtime:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

Replace `win-x64` with the appropriate runtime identifier for your target environment (e.g., `linux-x64`).

2. Copy the contents of the `publish` output folder to your target server or hosting environment.
3. Ensure the hosting environment has the correct .NET runtime version installed, or use `--self-contained true` to bundle the runtime with the application.