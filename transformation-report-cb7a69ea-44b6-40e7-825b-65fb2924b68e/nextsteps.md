# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the local URL provided in the console output and verify that the application loads and functions as expected.

### 5. Execute Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Runtime Compatibility Issues

Even with a clean build, certain APIs that were available in .NET Framework may behave differently or be absent at runtime in cross-platform .NET. Pay particular attention to:

- **Windows-specific APIs**: Features such as `System.Web`, `HttpContext`, registry access, or Windows Communication Foundation (WCF) that may have been used in the legacy project.
- **Third-party libraries**: Confirm that all NuGet dependencies have versions compatible with the target framework by reviewing each package on [nuget.org](https://www.nuget.org).
- **Entity Framework**: If the project uses Entity Framework, confirm whether it has been migrated to Entity Framework Core and that database migrations are functioning correctly.
- **Configuration**: Verify that `web.config` or `app.config` settings have been appropriately migrated to `appsettings.json` or environment-based configuration.

### 7. Static Analysis

Run the .NET upgrade analyzer tools to surface any remaining compatibility concerns:

```bash
dotnet add package Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers
dotnet build
```

Review any analyzer diagnostics in the build output.

### 8. Deployment

Once the application has been validated locally:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

2. Copy the contents of the `publish` output folder to your target server or hosting environment.
3. Confirm the correct .NET runtime version is installed on the target machine by running:

```bash
dotnet --version
```

4. Start the application on the target environment and perform a final smoke test to confirm it is operating correctly.