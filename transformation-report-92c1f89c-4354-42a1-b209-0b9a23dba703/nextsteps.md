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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows (e.g., browsing products, adding to cart, checkout) to confirm functional parity with the legacy version.

### 5. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references — these are not available in cross-platform .NET and should have been replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage — confirm these reference `Microsoft.AspNetCore.Http` types.
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`.
- `System.Drawing` — if used for image processing, verify the `System.Drawing.Common` package is included, or consider migrating to a cross-platform alternative such as `SkiaSharp`.

### 6. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm the connection strings in `appsettings.json` are correctly configured and that the application can connect to the database:

```bash
dotnet ef database update
```

If Entity Framework Core migrations are present, verify they apply cleanly.

### 7. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they indicate a functional regression or a test configuration issue introduced during migration.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files, static assets, and configuration files are present before deploying to the target environment.