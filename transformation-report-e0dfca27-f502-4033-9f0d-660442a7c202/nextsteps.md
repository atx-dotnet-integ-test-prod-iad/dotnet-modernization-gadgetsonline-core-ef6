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

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Windows-Specific Dependencies

Inspect the project for any remaining dependencies that are Windows-specific, such as:

- References to `System.Web` (not available in cross-platform .NET)
- Use of the Windows Registry (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- Any NuGet packages that target `net4x` only

Replace or remove any such dependencies with cross-platform equivalents where applicable.

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that business logic has not been broken during the transformation:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 7. Review Configuration Files

- Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable.
- Verify that connection strings, application settings, and environment-specific values are correctly represented in the new configuration system.
- Ensure that `Program.cs` and `Startup.cs` (or the combined `Program.cs` in minimal hosting model) correctly registers all required services and middleware.

### 8. Validate Static Files and Views

If the project is a web application, confirm that:

- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder.
- Razor views or pages render correctly at runtime.
- Any Bundling and Minification previously handled by `System.Web.Optimization` has been replaced with an alternative such as LibMan or a front-end build tool.

### 9. Check Logging and Error Handling

Verify that logging previously configured through `System.Diagnostics` or third-party libraries is correctly wired up using the `Microsoft.Extensions.Logging` infrastructure or the equivalent logging provider in the new project.