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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to confirm there are no runtime exceptions that were not caught at compile time.

### 5. Run Existing Tests

If the solution contains a test project, run the test suite to validate that existing behavior has been preserved:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they represent regressions introduced during the transformation or pre-existing issues.

### 6. Check for Removed or Changed APIs

Even without build errors, some .NET Framework APIs behave differently or have been removed in cross-platform .NET. Pay particular attention to the following areas if they are used in the project:

- **`System.Web`**: This namespace is not available in cross-platform .NET. Any dependencies on it should have been replaced during transformation, but verify this at runtime.
- **`HttpContext` and session state**: Confirm these work as expected under ASP.NET Core if the project is a web application.
- **File system paths**: Ensure no hardcoded Windows-style paths exist, as these will fail on Linux and macOS.
- **Registry access**: `Microsoft.Win32.Registry` is not supported on non-Windows platforms.
- **Configuration**: Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` and are being read correctly.

### 7. Test on Target Platform

If the goal of the migration is to run on a non-Windows platform, run the application on that platform (Linux or macOS) to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm the application runs correctly from the published output:

```bash
dotnet ./publish/GadgetsOnline.dll
```