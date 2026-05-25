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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to verify that runtime behavior matches expectations from the original legacy project.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the transformation or pre-existing issues.

### 6. Check for Platform-Specific Code

Search the codebase for any APIs or libraries that were previously Windows-specific, such as:

- `System.Web` references that may have been replaced with `Microsoft.AspNetCore`
- Registry access via `Microsoft.Win32`
- Windows Communication Foundation (WCF) usage
- Any P/Invoke calls targeting Windows-only system libraries

Run the application on each intended target platform (Windows, Linux, macOS) to surface any remaining platform-specific issues.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains the correct configuration values that were previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are included correctly in the project output.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- Connection strings in `appsettings.json` are correct for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy to the target hosting environment, such as IIS, a Linux server with the ASP.NET Core runtime installed, or Azure App Service.