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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and re-run the restore and build steps.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage if this is an ASP.NET project migrated to ASP.NET Core
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`
- Any Windows-specific APIs such as the registry or WCF server-side components

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to verify that core functionality behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they represent regressions introduced during migration or tests that require updating due to API changes.

### 7. Review Static Assets and Configuration Files

If this is a web project, verify the following:

- `appsettings.json` is present and contains the configuration previously held in `web.config` or `app.config`
- Static files such as CSS, JavaScript, and images are located in the correct directory, typically `wwwroot` for ASP.NET Core projects
- Any connection strings have been correctly moved to `appsettings.json` or environment variables

### 8. Validate Database Connectivity

If the project uses a database, confirm that the connection strings are correct and that the application can connect to the database successfully. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef migrations list
dotnet ef database update
```

### 9. Deployment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and deploy them to the target hosting environment. Confirm that the runtime environment on the target server has the appropriate .NET version installed by running:

```bash
dotnet --version
```