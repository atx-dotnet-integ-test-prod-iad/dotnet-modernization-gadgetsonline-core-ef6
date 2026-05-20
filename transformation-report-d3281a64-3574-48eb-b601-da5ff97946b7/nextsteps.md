# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Navigate to the application in a browser and verify that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results for any failures that may indicate regressions introduced during the migration.

### 6. Check for Runtime-Only Issues

Some issues do not surface at compile time. Manually exercise the key workflows of the application, such as:

- Database connectivity and queries
- Authentication and session handling
- Any file system or path-dependent operations, as these may behave differently across operating systems

### 7. Review Removed or Replaced APIs

Check the codebase for any APIs that were available in .NET Framework but have changed behavior in cross-platform .NET, including:

- `System.Web` references, which should have been replaced by ASP.NET Core equivalents
- `ConfigurationManager`, which should be replaced by `Microsoft.Extensions.Configuration`
- `HttpContext.Current`, which is not available in ASP.NET Core

### 8. Deployment

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target server or hosting environment and ensure the correct .NET runtime version is installed on that machine.