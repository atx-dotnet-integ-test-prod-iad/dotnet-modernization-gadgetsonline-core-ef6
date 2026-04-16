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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.AspNetCore.App` or the appropriate framework.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify that runtime behavior matches the expected behavior from the legacy version.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related types if this is a web project
- Windows-specific APIs such as the registry, WCF, or Windows Forms (if applicable)
- Any third-party libraries that may have been targeting .NET Framework exclusively

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to behavioral differences between .NET Framework and the new target framework.

### 7. Check Static Files and Configuration

If this is a web application, verify the following:

- `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`
- Static files, views, and assets are in the correct directories expected by the new project structure
- Connection strings and environment-specific settings are correctly configured

### 8. Review Middleware and Startup Configuration

If the project uses ASP.NET Core, review the `Program.cs` or `Startup.cs` file to ensure:

- Middleware is registered in the correct order
- Services such as authentication, authorization, and database contexts are properly configured
- Any legacy HTTP modules or HTTP handlers have been replaced with equivalent ASP.NET Core middleware