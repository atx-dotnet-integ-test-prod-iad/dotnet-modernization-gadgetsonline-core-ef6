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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-specific framework such as `net48`, update it accordingly.

### 4. Check for Windows-Specific APIs

Search the codebase for any usage of APIs that are not supported on cross-platform .NET, such as:

- `System.Web` namespaces (common in legacy ASP.NET projects)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `System.Drawing` without the `System.Drawing.Common` NuGet package

Address any identified usages by replacing them with cross-platform alternatives.

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm functional correctness.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results for any failures that may have been introduced during the transformation.

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` (or equivalent configuration files) are present and correctly structured.
- Verify that any static files, views, or front-end assets are being served correctly when the application runs.
- Check that connection strings and environment-specific configuration values are accurate for the target environment.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.