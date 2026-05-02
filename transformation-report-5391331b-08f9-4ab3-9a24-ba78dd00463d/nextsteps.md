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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still targeting `net48` or another legacy framework, update it accordingly and re-run the build.

### 4. Run Unit Tests

If the solution contains any test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output for any failures or skipped tests that may indicate compatibility issues introduced during the migration.

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core features, paying particular attention to:

- Database connectivity and queries
- Authentication and session handling
- Any file system operations that may have platform-specific behavior
- Static file serving and routing

### 6. Check for Platform-Specific Code

Search the codebase for any remaining Windows-specific APIs or patterns that may not behave correctly on Linux or macOS:

- `Registry` access
- `System.Web` references that were not fully replaced
- `HttpContext.Current` usage
- `Server.MapPath` calls, which should be replaced with `IWebHostEnvironment.WebRootPath` or `ContentRootPath`

### 7. Review Configuration

Confirm that `web.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable. Verify that connection strings, application settings, and environment-specific values are correctly represented in the new configuration system.

### 8. Verify Static Files and wwwroot

Ensure that all static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as this is the expected location for static files in ASP.NET Core.

## Deployment

### 1. Publish the Application

Use the following command to publish the application to a folder:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Published Output

Inspect the `./publish` directory to confirm that all necessary files are present, including the compiled assemblies, `appsettings.json`, and the `wwwroot` folder.

### 3. Deploy to the Target Environment

Copy the contents of the `./publish` directory to your target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify the required runtime version from the `<TargetFramework>` value in the project file and download the corresponding hosting bundle or runtime from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).