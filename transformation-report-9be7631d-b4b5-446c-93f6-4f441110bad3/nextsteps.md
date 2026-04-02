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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Check for Windows-Specific Dependencies

Even when a build succeeds, some NuGet packages or APIs may only function on Windows. Review the project's dependencies for any packages that carry a `windows` target framework moniker or that reference `System.Windows`, `Microsoft.Win32`, or similar namespaces that are not cross-platform.

### 5. Run the Application Locally

Start the application using the .NET CLI to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its primary features to confirm there are no runtime exceptions that were not present as build errors.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failures before proceeding.

### 7. Review Configuration Files

Inspect `appsettings.json` and any environment-specific configuration files (e.g., `appsettings.Development.json`) to confirm that connection strings, API keys, and other settings have been correctly carried over from the legacy project's configuration (e.g., `Web.config` or `App.config`).

### 8. Validate Data Access

If the project uses Entity Framework, confirm the database context and migrations are functioning correctly:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

If migrations are missing or the schema is out of date, generate and apply them as needed:

```bash
dotnet ef migrations add InitialMigration --project GadgetsOnline/GadgetsOnline.csproj
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once the above steps are completed without issue, produce a published output:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.