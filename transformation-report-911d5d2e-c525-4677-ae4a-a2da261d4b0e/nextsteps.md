# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently on cross-platform .NET.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the version of the .NET SDK you have installed.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm expected behavior is preserved from the legacy version.

### 5. Review Platform-Specific Code

Search the codebase for any APIs or patterns that were historically Windows-specific and may not behave correctly on other platforms. Common areas to check include:

- File path handling (use `Path.Combine` rather than hardcoded separators)
- Registry access (`Microsoft.Win32.Registry`)
- Windows-specific authentication or identity APIs
- `System.Drawing` usage (consider replacing with a cross-platform alternative such as `SkiaSharp` if applicable)

### 6. Check for Removed or Incompatible APIs

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to identify any APIs used in the project that are not available in the target framework:

```bash
dotnet tool install -g dotnet-apicompat
```

### 7. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests carefully, as failures may indicate behavioral differences between the legacy framework and cross-platform .NET rather than bugs in the tests themselves.

### 8. Review Configuration and Middleware

If `GadgetsOnline` is an ASP.NET Core application, review the following:

- `Program.cs` and/or `Startup.cs` for correct middleware registration
- `appsettings.json` for any configuration values that referenced environment-specific or Windows-specific paths
- Session, authentication, and authorization configurations to ensure they are compatible with ASP.NET Core conventions

### 9. Verify Static Assets and Views

If the project uses Razor views or static files, confirm that:

- All views render correctly at runtime
- Static file paths are correct and files are included in the project output
- Any bundling or minification configuration is compatible with the new project structure

### 10. Publish a Release Build

Once local validation is complete, produce a published output to confirm the application packages correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assemblies, and assets are present.