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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these may indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime version installed on your target environment.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm runtime behavior matches expectations from the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or test code that itself requires updates for the new framework.

### 6. Check for Removed or Changed APIs

Review any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` dependencies, which are not available in cross-platform .NET and may have been replaced by `Microsoft.AspNetCore` equivalents
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- Any Windows-specific APIs such as the registry, WMI, or Windows identity APIs
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`

### 7. Validate Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `wwwroot` contents, and any view files (`.cshtml`) are present and correctly structured. Verify that connection strings and application settings have been migrated from `Web.config` to `appsettings.json`.

### 8. Test Against a Target Database

If the application uses a database, run the application against the intended database instance and verify that:

- Connections are established successfully
- Queries execute without error
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Review Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` (and `Startup.cs` if present) to confirm that middleware registration, routing, authentication, and authorization are configured correctly for the cross-platform .NET model.

### 10. Publish the Application

Once all validation steps pass, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents to the target environment.