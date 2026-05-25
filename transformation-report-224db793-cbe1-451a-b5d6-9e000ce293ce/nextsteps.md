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
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows, such as browsing products, adding items to a cart, and completing a checkout, to confirm that core functionality is intact.

### 5. Check for Removed or Changed APIs

Since this is a migration from legacy .NET Framework, review the code for usage of APIs that have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in .NET Core or later.
- `HttpContext` and related types, which have changed in ASP.NET Core.
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- `EntityFramework` (classic), which should be replaced with `Microsoft.EntityFrameworkCore`.

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tool to identify any remaining incompatible API usages.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to migration-related changes or pre-existing issues.

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`.
- Verify that static files such as CSS, JavaScript, and images are served correctly by checking the `wwwroot` folder structure.
- Ensure connection strings and environment-specific settings are correctly configured for the target deployment environment.

### 8. Test on Target Operating System

If the goal of the migration is cross-platform support, run and test the application on the intended non-Windows operating system (Linux or macOS) to surface any platform-specific issues such as file path casing sensitivity or OS-specific API calls.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify that all required files are present before deploying to the target environment.