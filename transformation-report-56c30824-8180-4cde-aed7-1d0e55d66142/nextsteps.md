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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net9.0`. Ensure this aligns with the runtime available on your deployment environment.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Verify Runtime Behavior

Launch the application locally to confirm it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the core application workflows, particularly any areas that relied on Windows-specific APIs or legacy ASP.NET features, as these are common sources of runtime issues that do not surface as build errors.

### 6. Check for Removed or Changed APIs

Even with a clean build, certain APIs behave differently in cross-platform .NET compared to .NET Framework. Pay attention to the following areas:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any runtime errors reference `System.Web`, those usages will need to be replaced with ASP.NET Core equivalents.
- **Configuration**: Ensure `web.config`-based configuration has been migrated to `appsettings.json` and the `Microsoft.Extensions.Configuration` model.
- **Authentication and Authorization**: Verify that any membership or identity-related functionality has been migrated to ASP.NET Core Identity if applicable.
- **Session and HttpContext**: Confirm that session state and `HttpContext` access patterns are compatible with ASP.NET Core middleware.

### 7. Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as ASP.NET Core serves static files from that directory by default.

### 8. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` and confirm that Entity Framework Core migrations (if applicable) are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once the above steps are validated, publish the application to prepare it for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present, then deploy to your target environment.