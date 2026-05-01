# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution appears to have completed successfully. No build errors were detected across any of the projects in the solution. Below are the recommended steps to validate, test, and deploy your migrated project.

## 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need to be updated.

## 2. Build the Solution

Perform a full build to confirm the absence of errors in the current environment.

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`).

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run `dotnet restore` and `dotnet build`.

## 4. Check for Removed or Changed APIs

Cross-platform .NET does not include certain APIs that were available in .NET Framework. Review the following areas:

- **`System.Web`**: This namespace is not available in modern .NET. If any references remain, they will need to be replaced with ASP.NET Core equivalents.
- **`HttpContext`**, **`HttpRequest`**, **`HttpResponse`**: Ensure these are sourced from `Microsoft.AspNetCore.Http` and not `System.Web`.
- **`ConfigurationManager`**: Replace with `Microsoft.Extensions.Configuration`.
- **`AppDomain`**: Some members may not be available or may behave differently.

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package if needed.

## 5. Run the Application Locally

Start the application locally to verify it runs as expected.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that core functionality is intact, including:

- User authentication and authorization
- Product browsing and search
- Shopping cart and checkout flows
- Database connectivity

## 6. Verify Database Connectivity and Migrations

If the project uses Entity Framework Core, verify that migrations are up to date and the database schema is correct.

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

If the project was previously using Entity Framework 6 (EF6), confirm that the migration to EF Core was handled correctly, as there are behavioral differences between the two.

## 7. Run Unit and Integration Tests

If a test project exists in the solution, execute all tests to verify that existing functionality has not regressed.

```bash
dotnet test
```

Review any failing tests and determine whether they are failing due to migration-related changes or pre-existing issues.

## 8. Review Static Files and wwwroot

In ASP.NET Core, static files (CSS, JavaScript, images) must be placed under the `wwwroot` folder. Confirm that:

- All static assets are located under `wwwroot`.
- `app.UseStaticFiles()` is present in the middleware pipeline (`Program.cs` or `Startup.cs`).

## 9. Validate Configuration Files

Ensure that `appsettings.json` contains the necessary configuration values that were previously stored in `Web.config`. Key areas to check include:

- Connection strings
- Application settings
- Logging configuration

`Web.config` is no longer the primary configuration source in ASP.NET Core.

## 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to your target environment.