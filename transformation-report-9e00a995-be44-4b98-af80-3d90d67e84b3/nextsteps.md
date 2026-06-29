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

Review the output for any warnings about deprecated packages or version conflicts that may cause runtime issues even if they do not produce build errors.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it, as those versions are out of support.

### 4. Run the Application Locally
Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality, paying attention to any runtime errors that would not have been caught at build time.

### 5. Check for Removed or Changed APIs
Even with a clean build, some .NET Framework APIs may have been replaced or removed in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, session state, and authentication middleware, which require explicit configuration in `Program.cs` or `Startup.cs` in modern .NET.
- Any database access layers (e.g., Entity Framework) should be confirmed to be using the correct cross-platform version (`Microsoft.EntityFrameworkCore` rather than `System.Data.Entity`).

### 6. Run Existing Tests
If the solution contains any test projects, execute them to validate that behavior has not changed during the transformation:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Check Static Files and Web Assets
If this is a web application, verify that static files (CSS, JavaScript, images) are being served correctly. In cross-platform .NET, static file serving must be explicitly enabled in the middleware pipeline:

```csharp
app.UseStaticFiles();
```

Confirm this call is present in `Program.cs` or `Startup.cs`.

### 8. Validate Configuration Files
Ensure that `appsettings.json` contains all configuration values that were previously held in `Web.config` or `App.config`. Connection strings, application settings, and environment-specific values should all be accounted for.

### 9. Publish the Application
Once local validation is complete, produce a published output to confirm the release artifact is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.