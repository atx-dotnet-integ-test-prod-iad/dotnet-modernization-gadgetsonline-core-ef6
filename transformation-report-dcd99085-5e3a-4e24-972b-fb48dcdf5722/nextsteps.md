# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns that should be addressed.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to verify runtime behavior matches expectations from the legacy version.

### 5. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

### 6. Review Replaced or Removed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed behavior in cross-platform .NET. Common areas to review include:

- `System.Web` references or any shims used to replace them
- `HttpContext` and related middleware
- Configuration APIs (`ConfigurationManager` vs `Microsoft.Extensions.Configuration`)
- Entity Framework version and provider compatibility
- Windows-specific APIs (registry access, `System.Drawing`, etc.)

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `web.config` (if retained for IIS hosting), and any static content are present and correctly structured for the new hosting model.

### 8. Test on Target Operating System

If cross-platform support is a goal, run the application on the intended non-Windows operating system (Linux or macOS) to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correctly structured:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all required files are present before deploying to the target environment.