# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets a current and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it targets `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are out of support or approaching end of life.

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key pages and features to confirm expected behavior.

### 5. Check for Removed or Changed APIs

Legacy ASP.NET projects commonly rely on APIs that have changed or been removed in cross-platform .NET. Specifically, review the following areas:

- **`System.Web` dependencies**: These do not exist in .NET Core and beyond. Search the codebase for any remaining `using System.Web;` references.
- **`HttpContext` usage**: Ensure access to `HttpContext` is done via dependency injection rather than the static `HttpContext.Current`.
- **`ConfigurationManager`**: Replace any usage with `Microsoft.Extensions.Configuration` and the `appsettings.json` pattern.
- **`Global.asax`**: Confirm this has been replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model).

### 6. Validate Database Connectivity

If the project uses Entity Framework or direct database access:

- Confirm the connection string in `appsettings.json` is correct for the target environment.
- Run any pending migrations if using Entity Framework:

```bash
dotnet ef database update
```

- Verify that the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is the correct version for the target framework.

### 7. Execute Unit Tests

If a test project exists within the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 8. Review Static Files and Bundling

Legacy projects may have used `System.Web.Optimization` for bundling and minification. Confirm that static file serving is configured correctly in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

Replace any legacy bundling mechanisms with a supported alternative such as `WebOptimizer` or a front-end build tool.

### 9. Deployment

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and deploy to the target server or hosting environment, ensuring the correct .NET runtime version is installed on that machine.