# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify that runtime behavior matches expectations from the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and determine whether they represent regressions introduced during the transformation or pre-existing issues.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to scan for any runtime-level compatibility issues that do not surface as build errors.

Particular areas to review for a web project such as `GadgetsOnline`:

- **HTTP Modules and Handlers**: These do not exist in ASP.NET Core. Ensure they have been replaced with middleware.
- **Session and Authentication**: Confirm that session management and authentication mechanisms have been migrated to their ASP.NET Core equivalents.
- **Web.config**: ASP.NET Core uses `appsettings.json` and the `IConfiguration` system. Verify that all configuration values from `Web.config` have been carried over correctly.
- **Static Files**: Confirm that static file serving is configured via `UseStaticFiles()` in the middleware pipeline.

### 7. Database Connectivity

If the application uses a database, verify that connection strings in `appsettings.json` are correct and that the application can connect and perform operations as expected in the target environment.

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is well-formed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all expected assets, configuration files, and binaries are present.

### 9. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/en-us/download](https://dotnet.microsoft.com/en-us/download).

Start the application on the target environment and perform a final round of smoke testing against the deployed instance.