# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Verify that both commands complete with no errors or warnings that could indicate missing dependencies or unresolved references.

### 2. Review Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the following:

- The `<TargetFramework>` element targets a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`).
- All NuGet package references have version numbers that are compatible with the target framework.
- No legacy `<Reference>` entries point to Windows-only assemblies (e.g., `System.Web`).

### 3. Check for Runtime Dependencies

Some issues do not surface at compile time but will fail at runtime. Review the following areas:

- **Database connectivity**: If the project uses Entity Framework, confirm the correct provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) and that connection strings in `appsettings.json` are valid.
- **Authentication/Authorization**: If the project previously used `System.Web` membership or forms authentication, confirm these have been replaced with ASP.NET Core equivalents.
- **Static files and wwwroot**: Confirm that static assets (CSS, JS, images) have been moved to the `wwwroot` folder as expected by ASP.NET Core.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

- Navigate to the URL printed in the console output.
- Walk through the primary user-facing workflows (e.g., browsing products, adding to cart, checkout) to confirm expected behavior.
- Check the console output for any runtime exceptions or unhandled errors.

### 5. Review Configuration Files

- Confirm that `appsettings.json` (and `appsettings.Development.json`) contain all configuration values that were previously in `Web.config` or `App.config`.
- Verify that any environment-specific settings (connection strings, API keys) are present and correctly formatted.

### 6. Run Existing Tests

If the solution contains a test project, execute the tests to validate core functionality:

```bash
dotnet test
```

Review the test output for any failures and address them individually before proceeding.

### 7. Publish the Application

Once local validation is complete, produce a published build:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish
```

Review the contents of the `./publish` folder to confirm all expected files are present, including static assets and configuration files.

### 8. Verify on Target Operating System

If the goal is cross-platform deployment (e.g., Linux), run the published output on the target OS to confirm there are no platform-specific runtime issues:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Check for any exceptions related to file path casing, OS-specific APIs, or missing native dependencies.