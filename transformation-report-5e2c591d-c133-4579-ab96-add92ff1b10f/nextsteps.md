# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality, particularly any areas that relied on Windows-specific APIs or legacy ASP.NET features prior to the transformation.

### 5. Review Replaced or Removed APIs

Check the codebase for any usage of APIs that may have been replaced during migration. Common areas to inspect include:

- `System.Web` references replaced by `Microsoft.AspNetCore`
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage updated to ASP.NET Core equivalents
- Session and authentication middleware configuration in `Program.cs` or `Startup.cs`
- Entity Framework 6 replaced by Entity Framework Core, including any raw SQL queries, lazy loading configuration, or database initializers

### 6. Run Existing Tests

If the solution contains a test project, execute the tests to confirm runtime behavior is correct:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to behavioral differences introduced by the migration or pre-existing issues.

### 7. Verify Static Files and Views

If this is a web application, confirm that:

- Razor views render correctly
- Static files such as CSS, JavaScript, and images are served properly
- Any `BundleConfig` or `RouteConfig` from the legacy project has been replaced with the appropriate ASP.NET Core middleware

### 8. Check Configuration Files

Ensure that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`, including:

- Connection strings
- Application settings
- Custom configuration sections

### 9. Deployment

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target server. Ensure the target server has the appropriate .NET runtime installed. You can verify the required runtime version with:

```bash
dotnet --info
```

If deploying to IIS, install the [.NET Hosting Bundle](https://dotnet.microsoft.com/en-us/download/dotnet) on the server and configure the application pool to use `No Managed Code`, as the ASP.NET Core module handles process management directly.