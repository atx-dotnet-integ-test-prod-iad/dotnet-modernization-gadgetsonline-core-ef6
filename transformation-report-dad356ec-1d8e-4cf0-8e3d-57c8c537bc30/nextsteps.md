# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated `GadgetsOnline` project.

---

## 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies. If any packages are not compatible with the target .NET version, locate alternatives on [NuGet.org](https://www.nuget.org).

---

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues beyond what was reported.

```bash
dotnet build --configuration Release
```

Address any warnings that may surface, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

---

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`).

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework needs to be updated, modify this value and re-run `dotnet restore` and `dotnet build`.

---

## 4. Check for Removed or Changed APIs

Cross-platform .NET does not include certain APIs that were available in .NET Framework. Run the .NET Upgrade Assistant compatibility analyzer or the platform compatibility analyzer to identify any runtime issues that would not surface as build errors.

```bash
dotnet add package Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers
```

Review any analyzer warnings in your IDE or build output.

---

## 5. Verify Configuration Files

- Confirm that `web.config` transformations or `app.config` entries have been migrated to `appsettings.json` where applicable.
- Check that connection strings, application settings, and environment-specific values are correctly represented in `appsettings.json` or `appsettings.{Environment}.json`.

---

## 6. Run Unit Tests

If the solution contains test projects, execute them to validate that existing functionality behaves as expected after migration.

```bash
dotnet test --configuration Release
```

Review test results and investigate any failures, as they may indicate behavioral differences between .NET Framework and modern .NET.

---

## 7. Manual Functional Testing

Run the application locally and exercise its primary features manually.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and Entity Framework queries, if applicable.
- Authentication and session management.
- Any file system operations, as path handling differs across platforms.
- HTTP client usage and external service integrations.

---

## 8. Validate Static Assets and Middleware

If this is a web application, confirm that:
- Static files are served correctly via `UseStaticFiles()`.
- Middleware is registered in the correct order in `Program.cs` or `Startup.cs`.
- Routing behaves as expected for all defined endpoints.

---

## 9. Publish the Application

Once testing is complete, publish the application to verify the output is correct before deployment.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present.

---

## 10. Deploy

Copy the contents of the `./publish` directory to your target hosting environment. Ensure the target machine has the appropriate .NET runtime installed.

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).