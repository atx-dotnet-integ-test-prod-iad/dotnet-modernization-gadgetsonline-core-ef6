# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Review any warnings that appear during the build, as some may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an actively supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its primary features to check for any runtime exceptions or unexpected behavior that would not be caught at compile time.

### 5. Review Replaced or Removed APIs

Cross-platform .NET transformations from legacy .NET Framework projects commonly involve API replacements. Manually review the following areas of the codebase:

- **`System.Web` usages**: These are not available in cross-platform .NET. Ensure they have been replaced with `Microsoft.AspNetCore` equivalents.
- **`HttpContext` and related types**: Confirm these are being accessed via dependency injection rather than static accessors.
- **Configuration**: Verify that `Web.config` or `App.config` based configuration has been migrated to `appsettings.json` and the `Microsoft.Extensions.Configuration` model.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated from EF6 to EF Core and that migrations are functioning correctly.

### 6. Execute Unit Tests

If the solution contains test projects, run them to validate core logic:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to legitimate regressions introduced during the migration or test code that itself requires updating.

### 7. Verify Static Files and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Check that the middleware pipeline order is correct, particularly for authentication, authorization, and error handling.

### 8. Check Logging and Error Handling

Confirm that logging has been migrated to `Microsoft.Extensions.Logging` and that any legacy logging frameworks have been properly integrated or replaced. Test error handling paths explicitly to ensure exceptions are surfaced and logged correctly.

### 9. Validate Database Connectivity

If the application connects to a database, verify that the connection strings in `appsettings.json` are correct for the target environment and that the application can successfully connect and perform basic queries at runtime.

### 10. Deploy to Target Environment

Once all of the above steps have been completed and validated:

1. Publish the application using:
   ```bash
   dotnet publish --configuration Release --output ./publish
   ```
2. Copy the contents of the `./publish` directory to the target server or hosting environment.
3. Ensure the correct .NET runtime version is installed on the target machine by running:
   ```bash
   dotnet --list-runtimes
   ```
4. Start the application and perform a final round of validation against the deployed instance.