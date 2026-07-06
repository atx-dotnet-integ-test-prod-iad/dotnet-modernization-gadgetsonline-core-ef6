# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are properly restored:

```bash
dotnet restore
```

Verify that no warnings or errors are reported during the restore process.

### 2. Build the Solution

Perform a full build to confirm the absence of any compile-time errors:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that may indicate compatibility issues, even if they do not prevent a successful build.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing a Windows-only framework such as `net48`, update it accordingly.

### 4. Check for Windows-Specific APIs

Search the codebase for any usage of Windows-specific APIs or libraries that may not be available on Linux or macOS. Common areas to check include:

- `System.Web` namespace references (not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- Any P/Invoke calls targeting Windows-only DLLs

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm expected behavior is preserved after the migration.

### 6. Execute Existing Tests

If a test project exists within the solution, run the test suite to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the transformation.

### 7. Verify Static Assets and Configuration Files

- Confirm that `appsettings.json` (or equivalent configuration files) are present and correctly structured.
- Verify that any static files, views, or front-end assets are located in the expected directories for the new project structure (e.g., `wwwroot` for ASP.NET Core projects).
- Check that connection strings and environment-specific settings have been migrated from `Web.config` to `appsettings.json` if this is an ASP.NET Core project.

### 8. Check Middleware and Startup Configuration

If this is an ASP.NET Core web project, review `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order.
- Services such as authentication, authorization, Entity Framework, and routing are properly configured.
- Any legacy `HttpModule` or `HttpHandler` registrations from `Web.config` have been replaced with the appropriate ASP.NET Core middleware equivalents.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files are present before deploying to the target environment.