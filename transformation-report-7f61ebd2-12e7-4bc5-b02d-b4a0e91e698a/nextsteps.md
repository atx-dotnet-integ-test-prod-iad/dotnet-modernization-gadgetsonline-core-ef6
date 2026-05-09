# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Confirm the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and not a legacy `netcoreapp` moniker.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **HTTP Modules and Handlers**: These do not exist in modern .NET. Confirm they have been replaced with middleware.
- **`System.Web` dependencies**: This namespace is not available in cross-platform .NET. Confirm no remaining references exist.
- **`ConfigurationManager`**: If used, confirm it has been replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: Confirm it has been replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model).

### 5. Run the Application Locally

Start the application and verify it runs without runtime errors.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows, such as browsing products, adding items to a cart, and completing a purchase if applicable.

### 6. Check Application Configuration

Review `appsettings.json` to confirm that all settings previously in `Web.config` have been migrated correctly, including:

- Connection strings
- Application-specific settings
- Logging configuration

If a `Web.config` file still exists in the project, it should only contain IIS-specific settings such as the ASP.NET Core module handler configuration. It should not contain application settings.

### 7. Verify Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the application can connect to the database at runtime. If Entity Framework is used, run any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Execute Unit Tests

If a test project exists in the solution, run all tests to confirm expected behavior is preserved.

```bash
dotnet test
```

Review any failing tests and address them before proceeding to deployment.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and the compiled binary.