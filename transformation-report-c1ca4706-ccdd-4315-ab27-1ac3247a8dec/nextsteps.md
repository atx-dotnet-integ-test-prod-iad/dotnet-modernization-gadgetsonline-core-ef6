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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows to confirm functional correctness.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they represent regressions introduced during the migration or pre-existing issues.

### 6. Review Replaced or Removed APIs

Cross-platform .NET does not support certain Windows-specific APIs that were available in the .NET Framework. Manually review the codebase for usage of the following common problem areas:

- `System.Web` namespaces (e.g., `HttpContext`, `HttpRequest` from `System.Web`)
- `System.Drawing` without the `System.Drawing.Common` NuGet package
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain.GetCurrentDomain().SetupInformation`
- WCF server-side components

If any of these are found, they will require targeted remediation.

### 7. Verify Static Files and Configuration

Confirm that the following have been correctly migrated:

- `appsettings.json` contains all settings previously held in `Web.config` or `App.config`
- Static files (CSS, JS, images) are located under the `wwwroot` folder
- Connection strings are present and correctly formatted in `appsettings.json`

### 8. Check Middleware and Startup Configuration

If the project is an ASP.NET Core web application, review `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order
- Authentication and authorization middleware is configured properly
- Any custom HTTP modules or handlers from the legacy project have been converted to middleware

### 9. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment
- Entity Framework Core migrations (if applicable) are up to date by running:

```bash
dotnet ef database update
```

- Data access operations function correctly during local testing.