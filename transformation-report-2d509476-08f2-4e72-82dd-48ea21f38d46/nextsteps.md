# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating or replacing packages in the relevant `.csproj` file.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Confirm the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `net6.0`), consider updating it to a current supported version.

### 4. Run Unit Tests

If the solution contains test projects, execute all tests to verify existing functionality has not regressed.

```bash
dotnet test
```

Review the test output and investigate any failing tests to determine if they are caused by behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 5. Check for Windows-Specific APIs

Search the codebase for APIs that were available in .NET Framework but are unsupported or behave differently in cross-platform .NET. Common areas to inspect include:

- `System.Web` usages (not available in cross-platform .NET)
- `HttpContext` and related ASP.NET pipeline components
- Registry access (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- `AppDomain` usage

Use the .NET Upgrade Assistant compatibility analyzer or the [.NET API compatibility tool](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/api-compat) to identify any remaining problem areas.

### 6. Run the Application Locally

Start the application and exercise its primary workflows to confirm runtime behavior is correct.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Test the main features manually, paying particular attention to areas that rely on data access, authentication, or external service integrations, as these are common sources of runtime issues after migration.

### 7. Review Configuration Files

Confirm that configuration has been correctly migrated from `Web.config` or `App.config` to the appropriate `appsettings.json` format. Verify that:

- Connection strings are present and correct
- Application settings have been transferred
- Environment-specific configuration is handled using `appsettings.{Environment}.json` where appropriate

### 8. Verify Static Assets and Middleware (If Web Project)

If `GadgetsOnline` is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Ensure that any legacy `Global.asax` logic has been moved into the appropriate middleware or startup configuration.

## Deployment

Once all validation steps above pass without issue:

1. Publish the application using the following command, targeting the appropriate runtime if needed:

```bash
dotnet publish --configuration Release --output ./publish
```

2. Verify the contents of the `./publish` directory are complete.
3. Deploy the published output to the target environment according to your hosting setup (IIS, self-hosted, Linux server, etc.).
4. After deployment, perform a smoke test against the live environment to confirm the application is functioning as expected.