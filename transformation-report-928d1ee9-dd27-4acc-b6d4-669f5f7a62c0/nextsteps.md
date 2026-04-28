# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate areas of concern such as nullable reference warnings or obsolete API usage.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and address any failing tests before proceeding.

### 4. Verify Runtime Behavior

Run the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Specifically check the following areas that are commonly affected by cross-platform migrations:

- **File paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\` or backslashes) remain in configuration files or code.
- **Database connections**: Confirm connection strings in `appsettings.json` or `web.config` are valid and accessible in the new environment.
- **Authentication and session handling**: Verify any authentication middleware is configured correctly for ASP.NET Core if this was an ASP.NET Framework project.
- **Static files**: Confirm static assets (CSS, JS, images) are being served correctly.
- **Configuration**: Ensure any settings previously in `web.config` or `app.config` have been migrated to `appsettings.json` and are being read correctly.

### 5. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended version:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Adjust to the appropriate version (e.g., `net6.0`, `net7.0`, `net8.0`) based on your organization's requirements.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed behavior or been removed in .NET. Key areas to inspect include:

- `System.Web` namespace usage (not available in .NET Core/5+)
- `HttpContext` and related types if this is a web project
- Any use of `AppDomain`, `BinaryFormatter`, or `Remoting` APIs
- Windows-specific APIs that may not function on Linux or macOS

### 7. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, including configuration files and static assets, are present before deploying to the target environment.