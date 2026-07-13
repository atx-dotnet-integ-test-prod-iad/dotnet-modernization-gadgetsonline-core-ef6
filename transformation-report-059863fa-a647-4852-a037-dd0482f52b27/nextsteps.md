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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, certain APIs that existed in .NET Framework may have changed behavior in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace — this is not available in cross-platform .NET and should have been replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` — confirm these are now using the `Microsoft.AspNetCore.Http` versions.
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`.
- `System.Drawing` — on non-Windows platforms this may require the `System.Drawing.Common` NuGet package or an alternative library.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running URL (typically `https://localhost:5001` or `http://localhost:5000`) and verify that the application loads and core functionality works as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Verify Static Files and Configuration

- Confirm that `wwwroot` contains all expected static assets (CSS, JavaScript, images).
- Verify that `appsettings.json` contains the configuration values that were previously in `Web.config` or `App.config`.
- Check that connection strings and application settings are correctly mapped.

### 8. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues that would not appear in a Windows-only build.