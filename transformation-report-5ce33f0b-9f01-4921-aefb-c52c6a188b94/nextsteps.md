# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution appears to have transformed successfully. No build errors were detected in any of the projects, including `GadgetsOnline/GadgetsOnline.csproj`. The following steps outline how to validate, test, and deploy the migrated project.

---

## 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas that may cause runtime issues.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

---

## 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` references — these are not available in .NET 5+. If found, they need to be replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages — confirm these are using the ASP.NET Core versions.
- `ConfigurationManager` — replace with `Microsoft.Extensions.Configuration`.
- `Global.asax` — this should be replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model).

---

## 5. Verify Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, as this is required by ASP.NET Core.

---

## 6. Database and Entity Framework Checks

If the project uses Entity Framework, confirm the correct version is referenced:

- For EF Core, ensure packages such as `Microsoft.EntityFrameworkCore` and the appropriate database provider (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) are present in the `.csproj`.
- Run any pending migrations or verify the database schema is compatible:

```bash
dotnet ef database update
```

---

## 7. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL indicated in the console output and verify that the application loads and core functionality works as expected.

---

## 8. Run Existing Tests

If there are test projects in the solution, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

---

## 9. Review Application Configuration

Confirm that `appsettings.json` contains the necessary configuration values that were previously in `web.config` or `app.config`. Pay particular attention to:

- Connection strings
- Application-specific settings
- Environment-specific overrides (`appsettings.Development.json`, etc.)

---

## 10. Publish the Application

Once the application has been validated locally, publish it using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` folder and deploy it to the target hosting environment, such as IIS, Azure App Service, or a Linux server with the .NET runtime installed.

For IIS hosting, ensure the **ASP.NET Core Hosting Bundle** is installed on the server and that the application pool is set to **No Managed Code**.