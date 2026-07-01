# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Windows-Specific Dependencies

Inspect the project's NuGet package references and any remaining code for APIs that are Windows-only. Common areas to check include:

- `System.Drawing` (replaced by cross-platform alternatives such as `SkiaSharp` or `ImageSharp`)
- `Microsoft.Win32` registry access
- Any remaining references to `System.Web` which is not available in cross-platform .NET

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that business logic has not been affected by the migration:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression introduced during migration or a test that requires updating to align with the new framework.

### 7. Review Configuration Files

- Confirm that `appsettings.json` contains the necessary configuration that was previously held in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been correctly transferred.
- Check that `Startup.cs` or the top-level `Program.cs` middleware pipeline is configured correctly, including authentication, routing, and static files if applicable.

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version being used is Entity Framework Core and that:

- Migrations are present and up to date
- The database context is registered correctly in the dependency injection container
- Connection strings point to the correct database instance for your environment

Run the following to apply any pending migrations:

```bash
dotnet ef database update
```