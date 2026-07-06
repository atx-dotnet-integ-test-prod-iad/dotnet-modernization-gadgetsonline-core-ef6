# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without introducing any compilation errors.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the clean state:

```bash
dotnet build --configuration Release
```

Verify there are no warnings that could indicate deprecated APIs or framework incompatibilities that were not caught at compile time.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Ensure it is not inadvertently targeting `net48` or another legacy framework.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Address any failing tests before proceeding.

### 5. Check Runtime Behavior

Start the application locally and exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and any Entity Framework migrations
- Authentication and session handling, which can behave differently under ASP.NET Core compared to legacy ASP.NET
- Any file system paths that may have been hardcoded using Windows-style separators (`\`), which will not work on Linux or macOS

### 6. Review Removed or Changed APIs

Cross-platform .NET does not include certain Windows-specific APIs. Search the codebase for usages of the following and replace or remove them if present:

- `System.Web` namespace references
- `HttpContext.Current`
- `ConfigurationManager` (replace with `IConfiguration`)
- `System.Drawing` (replace with a cross-platform alternative such as `SkiaSharp` if image processing is required)

### 7. Validate Configuration Files

Ensure that `Web.config` or `App.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, application settings, and environment-specific values should all be present and correct.

### 8. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected assets, static files, and dependencies are present before deploying to the target environment.