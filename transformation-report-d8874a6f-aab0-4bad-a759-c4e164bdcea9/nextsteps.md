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

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for usage of APIs that may have been removed or altered in modern .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in .NET Core and later
- Windows-specific APIs if cross-platform support is required
- Any third-party libraries that may have .NET-specific versions or replacements

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to assist with this review.

### 7. Verify Configuration Files

Ensure that configuration previously held in `Web.config` or `App.config` has been properly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Confirm that connection strings, application settings, and environment-specific values are all accounted for.

### 8. Deploy to Target Environment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target hosting environment and verify the application starts and operates correctly there.