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

Address any warnings that appear, as some may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version (e.g., `netcoreapp3.1` or `net5.0`), update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its primary features to check for runtime errors that would not surface at build time.

### 5. Check for Removed or Changed APIs

Even without build errors, some .NET Framework APIs behave differently or have been removed in cross-platform .NET. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they will cause runtime failures.
- **Windows-specific APIs**: Features such as the registry, certain cryptography providers, or Windows Communication Foundation (WCF) server-side components may require alternative implementations.
- **Entity Framework**: If the project uses Entity Framework 6, verify whether a migration to Entity Framework Core is needed or if the EF6 cross-platform package is in use.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and resolve the underlying issues they expose.

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Check that connection strings, application settings, and environment-specific values have been correctly migrated.
- Verify that static files (CSS, JavaScript, images) are located under the `wwwroot` folder if this is an ASP.NET Core web project.

### 8. Test on Target Operating Systems

If cross-platform support is a goal, run and test the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific runtime issues.

### 9. Review Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` and any `Startup.cs` to ensure:

- Middleware is registered in the correct order.
- Authentication, authorization, and session configuration match the original application's behavior.
- Routing is configured correctly.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and verify all required files are present before deploying to the target environment.