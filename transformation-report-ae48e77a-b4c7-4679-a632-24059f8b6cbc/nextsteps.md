# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm they function as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures before proceeding.

### 6. Review Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Check the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Ensure any references have been replaced with ASP.NET Core equivalents.
- **`HttpContext` and related types**: Confirm usage has been updated to `Microsoft.AspNetCore.Http`.
- **`ConfigurationManager`**: Replace any usage with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: Confirm this has been replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model).

### 7. Verify Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been moved to the `wwwroot` folder, which is the expected location in ASP.NET Core.

### 8. Check Database Connectivity

If the application uses a database, verify the connection string configuration in `appsettings.json` and confirm that the application can connect and perform basic data operations at runtime.

### 9. Review Application Logs

Run the application and review the console output and any log files for runtime exceptions or warnings that would not surface during a build.

### 10. Publish the Application

Once the above steps are completed and the application is stable, publish it using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.