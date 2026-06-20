# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution appears to have transformed successfully. No build errors were detected in any of the projects, including `GadgetsOnline/GadgetsOnline.csproj`. The following steps outline how to validate, test, and deploy the migrated project.

---

## 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate cross-platform version and that the project SDK is set correctly:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

---

## 4. Check for Windows-Specific Dependencies

Since this was a legacy project, review the code and NuGet references for any Windows-specific APIs or packages that may not function correctly on Linux or macOS. Common areas to check include:

- `System.Web` references (should be replaced with ASP.NET Core equivalents)
- Windows Registry access
- COM interop
- `HttpContext` usage patterns from classic ASP.NET

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining platform-specific code.

---

## 5. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release --logger trx
```

Review the `.trx` output files for any failed tests and investigate failures that may be caused by behavioral differences between .NET Framework and modern .NET.

---

## 6. Run the Application Locally

Start the application and perform manual smoke testing:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify the following at a minimum:

- The application starts without runtime exceptions
- Core user-facing routes or entry points respond correctly
- Database connections (if applicable) are established successfully
- Any authentication or session management works as expected

---

## 7. Review Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) contain the correct configuration values. Legacy `Web.config` or `App.config` values should have been migrated to `appsettings.json`. Confirm:

- Connection strings are present and correct
- Any custom configuration sections have been translated properly
- Environment-specific settings are separated appropriately

---

## 8. Validate Static Assets and Views

If this is a web project, verify that:

- Razor views (`.cshtml`) render without errors
- Static files (CSS, JavaScript, images) are served correctly
- Any Razor syntax that was valid in ASP.NET MVC 5 is still valid in ASP.NET Core

---

## 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the `./publish` directory to ensure all required files, including static assets and configuration files, are present before deploying to the target environment.