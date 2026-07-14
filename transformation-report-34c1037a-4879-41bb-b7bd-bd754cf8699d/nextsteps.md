# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it to `net8.0`.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have changed behavior or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which may have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` types

### 5. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the results and investigate any failing tests, as they may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files such as CSS, JavaScript, and images are placed under the `wwwroot` folder if this is an ASP.NET Core web project.
- Check that connection strings have been correctly migrated to `appsettings.json`.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection string is correct and that the application can connect and perform queries at runtime. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once the above steps are completed and the application is functioning correctly, publish it using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present before deploying to the target environment.