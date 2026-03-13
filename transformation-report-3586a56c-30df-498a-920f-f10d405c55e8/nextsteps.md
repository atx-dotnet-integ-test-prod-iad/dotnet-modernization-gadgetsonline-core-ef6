# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform target, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it targets `net8.0` or `net6.0` and not a Windows-specific moniker such as `net48`.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the local URL provided in the console output and verify that the application loads and behaves as expected.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review the results for any failures that may indicate runtime regressions introduced during the migration, even if the build itself succeeded.

### 6. Check for Runtime Dependencies on Windows-Specific APIs

Even with a clean build, the application may reference Windows-specific APIs that will fail at runtime on Linux or macOS. Search the codebase for common problem areas:

- `System.Web` usage outside of compatibility shims
- `Registry` access via `Microsoft.Win32`
- Windows file path assumptions (backslashes, drive letters)
- `HttpContext.Current` usage, which is not available in ASP.NET Core

Address any findings by replacing them with cross-platform equivalents.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains the configuration previously held in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are served correctly and located under the `wwwroot` folder if this is a web project.
- Check that connection strings and environment-specific settings are correctly configured.

### 8. Deploy to Target Environment

Once local validation passes, publish the application for the target environment:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to the target server and run the executable or host it using the appropriate web server (e.g., Kestrel behind a reverse proxy such as Nginx or IIS).