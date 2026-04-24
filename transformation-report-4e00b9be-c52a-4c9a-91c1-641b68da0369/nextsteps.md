# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated `GadgetsOnline` project.

---

## 1. Restore NuGet Packages

Before running or testing the application, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment.

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

---

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the correct SDK is declared at the top of the `.csproj` file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

---

## 4. Verify Runtime Behavior and Configuration

- Check `Program.cs` and any `Startup.cs` (if still present) to ensure middleware, services, and configuration are wired correctly for the modern .NET hosting model.
- Confirm that `appsettings.json` contains the correct connection strings and application settings that were previously in `Web.config` or `App.config`.
- If `Web.config` transformations were used previously, ensure those settings have been migrated to `appsettings.json` or environment-specific files such as `appsettings.Production.json`.

---

## 5. Run Unit Tests

If the solution contains test projects, execute them to verify functional correctness after the migration.

```bash
dotnet test
```

Review any failing tests carefully, as failures may indicate behavioral differences between the legacy .NET Framework and the new .NET runtime.

---

## 6. Run the Application Locally

Start the application locally and perform manual validation of core functionality.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Specifically verify:
- Database connectivity and Entity Framework migrations (if applicable).
- Authentication and authorization flows.
- Any file I/O or path-dependent operations, as path handling can differ across platforms.
- Static file serving and routing behavior.

---

## 7. Check for Platform-Specific Code

Search the codebase for any remaining Windows-specific APIs or dependencies that may not behave correctly on Linux or macOS if cross-platform support is required. Common areas include:

- `System.Drawing` (replace with a cross-platform alternative such as `SkiaSharp` if needed).
- Windows Registry access.
- COM interop.
- Hardcoded Windows-style file paths using backslashes.

---

## 8. Review Deprecated or Replaced APIs

Run the .NET Upgrade Analyzer or review the build output for usage of deprecated APIs. The following command can help identify compatibility issues:

```bash
dotnet build /p:EnableNETAnalyzers=true
```

Address any reported diagnostics before moving to a production deployment.

---

## 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present.