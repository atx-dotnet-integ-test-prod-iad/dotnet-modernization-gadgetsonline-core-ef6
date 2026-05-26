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

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating package references in the `.csproj` file.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

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

Navigate to the application in a browser and verify that core functionality behaves as expected. Pay particular attention to areas that relied on Windows-specific APIs or legacy ASP.NET features in the original project.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate correctness:

```bash
dotnet test
```

Review the test results and investigate any failures. Legacy tests may require updates if they referenced APIs or behaviors that have changed in cross-platform .NET.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool can help identify remaining compatibility concerns.

Common areas to check in a project like `GadgetsOnline`:

- **Database access**: Confirm Entity Framework or other data access libraries are updated to their cross-platform compatible versions.
- **Authentication/Authorization**: Verify that any membership or identity providers have been migrated to ASP.NET Core Identity if applicable.
- **Configuration**: Ensure `Web.config` settings have been migrated to `appsettings.json` and that `IConfiguration` is used throughout.
- **Static files and routing**: Confirm middleware is correctly configured in `Program.cs` or `Startup.cs`.

### 7. Validate Runtime Behavior on Target Platform

If the intended deployment platform is Linux or macOS, run the application on that platform explicitly to surface any remaining platform-specific issues such as:

- Case-sensitive file paths
- Windows-only libraries or P/Invoke calls
- File system permission differences

### 8. Review Publish Output

Perform a publish to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all necessary files, static assets, and configuration files are present.