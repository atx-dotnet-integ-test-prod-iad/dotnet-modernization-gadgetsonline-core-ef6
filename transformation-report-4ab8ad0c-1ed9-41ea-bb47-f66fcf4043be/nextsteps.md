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

Address any warnings that surface, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or another legacy framework, update it accordingly.

### 4. Check for Removed or Changed APIs

Review the codebase for usage of APIs that are not available in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage (not available outside of ASP.NET on .NET Framework)
- `HttpContext`, `HttpRequest`, and `HttpResponse` if not migrated to ASP.NET Core equivalents
- Windows-specific APIs such as the registry, WMI, or COM interop
- `ConfigurationManager` — replace with `Microsoft.Extensions.Configuration` if not already done

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences between .NET Framework and modern .NET.

### 7. Review Configuration Files

- Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable.
- Verify that connection strings, application settings, and environment-specific values are correctly configured.

### 8. Verify Static Assets and Middleware

If this is a web application, confirm that static files, routing, and middleware are correctly configured in `Program.cs` or `Startup.cs` under the ASP.NET Core model.

### 9. Test on Target Platforms

Since the goal is cross-platform support, test the application on each intended operating system (e.g., Windows, Linux, macOS) to identify any remaining platform-specific issues.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Review Deprecated Package References

Check `GadgetsOnline/GadgetsOnline.csproj` for any NuGet packages that may have cross-platform alternatives or updated versions. Use the following command to identify outdated packages:

```bash
dotnet list package --outdated
```

Update packages as appropriate and re-run the build and tests after each update.