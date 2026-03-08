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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended modern .NET version (e.g., `net8.0`):

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or `netcoreapp3.1`, update it to a currently supported version.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm expected behavior.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay attention to the following areas:

- **`System.Web` dependencies**: Any remaining usage of `System.Web` types (e.g., `HttpContext`, `HttpRequest`) should have been replaced with `Microsoft.AspNetCore.Http` equivalents. Verify these work correctly at runtime.
- **Configuration**: Confirm that `web.config`-based configuration has been fully replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` system.
- **Authentication/Authorization**: If the project uses ASP.NET Membership or Forms Authentication, verify the replacement with ASP.NET Core Identity or cookie authentication middleware is functioning correctly.
- **Entity Framework**: If using Entity Framework, confirm whether the project was migrated to EF Core and run a test query against the database to verify connectivity and schema compatibility.

### 7. Static File and Middleware Verification

If this is a web project, confirm that static files (CSS, JavaScript, images) are being served correctly and that all middleware is registered in the correct order within `Program.cs` or `Startup.cs`.

### 8. Database Migrations

If Entity Framework Core is in use, verify that migrations are up to date:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

Apply any pending migrations to your development database:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish a Test Build

Produce a self-contained or framework-dependent publish output and verify it runs correctly on the target operating system:

```bash
dotnet publish --configuration Release --output ./publish
```

Run the published output directly to confirm it behaves identically to the development run.