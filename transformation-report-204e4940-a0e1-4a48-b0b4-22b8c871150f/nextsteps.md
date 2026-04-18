# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The `GadgetsOnline/GadgetsOnline.csproj` project compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to `net8.0` and rebuilding.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows, such as browsing products, adding items to a cart, and completing a checkout, to confirm runtime behavior is correct.

### 5. Run Existing Tests

If the solution contains a test project, execute the tests to validate core functionality:

```bash
dotnet test
```

Review any failing tests and address them individually. Pay particular attention to tests that may have been written against Windows-specific behavior or APIs.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **`System.Web` dependencies**: Any remaining references to `HttpContext`, `HttpRequest`, or similar types should be verified to use the ASP.NET Core equivalents.
- **`App_Start` configuration**: Ensure that any configuration previously in `RouteConfig`, `BundleConfig`, or `FilterConfig` has been migrated to `Program.cs` or `Startup.cs`.
- **Database connectivity**: If Entity Framework is used, confirm the correct provider (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and that migrations are up to date by running:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

### 7. Review Static Files and Bundling

ASP.NET Core does not include the legacy `System.Web.Optimization` bundling. Confirm that static files (CSS, JavaScript) are being served correctly and that any bundling has been replaced with an alternative such as `LibMan`, `npm`, or manual inclusion.

### 8. Verify Configuration Files

Ensure that `web.config` settings that were relevant to the application have been migrated to `appsettings.json`. Check the following:

- Connection strings
- Application-specific keys
- Logging configuration

## Deployment

### 1. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Publish Output

Inspect the `./publish` directory to confirm all expected files are present, including static assets and configuration files.

### 3. Deploy to the Target Environment

Copy the contents of the `./publish` directory to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify the required runtime version from the `<TargetFramework>` value in the project file and download the corresponding hosting bundle from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).