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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these may indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows to confirm that functionality has been preserved from the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they represent regressions introduced during the transformation or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET and must be replaced with `Microsoft.AspNetCore` equivalents.
- Windows-specific APIs such as the registry, certain `System.Drawing` features, or WCF server-side components.
- Any third-party NuGet packages that may have been targeting `.NET Framework` only. Verify that compatible versions exist for the new target framework.

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are correctly placed under the `wwwroot` folder if this is an ASP.NET Core web application.
- Check that connection strings and environment-specific settings are correctly configured.

### 8. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.