# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to `net6.0` or `net7.0`, consider upgrading to `net8.0` as those versions are no longer receiving long-term support.

### 4. Check for Windows-Specific Dependencies

Inspect the project for any NuGet packages or APIs that are Windows-only. Common examples include:

- `Microsoft.Web.Infrastructure`
- `System.Web` references
- Registry or COM interop usage

If any are found, evaluate whether a cross-platform alternative exists.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality, routing, and data access behave as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 7. Verify Configuration and Middleware

If this is an ASP.NET Core project, review the following files for correctness:

- `Program.cs` — confirm middleware registration order (e.g., `UseRouting`, `UseAuthentication`, `UseAuthorization`, `UseEndpoints`)
- `appsettings.json` — confirm connection strings and application settings were carried over from the legacy `Web.config`

### 8. Validate Data Access

If the project uses Entity Framework, run the following to confirm the model and database are in sync:

```bash
dotnet ef migrations list
dotnet ef database update
```

If Entity Framework Core was substituted for the legacy Entity Framework 6, test all data access paths thoroughly, as LINQ behavior and migration formats differ between the two.

### 9. Test on a Non-Windows Platform

Since the goal of the migration is cross-platform support, run the application on Linux or macOS if possible, to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish the Application

Once validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required assets, static files, and configuration files are present before deploying to the target environment.