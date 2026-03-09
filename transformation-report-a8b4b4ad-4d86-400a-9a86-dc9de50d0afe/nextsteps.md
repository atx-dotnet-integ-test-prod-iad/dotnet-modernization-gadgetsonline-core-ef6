# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution appears to have transformed successfully. No build errors were detected in any of the projects within the solution. Below are the recommended steps to validate, test, and deploy the migrated project.

---

## 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts. If any packages are incompatible with the target .NET version, locate them in the `.csproj` file and update them to their cross-platform compatible equivalents via:

```bash
dotnet add package <PackageName>
```

---

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings, as some warnings may indicate deprecated APIs or patterns that could cause runtime issues.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest LTS release.

---

## 4. Check for Windows-Specific Dependencies

Since this is a cross-platform migration, scan the codebase for any APIs or packages that are Windows-specific. Common areas to check include:

- Use of `System.Web` (not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows-only NuGet packages

Use the .NET Upgrade Assistant compatibility analyzer or the following command to check for platform compatibility warnings:

```bash
dotnet build /p:EnableNETAnalyzers=true
```

---

## 5. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows manually to confirm that core functionality behaves as expected.

---

## 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and address any failing tests. Failures may indicate behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

---

## 7. Validate Configuration Files

Cross-platform .NET uses `appsettings.json` rather than `Web.config` or `App.config`. Confirm the following:

- Connection strings have been moved to `appsettings.json`
- Any environment-specific settings are handled via `appsettings.{Environment}.json`
- The `Startup.cs` or `Program.cs` correctly reads configuration using `IConfiguration`

---

## 8. Verify Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment
- The database provider NuGet package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is present and up to date
- Any pending migrations are applied:

```bash
dotnet ef database update
```

---

## 9. Publish the Application

Once validation is complete, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all necessary files are present before deploying to the target environment.