# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

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

Navigate through the application and exercise the primary workflows to confirm that functionality has been preserved from the legacy version.

### 5. Execute Existing Tests

If the solution contains any test projects, run them to validate correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as failures may point to behavioral differences between the legacy framework and the new cross-platform .NET runtime.

### 6. Check for Windows-Specific Dependencies

Review the codebase for any APIs or libraries that were specific to the Windows platform and may not behave correctly on Linux or macOS. Common areas to inspect include:

- Registry access (`Microsoft.Win32.Registry`)
- Windows-specific file path assumptions (backslashes, drive letters)
- `System.Drawing` usage, which may require the `System.Drawing.Common` package with additional native dependencies on non-Windows platforms
- Any P/Invoke calls to Windows DLLs

### 7. Review Configuration and Connection Strings

Confirm that `appsettings.json` (or equivalent configuration files) are correctly set up for the new hosting model. Legacy `Web.config` or `App.config` values should have been migrated, but verify that:

- Database connection strings are present and correct
- Any environment-specific settings are properly handled using `appsettings.Development.json` or environment variables

### 8. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present before deploying to the target environment.