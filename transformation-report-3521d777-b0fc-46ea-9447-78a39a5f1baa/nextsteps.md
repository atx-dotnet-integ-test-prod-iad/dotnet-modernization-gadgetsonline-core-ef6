# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or packages that could not be resolved.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, as some may indicate compatibility issues that do not prevent compilation but could cause runtime problems.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to identify any APIs used in the project that have been removed or altered in the target framework version:

```bash
dotnet tool install -g dotnet-apicompat
```

Pay particular attention to:
- `System.Web` usages, which are not available in cross-platform .NET
- Any Windows-specific APIs if cross-platform support is required
- Third-party NuGet packages that may still target .NET Framework only

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as they may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 6. Perform Manual Smoke Testing

Run the application locally and exercise its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Specifically verify:
- Application startup completes without exceptions
- Database connectivity functions correctly, if applicable
- Core user-facing features behave as expected
- Any file I/O or path-handling logic works correctly across operating systems if cross-platform support is a goal

### 7. Review Configuration Files

Confirm that configuration files have been migrated correctly:
- `web.config` or `app.config` settings should be moved to `appsettings.json` if not already done
- Connection strings, application settings, and environment-specific values should be validated
- Any `system.web` configuration sections in `web.config` are not applicable in cross-platform .NET and should be removed or replaced

### 8. Validate Static Assets and Middleware

If this is a web project, confirm that:
- Static file serving is configured via `app.UseStaticFiles()` in the middleware pipeline
- Authentication and authorization middleware has been correctly ported from the old `HttpModule`/`HttpHandler` model to ASP.NET Core middleware
- Routing behavior matches the original application

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present before deploying to the target environment.