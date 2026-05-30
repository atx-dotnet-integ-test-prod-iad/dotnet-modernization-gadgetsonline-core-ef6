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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate version and that the project SDK is set to `Microsoft.NET.Sdk.Web`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review test results and investigate any failures that may indicate runtime regressions introduced during the migration.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may reference APIs that only function correctly on Windows. Search the codebase for usages of the following and assess whether cross-platform alternatives are needed:

- `System.Web` namespaces
- `Microsoft.Win32` registry access
- Windows file path assumptions (e.g., backslash separators)
- Windows-specific authentication or identity APIs

Use `RuntimeInformation.IsOSPlatform(OSPlatform.Windows)` guards where platform-specific code paths are unavoidable.

### 7. Verify Configuration and Middleware

If this is an ASP.NET Core application, confirm the following in `Program.cs` or `Startup.cs`:

- Middleware is registered in the correct order
- Connection strings and app settings have been migrated from `Web.config` to `appsettings.json`
- Any `System.Web.HttpContext` references have been replaced with `Microsoft.AspNetCore.Http.IHttpContextAccessor`

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment
- Entity Framework Core (if applicable) migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, configuration files, and dependencies are present before deploying to the target environment.