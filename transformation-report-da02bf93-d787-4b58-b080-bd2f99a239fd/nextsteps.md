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

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the version of the .NET SDK you have installed on your machine.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the local URL provided in the console output and verify that the application loads and behaves as expected.

### 5. Run Existing Tests

If the solution contains any test projects, execute them to confirm existing functionality is preserved:

```bash
dotnet test
```

Review the test results for any failures that may indicate regressions introduced during the transformation.

### 6. Check for Removed or Incompatible APIs

Review the code for any usage of APIs that were available in the legacy .NET Framework but are not present in cross-platform .NET. Common areas to check include:

- `System.Web` namespace references (not available in .NET Core/.NET 5+)
- `HttpContext` usage outside of the ASP.NET Core request pipeline
- `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`
- `App.config` or `Web.config` sections that should be migrated to `appsettings.json`

### 7. Verify Static Files and Configuration

Confirm that any static assets, connection strings, and application settings have been correctly migrated from `Web.config` to `appsettings.json` and that they are being read correctly at runtime.

### 8. Test Data Access

If the project uses a database, verify that:

- Connection strings are correctly configured in `appsettings.json`
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- Data is being read and written correctly through the application UI.

### 9. Deploy to Target Environment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to your target hosting environment and verify the application runs correctly there.