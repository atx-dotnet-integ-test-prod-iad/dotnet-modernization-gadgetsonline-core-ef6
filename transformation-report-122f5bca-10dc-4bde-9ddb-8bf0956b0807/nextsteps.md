# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify that the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the core functionality to confirm it behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Review the code for usage of the following common areas of concern:

- `System.Web` namespace (not available in .NET Core/5+)
- `HttpContext` usage outside of ASP.NET Core's dependency injection
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-only APIs such as the registry or certain `System.Drawing` features

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any remaining compatibility issues.

### 7. Review Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, application settings, and environment-specific values should be present and correctly formatted.

### 8. Validate Database Connectivity

If the application uses a database, verify that the connection strings are correct and that the application can connect and perform basic operations against the database in the target environment.

### 9. Publish the Application

Once local validation is complete, publish the application to prepare it for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it behaves identically to the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Verify the application starts without errors and core functionality remains intact.