# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution. The `GadgetsOnline` project compiled without issues under the new cross-platform .NET target.

---

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need to be updated.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only TFM such as `net48` or `net472`.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Check for Windows-Specific Dependencies

Even without build errors, the project may still reference APIs or packages that only function on Windows. Run the .NET compatibility analyzer or review the project for usage of:

- `System.Web` types (e.g., `HttpContext`, `HttpRequest` from the old namespace)
- Windows Registry access (`Microsoft.Win32`)
- COM interop or P/Invoke calls targeting Windows-only libraries
- Any remaining references to `System.Web.Mvc` instead of `Microsoft.AspNetCore.Mvc`

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not changed:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework runtime and the new .NET runtime.

### 6. Verify Application Startup

Run the application locally and navigate through its core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Check the following areas manually:

- Application starts without runtime exceptions
- Database connections (if any) are functioning correctly
- Authentication and session handling behave as expected
- Static files and routing resolve correctly

### 7. Review Configuration Files

Ensure that `web.config` (if still present) has been replaced or supplemented by `appsettings.json` and that configuration is being read through `IConfiguration`. Legacy `web.config` transforms and `ConfigurationManager` calls may not behave as expected in cross-platform .NET.

### 8. Check Middleware Pipeline

If this is an ASP.NET Core project, review `Program.cs` or `Startup.cs` to confirm the middleware pipeline is correctly configured, including:

- Exception handling middleware
- Static file serving
- Authentication/Authorization middleware
- Routing

---

## Deployment

### 1. Publish the Application

Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Published Output

Inspect the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and the compiled binaries.

### 3. Confirm Runtime is Available on the Target Server

Ensure the target server has the appropriate .NET runtime installed. You can verify this with:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

### 4. Test in a Staging Environment

Deploy the published output to a staging environment that mirrors production as closely as possible before promoting to production. Validate all critical application paths in that environment before final deployment.