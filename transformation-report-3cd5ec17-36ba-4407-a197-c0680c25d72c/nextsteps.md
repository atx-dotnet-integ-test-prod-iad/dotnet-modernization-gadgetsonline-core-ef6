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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to the intended cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the .NET version installed on your machine and your intended deployment environment.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to verify that behavior matches the original legacy version.

### 5. Review Static Files and wwwroot

If this is a web application, verify that static assets (CSS, JavaScript, images) located in the `wwwroot` folder are being served correctly. Check that any bundling or minification tooling previously used (e.g., BundleConfig) has been replaced with an appropriate alternative such as LibMan or npm-based tooling.

### 6. Verify Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correctly configured for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- The database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is compatible with the target framework version.

### 7. Check for Windows-Specific Dependencies

Since the goal is cross-platform compatibility, review the codebase for any remaining Windows-specific APIs or dependencies, such as:

- References to `System.Web` (should have been replaced with `Microsoft.AspNetCore` equivalents)
- Windows Registry access
- Windows-only file path assumptions (e.g., hardcoded backslashes)

Use `Path.Combine` and `Path.DirectorySeparatorChar` where file paths are constructed manually.

### 8. Run Existing Tests

If a test project exists in the solution, execute the test suite to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during the migration or pre-existing issues.

### 9. Verify Authentication and Session Handling

If the application uses authentication, confirm that the middleware configuration in `Program.cs` or `Startup.cs` correctly registers authentication and session services, and that cookies or tokens behave as expected when tested manually.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correctly structured:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.