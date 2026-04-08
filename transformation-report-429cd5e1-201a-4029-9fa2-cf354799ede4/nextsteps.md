# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Ensure both commands complete with no warnings or errors before proceeding.

### 2. Review Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the following:

- The `<TargetFramework>` element targets the intended .NET version (e.g., `net8.0` or `net6.0`).
- Any previously Windows-specific NuGet packages (e.g., `System.Web`, legacy ASP.NET packages) have been replaced with their cross-platform equivalents.
- No `<Reference>` elements point to GAC assemblies or absolute Windows paths.

### 3. Check for Removed or Changed APIs

Review your source code for any usage of APIs that were available in .NET Framework but are absent or behave differently in modern .NET:

- `System.Web` namespace (not available in .NET Core/.NET 5+).
- `HttpContext`, `HttpRequest`, and `HttpResponse` should come from `Microsoft.AspNetCore.Http`, not `System.Web`.
- `ConfigurationManager` should be replaced with `Microsoft.Extensions.Configuration`.
- `System.Drawing` may require the `System.Drawing.Common` NuGet package and has platform restrictions on non-Windows systems.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

- Navigate through the application's main workflows in a browser.
- Check the console output for any runtime exceptions or middleware errors.
- Verify that database connections, if any, are established successfully.

### 5. Validate Configuration Files

- Confirm that `appsettings.json` (and `appsettings.Development.json`) contain all settings previously held in `Web.config` or `App.config`.
- Verify connection strings are correctly formatted for the target database provider.
- Check that any environment-specific settings are properly separated.

### 6. Test Data Access Layer

If the project uses Entity Framework:

- Confirm the correct version of EF Core is referenced (`Microsoft.EntityFrameworkCore`).
- Run any pending migrations:

```bash
dotnet ef database update
```

- Verify that queries return expected results at runtime.

### 7. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to behavioral differences between .NET Framework and modern .NET.

### 8. Cross-Platform Smoke Test

If cross-platform support is a goal, run the application on a non-Windows OS (Linux or macOS) to identify any remaining platform-specific dependencies:

- File path separators (`\` vs `/`) — use `Path.Combine` throughout.
- Case-sensitive file systems on Linux may expose issues with static file references.
- Any P/Invoke or native library calls should be verified for availability on the target OS.

### 9. Review Static Files and Bundling

If the project serves static assets:

- Confirm that `wwwroot` is structured correctly and that static files middleware is configured in `Program.cs` or `Startup.cs`.
- If bundling and minification were previously handled by `BundleConfig.cs`, verify that an equivalent mechanism (e.g., `BuildBundlerMinifier` or a front-end build tool) is in place.

### 10. Publish the Application

Once all validation steps pass, publish the application:

```bash
dotnet publish -c Release -o ./publish
```

Review the output in the `./publish` directory and confirm all required files are present before deploying to the target environment.