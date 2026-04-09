# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate framework-specific packages rather than any legacy `System.Web` dependencies.

### 4. Check for Removed or Incompatible APIs

Search the codebase for any usage of APIs that are not available in cross-platform .NET, including but not limited to:

- `System.Web.HttpContext` (replaced by `Microsoft.AspNetCore.Http.HttpContext`)
- `System.Web.SessionState`
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Drawing` (limited cross-platform support; consider alternatives such as `ImageSharp`)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to verify that runtime behavior matches expectations from the original project.

### 6. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Configuration Files

- Confirm that `appsettings.json` contains the necessary configuration values that were previously held in `Web.config` or `App.config`.
- Verify connection strings, application settings, and any environment-specific configuration have been correctly migrated.

### 8. Verify Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder, as this is the expected convention for ASP.NET Core projects.

### 9. Deployment

Once the application has been validated locally:

1. Publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

2. Review the contents of the `./publish` directory to confirm all required files are present.
3. Deploy the published output to the target hosting environment, ensuring the correct .NET runtime version is installed on the host.