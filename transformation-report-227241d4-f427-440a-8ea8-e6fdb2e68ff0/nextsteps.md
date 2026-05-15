# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

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

If the project is a web application, ensure it references `net8.0` or whichever current LTS version is intended.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as expected compared to the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may contain Windows-specific API calls that will only fail at runtime on non-Windows platforms. Search the codebase for usages such as:

- `Registry` (Microsoft.Win32)
- `WindowsIdentity` / `WindowsPrincipal`
- `System.Drawing` (GDI+ based)
- Any P/Invoke calls targeting Windows-only DLLs

Replace or conditionally compile these usages with cross-platform alternatives where applicable.

### 7. Review Configuration and Middleware

If this is an ASP.NET Core application, review `Program.cs` and any `Startup.cs` to confirm:

- Middleware is registered in the correct order.
- Connection strings and configuration values in `appsettings.json` are environment-agnostic.
- Any file paths used in code use `Path.Combine` rather than hardcoded backslash separators.

### 8. Verify Static Files and Resources

Confirm that static files, embedded resources, and content files are correctly included in the `.csproj` and are accessible at runtime. Pay particular attention to case sensitivity in file paths, which can cause issues when moving from Windows to a case-sensitive file system such as Linux.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.