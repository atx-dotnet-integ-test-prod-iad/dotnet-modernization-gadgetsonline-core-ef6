# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to check for any runtime errors that would not have been caught at compile time.

### 5. Check for Runtime Compatibility Issues

Pay particular attention to the following areas that commonly surface runtime issues after a legacy migration:

- **Database connectivity**: Verify connection strings in `appsettings.json` are correct and that the database provider (e.g., Entity Framework Core) is functioning as expected.
- **Authentication and session handling**: Confirm that any authentication middleware is correctly configured in `Program.cs` or `Startup.cs`.
- **Static files and wwwroot**: Ensure static assets are being served correctly.
- **Removed or changed APIs**: Some APIs available in .NET Framework are not available or have changed in cross-platform .NET. Test all major features thoroughly.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate business logic:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 7. Review Removed Windows-Specific Dependencies

Check the project for any references to Windows-specific libraries or APIs such as:

- `System.Web`
- `Microsoft.Web.*`
- Windows Registry access
- COM interop

These will not function on non-Windows platforms and may require alternative implementations.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all required files are present before deploying to the target environment.