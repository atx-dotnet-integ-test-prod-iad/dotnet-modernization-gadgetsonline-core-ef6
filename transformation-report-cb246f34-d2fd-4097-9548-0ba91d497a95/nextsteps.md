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

Ensure this aligns with your team's intended runtime version.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application locally to confirm runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's key workflows and verify that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may reference APIs that only function correctly on Windows. Search the codebase for usages of the following and test them explicitly on your target platform:

- `System.Web` types that may have been shimmed
- Registry access (`Microsoft.Win32.Registry`)
- Windows file path assumptions (backslashes, drive letters)
- `HttpContext.Current` usage patterns

### 7. Verify Static Files and Assets

Confirm that static assets such as CSS, JavaScript, and images are served correctly at runtime. Check that file paths in the project are using cross-platform compatible path separators.

### 8. Review Connection Strings and Configuration

Inspect `appsettings.json` (or equivalent configuration files) to ensure connection strings and environment-specific settings have been migrated from `Web.config` correctly. Test database connectivity explicitly.

### 9. Check Entity Framework or Data Access Layer

If the project uses Entity Framework, verify the following:

```bash
dotnet ef migrations list
```

Confirm that migrations are present and that the database schema is up to date:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once all validation steps pass, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present, then deploy the output to your target environment.