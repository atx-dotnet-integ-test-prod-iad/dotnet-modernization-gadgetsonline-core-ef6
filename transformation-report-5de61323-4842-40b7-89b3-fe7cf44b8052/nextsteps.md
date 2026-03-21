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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported version of .NET, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider upgrading to a long-term support (LTS) release.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its primary features to confirm they function as expected.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they are the result of the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may behave differently in ASP.NET Core
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` features

### 7. Verify Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable, and that the application reads configuration correctly at runtime.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the contents of the `./publish` directory to ensure all required files are present.

### 9. Smoke Test the Published Output

Run the published output directly to verify it behaves consistently with the locally run version:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Confirm the application starts without errors and responds correctly to requests.