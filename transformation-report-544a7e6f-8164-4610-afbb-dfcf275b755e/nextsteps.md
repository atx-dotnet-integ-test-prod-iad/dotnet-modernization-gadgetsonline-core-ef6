# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Solution
Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally
Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to check for any runtime exceptions that would not have been caught at build time.

### 5. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm that all `System.Web` usages have been replaced with their ASP.NET Core equivalents.
- **HTTP Context access**: Ensure `HttpContext` is accessed via dependency injection rather than `HttpContext.Current`.
- **Session and Authentication**: Verify that session management and authentication middleware are configured correctly in `Program.cs` or `Startup.cs`.
- **Database connectivity**: If Entity Framework is used, confirm the project is using `Microsoft.EntityFrameworkCore` and not the legacy `System.Data.Entity` namespace.

### 6. Execute Unit Tests
If the solution contains test projects, run them to validate business logic:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that require updating due to API changes.

### 7. Verify Static Files and Configuration
- Confirm that `wwwroot` contains all required static assets (CSS, JavaScript, images).
- Review `appsettings.json` to ensure connection strings and application settings were correctly migrated from `Web.config`.
- If `Web.config` transformations were used previously, ensure equivalent configuration is present in `appsettings.{Environment}.json` files.

### 8. Test on Target Platform
If the goal is cross-platform support, run and test the application on the target operating system (Linux or macOS) to surface any platform-specific issues such as:

- Case-sensitive file paths
- Windows-specific registry or file system calls
- Platform-dependent NuGet packages