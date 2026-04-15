# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that surface at this stage, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is set to an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to confirm that behavior matches the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they indicate regressions introduced during the migration or tests that require updating due to API changes.

### 6. Check for Removed or Changed APIs

Review the codebase for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (these do not exist in cross-platform .NET)
- `HttpContext` and related ASP.NET types (should now use `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `BinaryFormatter` (removed or restricted in newer .NET versions)
- Windows-specific APIs such as the registry or certain `System.Drawing` features

### 7. Review Static Files and Configuration

Ensure that configuration files such as `appsettings.json` are present and correctly structured. Verify that any static assets (CSS, JavaScript, images) are located under the `wwwroot` folder, which is the expected convention for ASP.NET Core projects.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect to the database at runtime. If Entity Framework is used, verify that migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

The runtime version should match or be compatible with the `<TargetFramework>` specified in the project file.