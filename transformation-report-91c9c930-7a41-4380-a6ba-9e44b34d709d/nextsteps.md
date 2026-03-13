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

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` (the current LTS release).

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality, paying attention to:

- Database connectivity and any Entity Framework migrations that may need to be applied
- Authentication and authorization flows
- Any file system or path-dependent operations that may behave differently across operating systems

### 5. Apply Pending Database Migrations

If the project uses Entity Framework Core, verify that all migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

If the project was previously using Entity Framework 6 (EF6), confirm it has been migrated to Entity Framework Core, as EF6 does not support cross-platform .NET.

### 6. Execute Unit and Integration Tests

If a test project exists in the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests carefully, as failures at this stage may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Usage of Windows-Specific APIs

Search the codebase for APIs that may only function on Windows, such as:

- `System.Web` references (not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows-specific file path assumptions (e.g., hardcoded backslashes)
- `HttpContext.Current` usage, which does not exist in ASP.NET Core

Use `Path.Combine` and `Path.DirectorySeparatorChar` for any file path construction to ensure cross-platform compatibility.

### 8. Validate Static Files and Configuration

Confirm that `wwwroot` contains all required static assets and that `appsettings.json` (and `appsettings.Production.json`) are correctly configured with the appropriate connection strings and application settings for the target environment.

### 9. Publish the Application

Once local validation is complete, publish the application to verify the output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.