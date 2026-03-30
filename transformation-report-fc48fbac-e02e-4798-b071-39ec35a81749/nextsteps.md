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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespaces — these are not available in cross-platform .NET and should have been replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` — confirm these reference `Microsoft.AspNetCore.Http` types.
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`.
- `Global.asax` — this should have been replaced with `Program.cs` and `Startup.cs` or the minimal hosting model.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL printed in the console output and verify that the application loads and behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 7. Verify Static Files and Configuration

- Confirm that `wwwroot` contains the expected static assets (CSS, JavaScript, images).
- Verify that `appsettings.json` contains the configuration values that were previously in `Web.config` or `App.config`.
- Check that connection strings and application settings have been correctly migrated.

### 8. Review Middleware and Request Pipeline

If this is a web application, open `Program.cs` or `Startup.cs` and confirm that the middleware pipeline is configured correctly, including:

- Authentication and authorization middleware
- Static file serving
- Routing
- Any custom HTTP modules or handlers that were migrated to middleware

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.