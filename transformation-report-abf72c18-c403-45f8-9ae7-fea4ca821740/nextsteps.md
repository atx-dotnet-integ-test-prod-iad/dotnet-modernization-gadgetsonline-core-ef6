# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that core functionality behaves correctly after the migration.

### 5. Check for Removed or Changed APIs

Some APIs available in .NET Framework are not present or have changed in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages, which have updated APIs in ASP.NET Core.
- Any Windows-specific APIs (e.g., registry access, Windows identity) that may not function on non-Windows platforms.
- Any third-party libraries that may still target .NET Framework only. Check each package on [NuGet](https://www.nuget.org) to confirm cross-platform compatibility.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

### 7. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues.

### 8. Review Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains all configuration values previously held in `Web.config` or `App.config`.
- Ensure connection strings, API keys, and environment-specific settings have been correctly migrated.
- Validate that configuration is being read correctly at runtime using the `Microsoft.Extensions.Configuration` APIs.

### 9. Deployment

Once the application has been validated locally, publish it using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and deploy to your target hosting environment according to its standard deployment process.