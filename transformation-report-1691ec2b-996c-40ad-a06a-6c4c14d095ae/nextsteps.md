# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation Steps

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

### 3. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Check for Removed or Changed APIs
Even without build errors, runtime issues can arise from APIs that behaved differently in .NET Framework. Pay particular attention to:

- `System.Web` usages, which are not available in cross-platform .NET. These are typically replaced by `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns.
- Any use of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- `Global.asax` lifecycle events, which should be migrated to middleware or `Program.cs` startup configuration.

### 5. Run the Application Locally
Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows, particularly any e-commerce flows such as product browsing, cart management, and checkout, to confirm expected behavior.

### 6. Review Static Files and Bundling
If the project previously used `System.Web.Optimization` for bundling and minification, confirm that static assets (CSS, JavaScript) are being served correctly. In ASP.NET Core, static files are served via `UseStaticFiles()` middleware and bundling is typically handled by tools such as LibMan or npm-based pipelines.

### 7. Verify Database Connectivity
If the project uses Entity Framework or ADO.NET, confirm that:

- The connection string in `appsettings.json` is correctly configured.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- Data access operations function correctly at runtime.

### 8. Review Authentication and Session Handling
ASP.NET Core handles authentication and session state differently from ASP.NET Framework. Confirm that:

- Forms Authentication has been replaced with ASP.NET Core Cookie Authentication or another appropriate scheme.
- Session state is configured in `Program.cs` using `AddSession()` and `UseSession()`.
- Any role-based or claims-based authorization attributes behave as expected.

### 9. Check Application Logs
Review the application logs during local execution for any runtime warnings or errors that would not surface at build time. Configure logging in `appsettings.json` if not already present:

```json
"Logging": {
  "LogLevel": {
    "Default": "Information",
    "Microsoft.AspNetCore": "Warning"
  }
}
```

### 10. Execute Existing Tests
If the solution contains test projects, run them to validate core functionality:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the migration.