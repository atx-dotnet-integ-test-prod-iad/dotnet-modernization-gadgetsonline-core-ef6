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

Review the output for any warnings related to package compatibility or deprecated packages that may need updating.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to nullable reference types, obsolete APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test the primary user flows, such as browsing products, adding items to a cart, and completing a checkout, if applicable.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to confirm no regressions were introduced during the transformation:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Legacy .NET Framework projects often rely on APIs that have been removed or altered in cross-platform .NET. Manually review the following areas:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Ensure any such references have been replaced with ASP.NET Core equivalents.
- **`HttpContext` and `HttpRequest` usage**: Verify these have been updated to use the ASP.NET Core versions.
- **`ConfigurationManager`**: This should be replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: This should have been replaced by `Program.cs` and `Startup.cs` (or the minimal hosting model in .NET 6+).

### 7. Validate Configuration Files

Confirm that `appsettings.json` contains all necessary configuration values that were previously in `web.config`. Pay particular attention to:

- Database connection strings
- Application-specific settings
- Authentication configuration

### 8. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` is correct and that the application can connect successfully at runtime. Run any pending Entity Framework migrations if applicable:

```bash
dotnet ef database update
```

---

## Deployment

### 1. Publish the Application

Once validation is complete, publish the application to a local folder to verify the published output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present.

### 2. Test the Published Output

Run the published output directly to confirm it behaves the same as the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

### 3. Verify on Target Operating System

If the goal of the migration was cross-platform support, test the published output on each target operating system (Windows, Linux, macOS) to confirm there are no platform-specific issues.