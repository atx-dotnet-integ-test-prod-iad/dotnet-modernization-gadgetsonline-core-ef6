# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing dependencies.

### 2. Build the Project

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating to the current LTS release (`net8.0`).

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as compilation success does not guarantee behavioral correctness after a migration.

### 5. Verify Runtime Behavior

Start the application and manually exercise the core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay specific attention to the following areas that commonly surface issues after migration:

- **Database connectivity**: Confirm connection strings and any Entity Framework migrations are compatible with the new runtime.
- **Authentication and authorization**: Middleware configuration may differ between .NET Framework and modern .NET.
- **Static files and routing**: ASP.NET Core routing and static file serving differ from legacy ASP.NET MVC.
- **Configuration**: Ensure `web.config` settings have been migrated to `appsettings.json` where applicable.
- **HTTP client usage**: Verify any `HttpClient` or `WebClient` usages are compatible.

### 6. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to detect any API usage that may compile but behave differently at runtime:

```bash
dotnet tool install -g dotnet-apicompat
```

Additionally, review the [.NET Upgrade Assistant documentation](https://learn.microsoft.com/en-us/dotnet/core/porting/) for known breaking changes relevant to your source framework version.

### 7. Review Warnings

Even without errors, the build may have produced warnings. Review them with:

```bash
dotnet build --configuration Release 2>&1 | grep -i warning
```

Address any warnings related to deprecated APIs or nullable reference types, as these can indicate future compatibility concerns.

### 8. Publish the Application

Once runtime validation is complete, produce a publish output to confirm the deployment artifact is generated correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory contain all expected assemblies, static assets, and configuration files before deploying to the target environment.