# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated project.

---

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

---

## 4. Check for Replaced or Removed APIs

Cross-platform .NET removes or replaces certain Windows-specific APIs that were available in .NET Framework. Review the code for usage of the following:

- `System.Web` namespaces (replaced by `Microsoft.AspNetCore`)
- `HttpContext` usage patterns that differ between ASP.NET and ASP.NET Core
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` lifecycle events (replaced by `Program.cs` and `Startup.cs` or top-level statements)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) if a thorough API audit is needed.

---

## 5. Validate Application Configuration

Confirm that configuration files have been migrated correctly:

- `Web.config` settings should now reside in `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings should be accessible via `IConfiguration`
- Any `<system.web>` or `<system.webServer>` settings should be reviewed and replaced with ASP.NET Core middleware equivalents

---

## 6. Run Existing Tests

If a test project exists in the solution, execute the tests to verify functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests to determine whether failures are due to migration-related behavioral changes or pre-existing issues.

---

## 7. Manual Smoke Testing

Run the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Test the following areas at minimum:

- Application startup and home page rendering
- Navigation between pages
- Any database read and write operations
- Authentication and authorization flows if present
- Static file serving (CSS, JavaScript, images)

---

## 8. Review Middleware and Startup Configuration

If the project uses ASP.NET Core, review `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order
- Services such as Entity Framework, Identity, or session are properly configured
- HTTPS redirection and static files middleware are present if required

---

## 9. Database Migrations

If the project uses Entity Framework Core, verify that migrations are up to date:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

If the project was previously using Entity Framework 6, confirm it has been migrated to Entity Framework Core and that all queries function as expected.

---

## 10. Publish the Application

Once validation is complete, publish the application to a target folder:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present before deploying to the target environment.