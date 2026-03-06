# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages. Address any packages that may have been targeting the old .NET Framework and require cross-platform alternatives.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it references `net48` or any other Windows-only framework moniker, update it accordingly.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review test output for any failures and investigate them in the context of the migration.

### 5. Check for Windows-Specific API Usage

Even without build errors, the code may still reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer to surface these issues:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
```

Rebuild and review any new analyzer warnings that appear.

### 6. Review Static Files and Configuration

For a web project such as `GadgetsOnline`, verify the following:

- `appsettings.json` exists and contains the appropriate configuration that was previously in `Web.config` or `App.config`.
- Connection strings, application settings, and environment-specific values have been migrated correctly.
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder as expected by ASP.NET Core conventions.

### 7. Run the Application Locally

Start the application using the .NET CLI and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows and confirm that pages load, data is retrieved correctly, and no unhandled exceptions occur.

### 8. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm that:

- The connection string in `appsettings.json` is correct.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- Data reads and writes function as expected during local testing.

### 9. Address Runtime Warnings

Review the application logs during local execution for any runtime warnings or deprecation notices that should be addressed before deploying to a production environment.

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the published output to the target hosting environment.