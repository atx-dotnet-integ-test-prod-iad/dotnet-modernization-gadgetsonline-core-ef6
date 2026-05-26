# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated project.

---

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest Long Term Support (LTS) release.

---

## 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality such as routing, data access, and any authentication mechanisms behave correctly.

---

## 5. Check for Runtime Errors

Pay close attention to the following areas that commonly surface issues at runtime even when the build succeeds:

- **Database connectivity**: Confirm connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date. Run pending migrations if necessary:
  ```bash
  dotnet ef database update
  ```
- **Static files and middleware**: Verify that `app.UseStaticFiles()` and other middleware registrations in `Program.cs` or `Startup.cs` are correctly ordered.
- **Configuration**: Ensure all keys previously stored in `Web.config` have been moved to `appsettings.json` or environment variables.

---

## 6. Execute Tests

If the solution contains a test project, run all tests to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or test code that requires updating due to the migration.

---

## 7. Review Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Manually review the code for usage of the following common problem areas:

- `System.Web` namespace references
- `HttpContext` usage patterns
- Windows-specific APIs such as the registry or WCF server-side components
- `BinaryFormatter` (removed in .NET 9, deprecated in earlier versions)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) if a more thorough scan is needed.

---

## 8. Publish the Application

Once local validation is complete, publish the application to a target folder:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` folder and confirm all required assets, configuration files, and binaries are present before deploying to the target environment.