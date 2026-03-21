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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and re-run the build.

### 4. Run Unit Tests

If the solution contains any test projects, execute the tests to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and address any failures before proceeding.

### 5. Verify Runtime Behavior Locally

Run the application locally to confirm it starts and operates as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the core application workflows manually to identify any runtime issues that would not surface at compile time, such as missing configuration values, changed API behavior, or removed APIs that were previously available in the .NET Framework.

### 6. Review Removed or Changed APIs

Check the codebase for usage of APIs that behave differently between .NET Framework and modern .NET. Common areas to review include:

- `System.Web` dependencies, which are not available in modern .NET and may have been replaced or stubbed during transformation.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns, which differ between ASP.NET and ASP.NET Core.
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`.
- Any use of `BinaryFormatter`, which is disabled by default in modern .NET.

### 7. Check Application Configuration

Verify that `appsettings.json` (or equivalent) contains all configuration values that were previously in `web.config` or `app.config`. Confirm that connection strings, application settings, and any environment-specific values have been correctly migrated.

### 8. Validate Database Connectivity

If the application uses a database, confirm that connection strings are correct and that the application can successfully connect and perform queries in the new runtime environment.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present.

### 10. Deploy to Target Environment

Copy the published output to the target hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify the required runtime version with:

```bash
dotnet --info
```

Confirm the application starts correctly in the target environment and that all environment-specific configuration is in place.