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

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently on cross-platform .NET compared to .NET Framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the project is a web application, ensure it is using `net8.0` or later and that the project SDK is set to `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage (not available in cross-platform .NET)
- `HttpContext`, `HttpRequest`, and `HttpResponse` — these now exist under `Microsoft.AspNetCore.Http`
- `ConfigurationManager` — replaced by `Microsoft.Extensions.Configuration`
- `Global.asax` — replaced by `Program.cs` and `Startup.cs` (or the minimal hosting model)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output and verify that the application loads and functions as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may point to behavioral differences between .NET Framework and cross-platform .NET.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains the correct configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are being served correctly by checking that the `wwwroot` folder is properly structured and that `UseStaticFiles()` is called in the middleware pipeline.

### 8. Check Platform-Specific Behavior

If the application is intended to run on Linux or macOS in addition to Windows, pay attention to:

- **File path separators**: Use `Path.Combine` rather than hardcoded backslashes.
- **File name case sensitivity**: Linux file systems are case-sensitive, so ensure all file references match the actual casing on disk.
- **Registry or Windows-specific APIs**: Remove or conditionally compile any code that relies on Windows-only features.