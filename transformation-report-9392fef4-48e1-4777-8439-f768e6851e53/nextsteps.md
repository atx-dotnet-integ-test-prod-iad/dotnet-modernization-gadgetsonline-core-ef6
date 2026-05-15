# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your team's supported runtime version.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and address any failing tests before proceeding to deployment.

### 5. Verify Runtime Behavior

Run the application locally to confirm it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Manually exercise the core features of the application, paying particular attention to areas that relied on Windows-specific APIs or libraries in the legacy project, as these are the most common sources of runtime issues that do not surface as build errors.

### 6. Check for Windows-Specific API Usage

Even without build errors, some APIs may have been available at compile time but will fail at runtime on non-Windows platforms. Review the codebase for usage of the following and test on the target platform:

- `System.Drawing` (GDI+ based operations)
- `Microsoft.Win32` registry access
- Windows-specific file path assumptions (e.g., backslash separators)
- COM interop or P/Invoke calls targeting Windows libraries

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package to identify remaining platform-specific concerns.

### 7. Review Configuration and Middleware

If `GadgetsOnline` is an ASP.NET Core web application, verify the following:

- `Program.cs` and `Startup.cs` (if present) have been correctly migrated to the minimal hosting model or the appropriate ASP.NET Core pattern for your target framework.
- Connection strings and app settings in `appsettings.json` are correct and no longer rely on `Web.config` transforms.
- Authentication, authorization, and session middleware are configured correctly.

### 8. Database Migrations

If the project uses Entity Framework, confirm that existing migrations are compatible with the new runtime:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

Apply migrations against a test database to verify schema integrity:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once the above steps have been validated, publish the application to confirm the output is complete and correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, static files, and configuration files are present before deploying to the target environment.