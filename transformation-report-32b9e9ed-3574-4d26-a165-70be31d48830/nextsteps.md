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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported version of .NET, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating to a long-term support (LTS) release.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key business logic.

### 5. Review Removed or Changed APIs

Check for any use of APIs that were available in the legacy .NET Framework but behave differently in cross-platform .NET. Common areas to review include:

- `System.Web` references, which are not available in .NET Core and later
- `HttpContext` and related types if this is a web project
- Windows-specific APIs such as the registry, WCF, or remoting
- Configuration systems (e.g., `ConfigurationManager` vs. `IConfiguration`)

### 6. Execute Existing Tests

If a test project exists in the solution, run all tests to validate that behavior has not changed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression or a test that requires updating due to API changes.

### 7. Verify Database Connectivity

If the project uses Entity Framework or another data access layer, confirm that:

- The connection strings in `appsettings.json` are correct
- Migrations are up to date by running:

```bash
dotnet ef database update
```

- Queries execute correctly against the target database

### 8. Check Static Assets and Configuration Files

Ensure that all configuration files (`appsettings.json`, `appsettings.Development.json`, etc.) are present and contain the correct values for the target environment. Verify that static assets are being served correctly if this is a web application.

### 9. Deployment

Once the application has been validated locally, publish the application using the following command, targeting the appropriate runtime:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

Replace `win-x64` with the appropriate runtime identifier for your target environment (e.g., `linux-x64` for Linux). Copy the output from the `publish` directory to the target server and configure the hosting environment (e.g., IIS, Kestrel, or a reverse proxy such as Nginx) accordingly.