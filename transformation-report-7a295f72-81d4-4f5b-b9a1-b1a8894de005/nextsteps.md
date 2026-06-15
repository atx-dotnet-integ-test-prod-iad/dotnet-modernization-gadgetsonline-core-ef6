# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and review any warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that could indicate runtime issues, such as nullable reference warnings or obsolete API usage.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure the chosen framework version is a currently supported release of .NET.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between the legacy framework and the new target framework.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently or have been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available outside of ASP.NET on .NET Framework. If any references remain, they will need to be replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should use the ASP.NET Core versions.
- Any usage of `ConfigurationManager` should be replaced with `Microsoft.Extensions.Configuration`.
- Windows-specific APIs such as the registry, certain file path assumptions, or COM interop may not function correctly on non-Windows platforms.

### 6. Test Application Behavior at Runtime

Start the application locally and exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that:
- All routes and pages load correctly.
- Database connections are established and queries execute as expected.
- Authentication and session management function correctly.
- Static files are served properly.

### 7. Review Configuration Files

Confirm that `appsettings.json` (or equivalent) contains all necessary configuration values that were previously held in `Web.config` or `App.config`. The `Web.config` transformation system is not used in cross-platform .NET, so all environment-specific settings should be managed through `appsettings.{Environment}.json` or environment variables.

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version in use:

- **Entity Framework Core** is the supported version for cross-platform .NET.
- **Entity Framework 6** has limited support on .NET Core and later.

Run any pending migrations if applicable:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Cross-Platform Smoke Test

If cross-platform support is a goal, run the application on a non-Windows operating system or verify that no platform-specific assumptions exist in the code, such as hardcoded backslash path separators or Windows-specific environment variables. Use `Path.Combine` and `Path.DirectorySeparatorChar` where applicable.