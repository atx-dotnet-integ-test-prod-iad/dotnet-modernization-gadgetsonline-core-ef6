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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-specific framework such as `net48`, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary features to confirm expected behavior.

### 5. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate functional correctness:

```bash
dotnet test
```

Review the test results and investigate any failures before proceeding.

### 6. Check for Windows-Specific Dependencies

Search the codebase for any remaining Windows-specific APIs or packages that may not be compatible with cross-platform .NET, such as:

- `Microsoft.Win32` registry access
- `System.Windows.Forms` or `System.Drawing` (without the `EnableWindowsTargeting` flag or a compatible alternative)
- COM interop references
- Any NuGet packages that only support `net4x` target frameworks

Replace or remove these as needed.

### 7. Verify Configuration Files

Confirm that any configuration previously held in `Web.config` or `App.config` has been properly migrated to `appsettings.json` and that the application reads configuration values correctly at runtime.

### 8. Test on a Non-Windows Platform (Optional but Recommended)

Since the goal is cross-platform compatibility, run the application on a Linux or macOS machine, or within a non-Windows environment, to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Address any runtime exceptions or behavioral differences observed on the non-Windows platform.

### 9. Review Static Files and Middleware (If Web Project)

If `GadgetsOnline` is an ASP.NET Core web project, verify that:

- Static files are served correctly
- Middleware is configured in the correct order in `Program.cs` or `Startup.cs`
- Authentication and authorization configurations have been migrated properly from the legacy setup

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all necessary files are present before deploying to the target environment.