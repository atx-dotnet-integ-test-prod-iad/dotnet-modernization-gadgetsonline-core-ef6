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

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Check for Windows-Specific Dependencies

Inspect the project for any remaining references to Windows-specific APIs or libraries (e.g., `System.Web`, `Microsoft.Web.Infrastructure`, or classic ASP.NET types). These will not function on non-Windows platforms. Use the .NET Upgrade Assistant compatibility analyzer or the following command to help identify issues:

```bash
dotnet build /p:EnableNETAnalyzers=true
```

### 5. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary features to confirm that routing, data access, and any middleware components behave correctly.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate core functionality:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Verify Configuration Files

Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings keys
- Authentication configuration

### 8. Validate Data Access

If the project uses Entity Framework, confirm the correct version (EF Core) is referenced and that any migrations are up to date:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once the above steps are completed and the application is functioning correctly, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm the application starts correctly from that output using:

```bash
dotnet ./publish/GadgetsOnline.dll
```