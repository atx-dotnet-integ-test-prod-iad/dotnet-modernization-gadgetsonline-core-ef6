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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test
```

Review the test results and investigate any failures. If no tests currently exist, consider writing unit and integration tests for critical areas of the application such as data access, business logic, and any HTTP endpoints.

### 6. Check for Runtime-Only Issues

Some issues do not surface at compile time. Pay attention to the following areas during manual testing:

- **Configuration**: Verify that `appsettings.json` (or equivalent) is correctly structured and that values previously stored in `Web.config` or `App.config` have been migrated properly.
- **Database connectivity**: Confirm that connection strings are valid and that the application can connect to and query the database without errors.
- **Static files and routing**: If this is a web application, verify that static assets are served correctly and that all routes resolve as expected.
- **Authentication and authorization**: If the application uses any authentication middleware, confirm that it initializes and functions correctly under the new framework.

### 7. Review Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any calls to unsupported APIs that may only fail at runtime.

### 8. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.