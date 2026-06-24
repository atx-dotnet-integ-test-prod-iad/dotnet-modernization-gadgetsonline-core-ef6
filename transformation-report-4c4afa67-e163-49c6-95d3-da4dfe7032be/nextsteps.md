# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET has completed without any detected build-time issues.

## Validation Steps

### 1. Review the Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the following:

- The `<TargetFramework>` element targets a supported cross-platform .NET version (e.g., `net8.0` or `net6.0`).
- There are no remaining references to `net48`, `net472`, or other .NET Framework monikers.
- NuGet package references have been updated to versions compatible with the target framework.

### 2. Restore and Build from the Command Line

Run the following commands from the solution root to confirm a clean restore and build outside of the IDE:

```bash
dotnet restore
dotnet build
```

Review the output for any warnings that may indicate compatibility issues, deprecated APIs, or missing references that were not caught as hard errors.

### 3. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that the application starts without runtime exceptions and that core functionality is accessible.

### 4. Check for Runtime Compatibility Issues

Even with a clean build, runtime issues can surface. Pay attention to the following areas:

- **Data access**: If the project uses Entity Framework, confirm the correct EF Core provider is installed and that migrations are up to date by running `dotnet ef database update`.
- **Configuration**: Ensure `appsettings.json` is present and correctly structured, replacing any legacy `Web.config` or `App.config` values that may have been in use.
- **Authentication/Authorization**: If the project used ASP.NET Membership or legacy OWIN middleware, verify that the equivalent ASP.NET Core Identity or middleware has been configured correctly.
- **Static files and routing**: Confirm that static file serving and route configurations behave as expected under the new hosting model.

### 5. Execute Existing Tests

If the solution contains test projects, run them with:

```bash
dotnet test
```

Review any failing tests to determine whether they indicate functional regressions introduced during the migration.

### 6. Review Removed or Replaced APIs

Check the codebase for use of APIs that were available in .NET Framework but have changed behavior or been removed in .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with identifying these areas.

### 7. Validate on Target Operating Systems

Since the goal is cross-platform support, test the application on each intended operating system (e.g., Linux, macOS) to confirm there are no platform-specific issues such as:

- File path casing sensitivity
- Windows-only API calls (e.g., registry access, Windows-specific cryptography providers)
- Line ending differences in file processing

### 8. Review Publish Output

Perform a publish to confirm the output is complete and correct:

```bash
dotnet publish -c Release -o ./publish
```

Inspect the `./publish` directory to ensure all required assets, configuration files, and dependencies are present.