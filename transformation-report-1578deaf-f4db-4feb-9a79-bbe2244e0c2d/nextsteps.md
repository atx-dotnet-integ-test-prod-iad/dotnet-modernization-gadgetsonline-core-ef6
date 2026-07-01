# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The solution has no build errors following the transformation. The migration to cross-platform .NET appears to have completed successfully. The following steps outline how to validate, test, and deploy the project.

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need to be updated.

## 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

## 4. Run Unit Tests

If the solution contains any test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output for any failures and address them before proceeding.

## 5. Validate Runtime Behavior

Launch the application locally and manually verify core functionality, particularly any areas that are commonly affected by cross-platform migrations:

- **File system paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) exist in the code. Replace them with `Path.Combine` or `Path.DirectorySeparatorChar` where applicable.
- **Database connections**: Confirm connection strings in `appsettings.json` or `web.config` are valid and accessible from the new runtime.
- **Authentication and session handling**: If the project uses cookies, sessions, or identity, verify these work as expected under ASP.NET Core middleware.
- **Static files**: Confirm that static assets (CSS, JavaScript, images) are being served correctly.

## 6. Check for Removed or Changed APIs

Some APIs available in .NET Framework are not present or have changed in cross-platform .NET. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any remaining compatibility concerns at runtime.

## 7. Review Configuration Files

- Confirm that `appsettings.json` contains all necessary configuration that was previously in `web.config` or `app.config`.
- Verify that environment-specific settings (e.g., `appsettings.Development.json`) are correctly structured.
- Remove or archive any legacy `web.config` entries that are no longer applicable to the ASP.NET Core pipeline.

## 8. Publish the Application

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.