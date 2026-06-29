# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets the intended modern .NET version (e.g., `net8.0`). Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework is not what you intended, update it and re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application to verify it runs correctly at runtime, not just at compile time:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows (e.g., browsing products, adding to cart, checkout) to catch any runtime errors that would not surface during a build.

### 5. Check for Removed or Changed APIs

Legacy .NET Framework projects often rely on APIs that have been removed or changed in cross-platform .NET. Pay particular attention to:

- **`System.Web` dependencies**: These do not exist in modern .NET. If any code still references `System.Web`, it will need to be replaced with ASP.NET Core equivalents.
- **`HttpContext`**: Ensure usage has been migrated to the ASP.NET Core `HttpContext`.
- **`Session` and `Cache`**: Verify these have been replaced with `ISession` and `IMemoryCache` / `IDistributedCache` respectively.
- **`Web.config`**: Configuration should now reside in `appsettings.json` and be accessed via `IConfiguration`.

### 6. Run Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 7. Review Database Connectivity

If the project uses Entity Framework, confirm the correct version (EF Core) is referenced and that:

- The connection string in `appsettings.json` is correct for the target environment.
- Migrations are up to date by running:

```bash
dotnet ef migrations list
dotnet ef database update
```

### 8. Check Static Files and Middleware Pipeline

In ASP.NET Core, static files and middleware must be explicitly configured in `Program.cs` or `Startup.cs`. Verify the following are present where needed:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
```

### 9. Publish the Application

Once local validation is complete, produce a publish output to verify the release artifact builds correctly:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all expected files are present.

### 10. Verify on Target Runtime Environment

Deploy the contents of the `./publish` folder to the target server or environment and confirm the application starts and responds correctly. Ensure the target machine has the appropriate .NET runtime installed:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).