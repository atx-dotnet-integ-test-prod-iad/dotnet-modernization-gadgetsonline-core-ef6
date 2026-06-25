# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build context:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that require attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows to check for runtime errors that would not surface at build time.

### 5. Execute Existing Tests

If the solution contains a test project, run all tests to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and resolve the underlying issues before proceeding.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any runtime usage of APIs that may not be available on non-Windows platforms:

```bash
dotnet tool install -g dotnet-compatibility
```

Pay particular attention to:
- `System.Web` usages that may have been replaced with ASP.NET Core equivalents
- Windows Registry access
- Windows-specific file path assumptions
- `HttpContext` and session handling differences in ASP.NET Core

### 7. Validate Static Assets and Configuration

- Confirm that `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are served correctly by checking the `wwwroot` folder structure.
- Ensure connection strings and any environment-specific settings are correctly configured.

### 8. Deployment

Once the above steps are completed and the application is verified locally:

1. Publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

2. Verify the contents of the `./publish` directory are complete.
3. Deploy the published output to the target hosting environment, such as IIS, Azure App Service, or a Linux server with the .NET runtime installed.
4. Confirm the hosting environment has the matching .NET runtime version installed.