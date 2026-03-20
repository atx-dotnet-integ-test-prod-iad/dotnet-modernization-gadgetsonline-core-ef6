# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to confirm runtime behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that need to be updated to reflect the new platform behavior.

### 6. Review Removed or Changed APIs

Cross-platform .NET removes or changes certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool to scan for any usage of APIs that may behave differently at runtime even if they compile successfully:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 7. Check Configuration and Middleware

If this is an ASP.NET Core project, verify the following:

- `Program.cs` and/or `Startup.cs` are correctly configured for the ASP.NET Core pipeline.
- Any `web.config` settings that were relevant in the legacy project have been migrated to `appsettings.json` or equivalent middleware configuration.
- Static files, routing, authentication, and session middleware are all registered correctly.

### 8. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm that:

- Connection strings in `appsettings.json` are correct for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Test on Target Operating Systems

Since the project is now cross-platform, validate it on each operating system you intend to support (Windows, Linux, macOS) to surface any platform-specific runtime issues such as file path casing, line endings, or OS-specific API usage.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents to the target environment.