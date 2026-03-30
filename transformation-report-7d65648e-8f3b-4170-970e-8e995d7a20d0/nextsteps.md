# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution. The `GadgetsOnline` project compiled without issues under the new cross-platform .NET target.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need to be updated.

### 2. Build the Solution

Perform a full build to confirm the clean state is reproducible:

```bash
dotnet build --configuration Release
```

Verify that the output contains no errors or unexpected warnings.

### 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern value, such as `net8.0` or `net9.0`, rather than a legacy `net4x` value. For example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Address any failing tests before proceeding.

### 5. Verify Runtime Behavior

Launch the application locally and exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Check for any runtime exceptions that would not have been caught at compile time, such as:

- Missing configuration keys (e.g., connection strings previously in `Web.config` that now need to be in `appsettings.json`)
- Removed or changed APIs that were only detected at runtime
- File path assumptions that rely on Windows-specific directory separators

### 6. Review Configuration Migration

If the project previously used `Web.config` or `App.config`, confirm that all relevant settings have been moved to `appsettings.json` or environment variables. Pay particular attention to:

- Database connection strings
- Application-specific keys
- Authentication or authorization settings

### 7. Check for Platform-Specific Code

Search the codebase for any remaining Windows-specific APIs or libraries that may not behave correctly on Linux or macOS:

- `Microsoft.Win32` namespace usage
- Registry access
- Windows-specific file paths (e.g., hardcoded `C:\` paths)
- COM interop

### 8. Review Static Files and wwwroot

If this is a web project, confirm that static assets are correctly placed under the `wwwroot` folder and that the middleware pipeline in `Program.cs` or `Startup.cs` includes `UseStaticFiles()`.

### 9. Validate Database Connectivity

If the application uses Entity Framework or another ORM, run any pending migrations and confirm the database schema is consistent:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once all validation steps pass, produce a published output to confirm the deployment artifact is generated correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.