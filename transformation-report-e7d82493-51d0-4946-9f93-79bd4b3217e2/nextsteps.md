# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Verify that both commands complete with no errors or warnings that could indicate missing dependencies or incompatible package versions.

### 2. Review NuGet Package Compatibility

Open the `.csproj` file and review all `<PackageReference>` entries. Confirm that each package targets a compatible .NET version. You can check compatibility using the [NuGet Package Explorer](https://www.nuget.org/packages) or by running:

```bash
dotnet list package --outdated
```

Update any outdated or incompatible packages as needed.

### 3. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that all major features function correctly, including any database connections, authentication flows, and page rendering.

### 4. Check for Runtime Errors

Even with a clean build, runtime issues may exist. Pay attention to:

- **Database connectivity**: Confirm connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date. Run pending migrations if necessary:
  ```bash
  dotnet ef database update
  ```
- **Static files and wwwroot**: Verify that static assets (CSS, JS, images) are served correctly.
- **Configuration**: Ensure that any settings previously in `Web.config` have been properly moved to `appsettings.json` and are being read correctly via `IConfiguration`.

### 5. Execute Unit and Integration Tests

If the solution contains test projects, run them to validate core logic:

```bash
dotnet test
```

Review any failing tests and address the underlying issues before proceeding.

### 6. Check for Removed or Changed APIs

Some APIs available in .NET Framework are not available or have changed in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (these are not available in .NET Core/.NET 5+)
- `HttpContext` usage outside of controllers
- `ConfigurationManager` (replaced by `IConfiguration`)
- Windows-specific APIs (e.g., registry access, Windows authentication specifics)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tool to identify any remaining compatibility issues.

### 7. Validate Middleware and Startup Configuration

If this is an ASP.NET Core project, review the `Program.cs` or `Startup.cs` file to confirm:

- Middleware is registered in the correct order.
- Services such as MVC, Razor Pages, or Web API are properly configured.
- Any custom HTTP modules or handlers from the legacy project have been converted to middleware.

### 8. Deployment

Once the application has been validated locally:

1. Publish the application using:
   ```bash
   dotnet publish -c Release -o ./publish
   ```
2. Copy the contents of the `./publish` folder to your target server or hosting environment.
3. Ensure the target environment has the correct .NET runtime installed. Verify with:
   ```bash
   dotnet --info
   ```
4. Configure the web server (IIS, Nginx, or Apache) to point to the published output and confirm the application starts correctly in the production environment.