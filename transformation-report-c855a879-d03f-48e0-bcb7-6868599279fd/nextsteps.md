# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Verify that no warnings or errors appear related to missing or incompatible packages.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that may indicate deprecated APIs or compatibility concerns, even if they do not block the build.

### 3. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-EOL version of .NET, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are no longer receiving security updates.

### 4. Run the Application Locally
Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality — such as product listings, cart operations, and any checkout flows — behaves correctly.

### 5. Run Existing Tests
If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs
Search the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed behavior in cross-platform .NET. Common areas to check for a project like this include:

- `System.Web` references (these are not available in cross-platform .NET and should have been replaced)
- `HttpContext` usage patterns
- Session and authentication middleware configuration
- Entity Framework version compatibility if a database is involved

### 7. Test on Target Operating Systems
If cross-platform support is a goal, run the application on each intended operating system (e.g., Linux, macOS) to surface any platform-specific issues such as:

- File path separator differences
- Case-sensitive file system behavior on Linux
- Platform-specific NuGet package dependencies

### 8. Review `web.config` / `appsettings.json`
Confirm that configuration values previously stored in `web.config` have been correctly migrated to `appsettings.json` and that the application reads them properly at runtime.

## Deployment

### 1. Publish the Application
Generate a deployment-ready output using:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Publish Output
Inspect the `./publish` directory to confirm all expected files are present, including static assets, views, and configuration files.

### 3. Deploy to the Target Environment
Copy the contents of the `./publish` directory to your target server or hosting environment. Ensure the target machine has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

The runtime version should match or be compatible with the target framework specified in the project file.