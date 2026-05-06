# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to `net8.0` and rebuilding.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently across .NET versions. Manually review the following areas if they are used in the project:

- **HTTP modules and handlers** — These do not exist in cross-platform .NET. Ensure they have been replaced with ASP.NET Core middleware.
- **`System.Web` dependencies** — These are not available in cross-platform .NET. Confirm no remaining references exist.
- **`ConfigurationManager`** — Ensure configuration has been migrated to `appsettings.json` and `IConfiguration`.
- **Entity Framework** — If the project uses EF6, confirm whether it has been migrated to EF Core, as EF6 has limited cross-platform support.
- **Session and Authentication** — Verify that ASP.NET Core equivalents are in place if the original project used `FormsAuthentication` or `HttpSessionState`.

### 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually and verify that core functionality such as routing, data access, and authentication behaves as expected.

### 7. Review Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, which is the expected location in ASP.NET Core.

### 8. Check Middleware Pipeline

Open `Program.cs` or `Startup.cs` and verify the middleware pipeline is correctly configured, including:

- `app.UseStaticFiles()`
- `app.UseRouting()`
- `app.UseAuthentication()` and `app.UseAuthorization()` if applicable
- `app.UseEndpoints(...)` or top-level route mapping

### 9. Validate Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the application can connect and perform queries successfully at runtime.

### 10. Review Warnings

Even if there are no errors, build warnings may indicate deprecated APIs or compatibility concerns. Run the following to surface all warnings:

```bash
dotnet build --configuration Release /warnaserror
```

Address any warnings that are flagged as errors under this mode before considering the migration complete.