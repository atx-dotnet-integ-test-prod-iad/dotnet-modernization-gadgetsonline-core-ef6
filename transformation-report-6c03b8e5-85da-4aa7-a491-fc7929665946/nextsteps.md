# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently on cross-platform .NET compared to .NET Framework.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality is preserved:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as they may indicate behavioral differences between .NET Framework and modern .NET (e.g., changes in `System.Web`, serialization, or globalization behavior).

### 4. Check for Removed or Changed APIs

Review the code for usage of APIs that are known to behave differently or are unavailable in cross-platform .NET:

- **`System.Web`**: This namespace is not available in cross-platform .NET. If any references remain, they will need to be replaced with ASP.NET Core equivalents.
- **`HttpContext`**, **`HttpRequest`**, **`HttpResponse`**: Ensure these are using the ASP.NET Core versions and not the `System.Web` versions.
- **`ConfigurationManager`**: Replace with `Microsoft.Extensions.Configuration` if not already done.
- **`BinaryFormatter`**: This has been disabled by default in modern .NET due to security concerns. Replace with a supported serialization mechanism if used.

### 5. Verify Runtime Behavior

Run the application locally and manually exercise the primary workflows, particularly:

- User authentication and session management
- Database connectivity and data retrieval (verify connection strings in `appsettings.json`)
- Any file I/O operations, as path separators and file system behavior differ between Windows and Linux/macOS

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 6. Review `appsettings.json` and Configuration

Confirm that all configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json`. Pay particular attention to:

- Database connection strings
- Application-specific settings
- Any environment-specific values

### 7. Target Framework Verification

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and desired, update this value and re-run the restore and build steps.

### 8. Static Asset and Middleware Verification

If this is a web project, verify that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`, including:

- `app.UseStaticFiles()`
- `app.UseRouting()`
- `app.UseAuthentication()` / `app.UseAuthorization()` if applicable