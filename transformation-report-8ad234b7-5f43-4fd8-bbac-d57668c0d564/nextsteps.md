# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it to `net8.0`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm that pages load, data is retrieved correctly, and no unhandled exceptions occur.

### 5. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions introduced during the migration or test code that itself requires updating for the new framework.

### 6. Review Removed or Changed APIs

Check the application code for usage of any APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in .NET Core or later
- `HttpContext` and related types, which have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `Global.asax` logic, which should be migrated to `Program.cs` and `Startup.cs` (or the minimal hosting model)

### 7. Verify Static Files and Configuration

Confirm that static assets (CSS, JavaScript, images) are served correctly and that configuration files such as `appsettings.json` contain all necessary settings that were previously in `Web.config`. Connection strings, application settings, and any custom configuration sections should all be accounted for.

### 8. Test on Target Operating Systems

Since the goal of the migration is cross-platform compatibility, run and test the application on each operating system you intend to support (Windows, Linux, macOS) to surface any platform-specific issues such as file path casing sensitivity or platform-dependent libraries.

## Deployment

### 1. Publish the Application

Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

### 2. Verify Published Output

Inspect the `./publish` directory to confirm all required files are present, including the compiled assemblies, `appsettings.json`, and static web assets.

### 3. Configure the Web Server

Deploy the published output to your target web server. For cross-platform .NET web applications, configure either:

- **IIS on Windows**: Install the .NET Hosting Bundle and configure the site to use the ASP.NET Core Module.
- **Kestrel behind a reverse proxy on Linux**: Use Nginx or Apache as a reverse proxy forwarding requests to the Kestrel server process.

Ensure the server environment has the appropriate .NET runtime version installed that matches the target framework of the application.