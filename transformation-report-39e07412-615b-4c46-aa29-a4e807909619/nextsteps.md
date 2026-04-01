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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains any test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may still contain Windows-specific API calls that will fail at runtime on non-Windows platforms. Search the codebase for common problem areas such as:

- `Microsoft.Win32` namespace usage
- `System.Windows.Forms` or `System.Drawing` references
- Registry access via `RegistryKey`
- Windows-specific file path assumptions (e.g., hardcoded backslashes)

Replace or abstract any such usages with cross-platform alternatives where applicable.

### 7. Verify Configuration and Middleware

If this is an ASP.NET Core web application, review `Program.cs` or `Startup.cs` to confirm:

- Middleware is configured correctly for the new hosting model
- Connection strings and `appsettings.json` values are accurate for the target environment
- Any legacy `System.Web` dependencies have been fully removed or replaced

### 8. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` and confirm the application can connect and perform basic operations against the database at runtime.

### 9. Static Files and wwwroot

If the project is a web application, confirm that static assets (CSS, JavaScript, images) are present under the `wwwroot` folder and are being served correctly when the application runs.

### 10. Publish the Application

Once all runtime validation steps have passed, publish the application to confirm the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.