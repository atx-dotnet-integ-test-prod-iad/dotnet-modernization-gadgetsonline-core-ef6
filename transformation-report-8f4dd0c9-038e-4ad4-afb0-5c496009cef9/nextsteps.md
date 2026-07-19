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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in cross-platform .NET)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage (must use ASP.NET Core equivalents)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `App.config` or `Web.config` settings (should be migrated to `appsettings.json`)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running application and verify that core functionality behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral differences introduced by the migration.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains all necessary configuration values previously held in `Web.config`.
- Verify that static files (CSS, JavaScript, images) are placed under the `wwwroot` folder, as required by ASP.NET Core.
- Check that any connection strings have been correctly moved to `appsettings.json` or environment variables.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection string is correct and that the application can connect successfully at runtime. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, produce a published output to confirm the application can be packaged correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all expected files are present before deploying to the target environment.