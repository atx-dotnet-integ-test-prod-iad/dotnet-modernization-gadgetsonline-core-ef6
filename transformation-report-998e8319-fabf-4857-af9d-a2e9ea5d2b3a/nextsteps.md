# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET has completed without introducing any compilation issues.

## Validation Steps

### 1. Review the Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure there are no remaining references to `net48`, `netcoreapp`, or other legacy target frameworks unless intentionally multi-targeting.

### 2. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages.

### 3. Build the Solution

Perform a clean build to confirm the solution compiles without warnings or errors:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to nullable reference types or obsolete APIs, as these can indicate runtime issues.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm baseline functionality is intact.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to verify no regressions were introduced during the migration:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to migration changes or pre-existing issues.

### 6. Check for Runtime Compatibility Issues

Pay attention to the following areas that commonly surface as runtime issues rather than build errors after a migration:

- **Configuration**: Verify that `appsettings.json` is present and correctly structured. Legacy `Web.config` or `App.config` values may need to be migrated to `appsettings.json` or environment variables.
- **Dependency Injection**: If the project uses ASP.NET Core, confirm that all services are properly registered in `Program.cs` or `Startup.cs`.
- **Entity Framework**: If the project uses Entity Framework, confirm the provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and that migrations are up to date by running:
  ```bash
  dotnet ef migrations list
  ```
- **Static Files and Middleware**: Confirm that middleware ordering in the request pipeline is correct and that static file serving is configured if needed.
- **Authentication and Authorization**: Verify that any authentication schemes previously configured (e.g., Forms Authentication) have been replaced with the appropriate ASP.NET Core equivalents.

### 7. Verify Target Platform Behavior

Test the application on each operating system you intend to support (Windows, Linux, macOS) to identify any platform-specific issues such as:

- File path separators
- Case-sensitive file systems (relevant on Linux)
- Windows-specific APIs that may not be available cross-platform

### 8. Review Deprecated API Usage

Run the following command to surface any usage of deprecated or platform-specific APIs:

```bash
dotnet build /p:EnableNETAnalyzers=true --configuration Release
```

Address any analyzer warnings related to platform compatibility (e.g., `CA1416`).

## Deployment

Once the above validation steps pass:

1. Publish the application using the appropriate runtime identifier for your target environment:
   ```bash
   dotnet publish --configuration Release --runtime linux-x64 --self-contained false
   ```
   Replace `linux-x64` with your target runtime (e.g., `win-x64`, `osx-x64`) as needed.

2. Verify the contents of the `publish` output directory to confirm all required files are present.

3. Deploy the published output to your target environment and perform a final smoke test against the deployed instance.