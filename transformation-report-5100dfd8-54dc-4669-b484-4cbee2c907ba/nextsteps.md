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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and references `Microsoft.AspNetCore.App` where appropriate.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the core functionality, such as browsing products, adding items to a cart, and completing a checkout flow if applicable.

### 5. Run Existing Tests

If the solution contains a test project, execute the tests to confirm no regressions were introduced during the transformation:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or test code that also requires updating for the new framework.

### 6. Check Runtime Behavior for Common Migration Issues

Even with a clean build, runtime issues can surface. Pay attention to the following areas:

- **Configuration**: Ensure `web.config` or `app.config` settings have been migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Authentication and Authorization**: Verify any membership, identity, or session-based authentication is functioning correctly under ASP.NET Core's middleware pipeline.
- **Entity Framework**: If the project uses Entity Framework, confirm whether it has been migrated to EF Core and that database migrations or the existing schema are compatible.
- **Static Files**: Confirm that static assets (CSS, JS, images) are being served correctly. In ASP.NET Core, static files must reside in the `wwwroot` folder and `UseStaticFiles()` must be called in the middleware pipeline.
- **HTTP Handlers and Modules**: Any legacy `IHttpHandler` or `IHttpModule` implementations do not exist in ASP.NET Core and must be replaced with middleware.

### 7. Validate Database Connectivity

If the application connects to a database, confirm the connection string in `appsettings.json` is correct and that the application can read and write data as expected at runtime.

### 8. Review Deprecated or Removed APIs

Run the .NET Upgrade Analyzer or inspect the code manually for any use of APIs that were available in .NET Framework but have changed behavior or are no longer present in cross-platform .NET:

```bash
dotnet add package Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers
```

Address any analyzer warnings that appear after adding the package.

## Deployment

### 1. Publish the Application

Once validation is complete, publish the application to a folder for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Published Output

Inspect the `./publish` directory to confirm all expected files are present, including configuration files, static assets, and the compiled assemblies.

### 3. Deploy to the Target Environment

Copy the contents of the `./publish` directory to your target server or hosting environment. Ensure the target machine has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

### 4. Configure the Web Server

If hosting on IIS, install the [.NET Hosting Bundle](https://dotnet.microsoft.com/download) on the server and configure the IIS site to point to the published output directory. Ensure the application pool is set to **No Managed Code** since ASP.NET Core manages its own runtime.

If hosting on Linux with Nginx or Apache, configure a reverse proxy to forward requests to the Kestrel process running the application.