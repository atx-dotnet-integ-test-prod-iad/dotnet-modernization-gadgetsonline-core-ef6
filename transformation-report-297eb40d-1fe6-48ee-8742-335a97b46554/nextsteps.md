# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it targets `net8.0` or `net6.0` and that the appropriate meta-package (e.g., `Microsoft.AspNetCore.App`) is referenced.

### 4. Run Unit Tests

If the solution contains test projects, execute them to validate runtime behavior:

```bash
dotnet test --configuration Release
```

Review test results and address any failing tests that may indicate behavioral differences introduced during the migration.

### 5. Check for Replaced or Removed APIs

Manually review areas of the code that previously relied on .NET Framework-specific APIs, such as:

- `System.Web` (replaced by `Microsoft.AspNetCore.*`)
- `HttpContext`, `HttpRequest`, `HttpResponse` usage patterns
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` logic (migrated to `Program.cs` / `Startup.cs`)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool to identify any remaining compatibility issues.

### 6. Verify Application Configuration

Confirm that configuration files have been properly migrated:

- `Web.config` settings should be moved to `appsettings.json`
- Connection strings should be present under the `ConnectionStrings` section in `appsettings.json`
- Environment-specific settings should use `appsettings.{Environment}.json`

### 7. Run the Application Locally

Start the application locally and exercise its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core features behave as expected, including database connectivity, authentication (if applicable), and page rendering.

### 8. Review Static Files and Bundling

If the project uses static files, CSS, or JavaScript bundling, confirm that the middleware is correctly configured in `Program.cs`:

```csharp
app.UseStaticFiles();
```

Bundling and minification previously handled by `BundleConfig.cs` may need to be replaced with a tool such as LibMan or a front-end build tool.

### 9. Verify Database Connectivity

If the project uses Entity Framework, confirm the version being used:

- Entity Framework 6 can run on .NET, but Entity Framework Core is recommended for new cross-platform projects.
- Run any pending migrations and verify the schema is correct:

```bash
dotnet ef database update
```

### 10. Deploy to a Target Environment

Once all local validation steps pass, publish the application to prepare it for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy them to the target hosting environment, such as IIS on Windows or a reverse-proxy setup with Kestrel on Linux.