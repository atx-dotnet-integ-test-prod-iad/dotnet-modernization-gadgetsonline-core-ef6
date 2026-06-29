# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution appears to have transformed successfully. No build errors were detected in any of the projects within the solution. Below are steps to validate, test, and deploy the migrated project.

---

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues introduced during migration.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure no legacy framework monikers such as `net472` or `net48` remain unless intentionally targeting multiple frameworks.

---

## 4. Check for Removed or Changed APIs

Review the codebase for usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage (not available in cross-platform .NET)
- `HttpContext` and related types (replaced by ASP.NET Core equivalents)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or certain `System.Drawing` types

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to surface any remaining incompatibilities.

---

## 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test --configuration Release
```

Review test results carefully. Failures may indicate behavioral differences between .NET Framework and cross-platform .NET that were not caught at compile time.

---

## 6. Validate Runtime Behavior

Run the application locally and exercise its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Specifically verify:

- Database connectivity and migrations (if using Entity Framework)
- Authentication and session handling
- Static file serving
- Any third-party integrations or external service calls

---

## 7. Review Configuration Files

Confirm that `appsettings.json` (or equivalent) contains all configuration values previously held in `web.config` or `app.config`. The `web.config` file is not used for application configuration in cross-platform .NET; only IIS-specific settings remain relevant in that file.

---

## 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, static files, and dependencies are present.

---

## 9. Verify on Target Operating System

If the goal is cross-platform deployment, run the published output on the target operating system (Linux or macOS if applicable) to confirm there are no platform-specific runtime issues:

```bash
dotnet ./publish/GadgetsOnline.dll
```