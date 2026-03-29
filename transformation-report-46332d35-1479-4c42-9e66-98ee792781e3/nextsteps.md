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

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality, routing, and data access behave correctly.

### 5. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related types (may require `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Session` and `Authentication` middleware configuration

### 6. Validate Configuration Files

Ensure that `appsettings.json` (or `appsettings.Development.json`) contains all necessary configuration values that were previously stored in `Web.config` or `App.config`. Confirm connection strings, app settings, and any custom configuration sections have been migrated correctly.

### 7. Test Data Access

If the project uses Entity Framework, confirm the version being used is compatible with the target framework:

```bash
dotnet ef dbcontext info --project GadgetsOnline/GadgetsOnline.csproj
```

Run any existing database migrations to verify they apply cleanly:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Execute Existing Tests

If there are test projects in the solution, run them to confirm existing functionality is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm all required assets, static files, and configuration files are present.