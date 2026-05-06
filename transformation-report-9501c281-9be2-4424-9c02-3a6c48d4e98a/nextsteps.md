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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that pages load correctly and core functionality behaves as expected.

### 5. Check for Windows-Specific Dependencies

Even without build errors, the project may still reference Windows-specific libraries or APIs (e.g., `System.Drawing`, registry access, or Windows authentication). Search the codebase for usages that may not behave correctly on Linux or macOS:

- `System.Drawing` — replace with a cross-platform alternative such as `SkiaSharp` or `ImageSharp` if used.
- `Microsoft.Win32` — review any registry access and determine if it can be removed or replaced.
- Windows-specific file path separators — ensure `Path.Combine` is used consistently rather than hardcoded backslashes.

### 6. Review Configuration Files

Check that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and correctly configured. If the project previously used `Web.config`, confirm that relevant settings have been migrated:

- Connection strings
- Application settings
- Authentication configuration

### 7. Database Connectivity

If the project uses a database, verify the connection string in `appsettings.json` is correct for the target environment and run the application against the database to confirm queries execute without error. If Entity Framework is in use, run:

```bash
dotnet ef database update
```

### 8. Execute Unit Tests

If a test project exists in the solution, run the test suite to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 9. Publish the Application

Once the above steps are completed and the application is functioning correctly, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Verify on Target Operating System

If the intent is to run the application on Linux or macOS, perform steps 4 through 8 on the target operating system to surface any remaining platform-specific issues before final deployment.