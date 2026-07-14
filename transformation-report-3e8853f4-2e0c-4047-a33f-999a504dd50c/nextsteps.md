# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Project

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Ensure this aligns with your team's support and deployment requirements.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm runtime behavior matches the legacy version.

### 5. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed behavior (not necessarily removed) in modern .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in modern .NET
- `HttpContext` and related ASP.NET pipeline components if this is a web project
- Configuration APIs (`ConfigurationManager` vs. `Microsoft.Extensions.Configuration`)
- Any Windows-specific APIs if cross-platform support is a requirement

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, connection strings, and any static web assets are present and correctly referenced. Legacy projects may have relied on `Web.config`, which should have been migrated to `appsettings.json`.

### 8. Test Against a Real Database

If the application uses a database, run the application against a real or staging database instance to verify that:

- Connection strings are correctly configured
- Entity Framework migrations (if applicable) are up to date by running:

```bash
dotnet ef database update
```

### 9. Review Runtime Warnings in Logs

Run the application and review the console or log output for any runtime warnings that may indicate misconfiguration or compatibility issues not caught at compile time.

## Deployment

Once all validation steps above pass:

1. Publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

2. Copy the contents of the `./publish` directory to your target hosting environment.
3. Ensure the target environment has the correct .NET runtime version installed, matching the `<TargetFramework>` defined in the project file.
4. Verify environment-specific configuration (connection strings, API keys, etc.) is correctly set on the target environment before starting the application.