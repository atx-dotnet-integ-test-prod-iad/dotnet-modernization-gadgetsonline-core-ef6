# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the root of the solution to ensure all dependencies are properly restored:

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

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm that existing behavior is preserved:

```bash
dotnet test
```

Review test results and address any failures that may surface runtime or logic regressions introduced during the migration.

### 6. Check for Windows-Specific Dependencies

Even when a project builds successfully, it may still contain APIs that are Windows-only at runtime. Search the codebase for usages of the following and verify they are either replaced or conditionally compiled:

- `System.Web` namespaces
- `Microsoft.Win32` registry access
- Windows-specific file path assumptions (e.g., backslash separators)
- COM interop or P/Invoke calls targeting Windows libraries

Use the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) to assist with identifying these issues.

### 7. Verify Configuration and Middleware

If this is an ASP.NET Core application migrated from ASP.NET (classic), confirm the following:

- `Startup.cs` or top-level `Program.cs` is correctly configured
- Middleware pipeline (authentication, routing, static files, etc.) is properly set up
- `appsettings.json` contains the necessary configuration values previously held in `Web.config`
- Any `Web.config` transforms have been manually carried over where applicable

### 8. Validate Static Assets and Views

If the project uses Razor views or static files, verify:

- Views render correctly without missing layout references
- Static files (CSS, JS, images) are served from `wwwroot`
- Bundling and minification, if used, is handled via a supported mechanism such as `LibMan` or a front-end build tool

### 9. Deploy to Target Environment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target server or hosting environment and confirm the application starts and operates correctly in that environment.