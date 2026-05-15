# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Windows-Specific Dependencies

Review the project's NuGet package references and code for any APIs or packages that are Windows-only. Common areas to check include:

- `System.Drawing` (use a cross-platform alternative such as `SkiaSharp` or `ImageSharp` if needed)
- Registry access via `Microsoft.Win32`
- Any packages that carry a `windows` target framework moniker restriction

### 5. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm expected behavior.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures before proceeding.

### 7. Verify Data Access and Database Connectivity

If the project uses Entity Framework or another data access layer, confirm the following:

- Connection strings in `appsettings.json` are correct for the target environment
- Any required database migrations are up to date by running:

```bash
dotnet ef database update
```

- The database provider package targets the correct .NET version

### 8. Review Application Configuration

Cross-platform .NET uses `appsettings.json` and environment variables rather than `Web.config` or `App.config`. Confirm that:

- All configuration values previously in `Web.config` have been moved to `appsettings.json`
- Any environment-specific settings are placed in `appsettings.{Environment}.json`
- `System.Configuration.ConfigurationManager` usages have been replaced where applicable

### 9. Test on the Target Operating System

If the intent is to run on Linux or macOS, run the application on that operating system explicitly to surface any remaining platform-specific issues that may not appear on Windows.