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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate modern TFM and that the project SDK is set to `Microsoft.NET.Sdk.Web`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are caused by the migration or pre-existing issues.

### 6. Check for Windows-Specific APIs

Search the codebase for APIs that may not be supported cross-platform, including but not limited to:

- `System.Web` references that were not fully replaced
- Windows registry access (`Microsoft.Win32.Registry`)
- Windows-only file path assumptions (backslash separators)
- `HttpContext.Current` usage

Replace any identified Windows-specific code with cross-platform equivalents.

### 7. Review Static Files and Configuration

- Confirm that `wwwroot` contains all required static assets.
- Verify that `appsettings.json` and `appsettings.{Environment}.json` contain all configuration values that were previously in `Web.config` or `App.config`.
- Check that connection strings and application settings have been correctly migrated.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required files are present, then deploy the contents to the target hosting environment.