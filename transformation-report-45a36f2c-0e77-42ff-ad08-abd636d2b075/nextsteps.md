# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Verify that no warnings or errors appear related to missing or incompatible packages.

### 2. Build the Solution

Perform a full build to confirm the solution compiles cleanly:

```bash
dotnet build --configuration Release
```

Review the output and confirm there are zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate modern TFM for your use case.

### 4. Check for Removed or Changed APIs

Even without build errors, runtime issues can arise from APIs that changed behavior between .NET Framework and modern .NET. Review the following areas if they are used in the project:

- `System.Web` dependencies — these are not available in modern .NET. Confirm they have been replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages — confirm they reference `Microsoft.AspNetCore.Http` types.
- `ConfigurationManager` — confirm it has been replaced with `Microsoft.Extensions.Configuration`.
- `Global.asax` — confirm it has been replaced with `Program.cs` and `Startup.cs` or the minimal hosting model.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to identify any runtime errors that did not surface at compile time.

### 6. Review Application Logs

Check the console output and any configured logging sinks for exceptions or warnings during startup and during normal usage. Pay particular attention to:

- Middleware configuration errors
- Database connection issues
- Missing configuration values

### 7. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review the results and investigate any failing tests.

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version being used is Entity Framework Core and not the legacy `System.Data.Entity` namespace. Run any pending migrations if applicable:

```bash
dotnet ef database update
```

### 9. Review Static Files and Bundling

If the project previously used `System.Web.Optimization` for bundling and minification, confirm that a replacement such as `WebOptimizer` or a front-end build tool has been configured, as the original library is not compatible with modern .NET.

### 10. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment and confirm the application starts and operates correctly in that environment.