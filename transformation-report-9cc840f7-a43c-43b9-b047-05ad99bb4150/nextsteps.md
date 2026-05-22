# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect actual regressions or tests that need to be updated to reflect new behavior.

### 6. Check for Removed or Changed APIs

Legacy .NET Framework projects often rely on APIs that were removed or changed in cross-platform .NET. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Ensure any usages have been replaced with ASP.NET Core equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Confirm these reference `Microsoft.AspNetCore.Http` and not `System.Web`.
- **`ConfigurationManager`**: This should be replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: This should have been replaced with `Program.cs` and `Startup.cs` or the minimal hosting model.

### 7. Verify Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, which is the expected location for static files in ASP.NET Core.

### 8. Validate Database Connectivity

If the application uses Entity Framework or direct database connections, run the application against a development database and confirm:

- Migrations apply correctly: `dotnet ef database update`
- Data reads and writes function as expected.

### 9. Review `appsettings.json`

Confirm that connection strings and application settings previously stored in `Web.config` have been correctly migrated to `appsettings.json` and that the application reads them at runtime without errors.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and confirm all required files are present before deploying to the target environment.