# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution to cross-platform .NET appears to have completed successfully. No build errors were detected in any of the projects within the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

### 2. Build the Solution
Confirm the solution builds cleanly in release configuration:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that may indicate deprecated APIs or compatibility concerns, even if they do not block the build.

### 3. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as `net8.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0`.

### 4. Run the Application Locally
Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality to identify any runtime issues that would not surface at build time.

### 5. Run Existing Tests
If the solution contains test projects, execute them to confirm existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 6. Check for Removed or Changed APIs
Even with a clean build, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **File paths**: Ensure no hardcoded backslash (`\`) path separators exist. Use `Path.Combine` instead.
- **Windows-specific APIs**: Any usage of the Windows registry, `System.Drawing` (GDI+), or COM interop may require replacement packages or alternative implementations.
- **Authentication and session handling**: If the project uses ASP.NET Identity or Forms Authentication, verify the middleware is configured correctly for ASP.NET Core.
- **Configuration**: Confirm that `Web.config` settings have been migrated to `appsettings.json` and that `IConfiguration` is used to read them.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been updated to Entity Framework Core and that migrations are functioning correctly.

### 7. Test on Target Operating Systems
If cross-platform support is a goal, run the application on each target operating system (e.g., Linux, macOS) to surface any platform-specific runtime issues.

### 8. Publish the Application
Once validation is complete, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.