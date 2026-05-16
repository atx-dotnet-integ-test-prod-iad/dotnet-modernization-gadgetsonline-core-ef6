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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm that the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Address any failing tests before proceeding to deployment.

### 5. Run the Application Locally

Start the application locally to confirm it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its primary features to check for runtime exceptions or unexpected behavior that would not surface at compile time.

### 6. Check for Windows-Specific API Usage

Even with a successful build, the code may reference APIs that are Windows-only and will fail on Linux or macOS at runtime. Search the codebase for usages of the following and replace or guard them with cross-platform alternatives where necessary:

- `Microsoft.Win32` namespace
- `System.Windows.Forms` or `System.Drawing` (non-web projects)
- Registry access (`RegistryKey`)
- Windows file path assumptions (backslash separators; use `Path.Combine` instead)

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` (and any environment-specific variants such as `appsettings.Production.json`) are present and contain the correct configuration values.
- Ensure that any static file directories (e.g., `wwwroot`) are intact and that file paths referenced in code use `Path.Combine` or equivalent cross-platform methods.

### 8. Review Entity Framework or Data Access Layer

If the project uses Entity Framework, verify the following:

- The correct EF Core provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).
- Pending migrations are applied:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

- Connection strings in `appsettings.json` point to the correct database instance.

### 9. Publish the Application

Once the above steps are completed and the application is verified locally, publish it to the target environment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target server.