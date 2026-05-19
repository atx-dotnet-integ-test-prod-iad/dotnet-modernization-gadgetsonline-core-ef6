# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-breaking, may indicate compatibility concerns with the target framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or any other legacy .NET Framework moniker, update it accordingly and rebuild.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm runtime behavior matches the legacy version. Pay particular attention to:

- Database connectivity and Entity Framework migrations (if applicable)
- Authentication and session management
- Any file system operations that may have platform-specific path assumptions

### 5. Execute Existing Tests

If the solution contains a test project, run the test suite:

```bash
dotnet test
```

Review any failing tests, as they may surface runtime issues not caught at compile time.

### 6. Check for Windows-Specific APIs

Even with a successful build, certain APIs may compile but fail at runtime on non-Windows platforms. Search the codebase for usages of the following and verify cross-platform compatibility:

- `Microsoft.Win32` namespace
- `System.Windows.Forms` or `System.Drawing` (unless using the cross-platform compatible `System.Drawing.Common` with proper configuration)
- Registry access (`RegistryKey`)
- Windows-specific file paths (e.g., hardcoded `C:\` paths)

### 7. Review Configuration Files

Confirm that `appsettings.json` (or equivalent) contains the correct configuration for the new hosting model. If the project previously used `Web.config`, verify that all relevant settings such as connection strings and app settings have been migrated.

### 8. Verify Static Files and wwwroot

If this is a web application, confirm that static assets are located under the `wwwroot` folder and that the middleware is configured correctly in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, including configuration and static assets, are present before deploying to the target environment.