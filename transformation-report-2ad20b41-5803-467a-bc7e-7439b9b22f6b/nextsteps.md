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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full solution build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). Avoid using end-of-life versions such as `net5.0` or `net6.0` if long-term support is a concern.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

Review test results carefully, paying attention to any failures that may point to behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 5. Check for Runtime Compatibility Issues

Some APIs that compiled successfully may behave differently or throw exceptions at runtime. Pay particular attention to:

- **Windows-specific APIs**: Features such as `System.Drawing`, `Microsoft.Win32`, or anything relying on the Windows registry may require the `<RuntimeIdentifier>win</RuntimeIdentifier>` setting or replacement with cross-platform alternatives.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that database migrations are up to date by running `dotnet ef migrations list`.
- **Configuration**: Verify that `Web.config` or `App.config` settings have been properly migrated to `appsettings.json` and that the application reads them correctly at runtime.
- **Authentication/Authorization**: If the project uses ASP.NET Membership or older authentication mechanisms, confirm these have been replaced with ASP.NET Core Identity or equivalent.

### 6. Run the Application Locally

Start the application and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the primary user flows (e.g., browsing products, adding to cart, checkout if applicable) to confirm the application behaves as expected.

### 7. Review Static Files and Bundling

If the project previously relied on ASP.NET Bundling and Minification (`System.Web.Optimization`), confirm that static assets (CSS, JavaScript) are being served correctly. In ASP.NET Core, static files are served from the `wwwroot` folder by default, and bundling may need to be handled via a tool such as LibMan or a front-end build tool.

### 8. Publish the Application

Once local validation is complete, produce a published output to confirm the deployment artifact is generated correctly:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files, including static assets and configuration files, are present.

### 9. Verify on Target Hosting Environment

Deploy the published output to the target hosting environment (e.g., IIS, Azure App Service, or a Linux server) and confirm:

- The correct .NET runtime version is installed on the host.
- Environment-specific configuration (connection strings, API keys) is correctly set via environment variables or a production `appsettings.json`.
- The application starts and responds to requests without errors.