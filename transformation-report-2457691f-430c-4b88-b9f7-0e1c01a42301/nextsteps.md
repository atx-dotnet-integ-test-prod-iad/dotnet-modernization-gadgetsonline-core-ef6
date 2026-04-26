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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you plan to deploy to.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding to deployment.

### 5. Verify Runtime Behavior

Run the application locally to confirm it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Manually exercise the key workflows of the application, particularly any areas that relied on Windows-specific APIs or libraries in the legacy project, as these are the most likely sources of runtime issues that do not surface at build time.

### 6. Check for Windows-Specific Dependencies

Even with a successful build, review the codebase for any remaining usage of Windows-specific APIs such as:

- `System.Web` types that may have been shimmed
- Windows Registry access
- Windows-only authentication mechanisms (e.g., NTLM, Windows Identity)
- `HttpContext` usage patterns specific to ASP.NET (non-Core)

These will not always produce build errors but can cause runtime failures on non-Windows platforms.

### 7. Review Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Verify that connection strings, application settings, and environment-specific configuration are correctly structured for the .NET configuration system.

### 8. Deploy to Target Environment

Once the above steps are completed and validated:

1. Publish the application using:
   ```bash
   dotnet publish --configuration Release --output ./publish
   ```
2. Copy the contents of the `./publish` directory to your target server or hosting environment.
3. Confirm the correct .NET runtime version is installed on the target machine by running:
   ```bash
   dotnet --info
   ```
4. Start the application and verify it runs correctly in the target environment.