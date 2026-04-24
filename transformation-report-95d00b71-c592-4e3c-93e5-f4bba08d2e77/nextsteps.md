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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows to confirm expected behavior.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and address them before proceeding.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm that any previous reliance on `System.Web` has been fully replaced (e.g., with `Microsoft.AspNetCore` equivalents).
- **Windows-specific APIs**: If the application uses APIs such as the registry, Windows identity, or COM interop, verify these are either replaced or guarded with runtime checks.
- **Configuration**: Ensure `Web.config` or `App.config` settings have been migrated to `appsettings.json` and that the application reads configuration correctly via `IConfiguration`.

### 7. Verify Static Files and Middleware

If this is a web application, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Test all major routes manually.

### 8. Validate Data Access

If the project uses Entity Framework, confirm the version in use is Entity Framework Core and that:

- Migrations are present and up to date.
- The connection string in `appsettings.json` is correct for the target environment.
- Running `dotnet ef database update` applies migrations without errors.

### 9. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present, then deploy the output to the target environment.