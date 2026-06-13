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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Windows-Specific Dependencies

Review all NuGet package references in the `.csproj` file for any packages that are Windows-specific or were designed for .NET Framework only. Common examples include:

- `System.Web` references (not available in cross-platform .NET)
- Windows-only packages such as those relying on the Windows registry or COM interop

Replace or remove these with cross-platform equivalents where applicable.

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key features and verify they function as expected.

### 6. Run Existing Tests

If the solution contains any test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 7. Review Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains the correct configuration values previously held in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been correctly migrated.
- Ensure `Web.config` transforms or `App.config` sections are no longer relied upon, as these are not used in cross-platform .NET in the same way.

### 8. Verify Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct.
- The database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and up to date.
- Any pending migrations are applied:

```bash
dotnet ef database update
```

### 9. Validate Static Files and Middleware

If this is a web application, confirm that static files, routing, and middleware are correctly configured in `Program.cs` or `Startup.cs`, following the conventions of the target .NET version.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.