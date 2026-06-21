# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Avoid using `netcoreapp` monikers as those frameworks are out of support.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, runtime issues can arise from APIs that were available in .NET Framework but behave differently or are absent in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace (not available in cross-platform .NET)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or WMI

### 5. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows and confirm expected behavior.

### 6. Review Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as required by ASP.NET Core's static file middleware.

### 7. Verify Configuration Files

Ensure that `appsettings.json` (and `appsettings.Development.json` if applicable) contain the correct configuration values previously held in `Web.config` or `App.config`. Confirm connection strings, app settings, and any environment-specific values are correctly migrated.

### 8. Run Unit Tests

If the solution contains test projects, execute them to validate that existing functionality is preserved:

```bash
dotnet test
```

Review any failing tests and address them before proceeding to deployment.

### 9. Test on Target Operating Systems

Since the goal is cross-platform compatibility, run the application on each intended operating system (e.g., Linux, macOS) to surface any platform-specific issues that would not appear on Windows.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.