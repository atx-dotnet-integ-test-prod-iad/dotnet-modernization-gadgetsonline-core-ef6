# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies that may not surface as hard build errors.

### 2. Build the Solution

Perform a full build to confirm the clean state:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that could indicate compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to confirm your chosen version is still actively supported.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently between .NET Framework and modern .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET. If any references remain, they will need to be replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages, which have changed in ASP.NET Core.
- Any usage of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- `Global.asax` and `Web.config` patterns, which should be migrated to `Program.cs` and `appsettings.json` respectively.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm runtime behavior matches expectations.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review the results for any failures that may indicate behavioral differences introduced by the migration.

### 7. Review Static Files and Middleware Configuration

If this is a web project, confirm that:

- Static files (CSS, JS, images) are being served correctly via `app.UseStaticFiles()`.
- Routing is configured correctly in `Program.cs` or `Startup.cs`.
- Authentication and authorization middleware, if used, has been correctly migrated to the ASP.NET Core equivalents.

### 8. Validate Database Connectivity

If the project uses a data access layer, confirm that:

- Connection strings have been moved to `appsettings.json`.
- Entity Framework, if used, has been updated to Entity Framework Core and that migrations are intact and functional.
- Any raw ADO.NET code still functions correctly against the target database.

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target server or hosting environment. Ensure the target environment has the correct .NET runtime installed by running:

```bash
dotnet --info
```

Confirm the runtime version matches the `<TargetFramework>` specified in the project file.