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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure the chosen framework version is still within its support lifecycle.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Verify Runtime Behavior

Run the application locally and manually exercise the core workflows to confirm runtime behavior matches expectations from the legacy version:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to areas that commonly differ between .NET Framework and cross-platform .NET, including:

- **Configuration**: Ensure `appsettings.json` or environment variables are correctly replacing any legacy `Web.config` or `App.config` values.
- **Authentication and Authorization**: Verify middleware and identity configurations are functioning as expected.
- **Database Access**: Confirm connection strings are correct and that Entity Framework migrations, if applicable, run without errors.
- **File Paths**: Check that any file I/O operations use `Path.Combine` and are not relying on Windows-specific path assumptions.
- **HTTP and Routing**: Validate that all routes respond correctly and that any legacy `HttpContext` usages have been properly updated.

### 6. Check for Removed or Changed APIs

Review the code for any use of APIs that were available in .NET Framework but have changed behavior or been removed in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [.NET API compatibility tooling](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with identifying these issues.

### 7. Test on Target Platform

If the intent of the migration is to run on a non-Windows platform (Linux or macOS), run and test the application on that platform explicitly to surface any remaining platform-specific issues.

### 8. Review Publish Output

Publish the application and verify the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required assets, configuration files, and dependencies are present.