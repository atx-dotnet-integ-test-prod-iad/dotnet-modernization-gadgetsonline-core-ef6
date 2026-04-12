# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or packages that could not be resolved.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors and review any warnings that may indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Avoid `net48` or other Windows-only framework monikers if cross-platform support is required.

### 4. Check for Windows-Specific Dependencies

Search the project for any APIs or packages that are Windows-only, such as:

- `System.Web` references
- `Microsoft.Web.*` packages
- Any P/Invoke calls targeting Windows-specific libraries
- Registry access via `Microsoft.Win32`

These will not function correctly on Linux or macOS even if the project compiles.

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate correctness:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the transformation.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been migrated correctly.
- Check that static files (CSS, JS, images) are located under the `wwwroot` folder if this is a web project.

### 8. Verify Database Connectivity

If the application uses a database:

- Confirm the connection string in `appsettings.json` is correct.
- If using Entity Framework, run the following to verify the model is consistent with the database schema:

```bash
dotnet ef migrations list
```

Apply any pending migrations if necessary:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the published output to the target environment.