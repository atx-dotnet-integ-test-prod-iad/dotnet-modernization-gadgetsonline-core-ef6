# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **File system paths**: Ensure no hardcoded Windows-style paths (e.g., backslashes) are used.
- **Registry access**: `Microsoft.Win32.Registry` is not available on Linux/macOS.
- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they should be replaced with ASP.NET Core equivalents.
- **`HttpContext` and session handling**: Verify these have been migrated to ASP.NET Core middleware patterns.
- **Configuration**: Ensure `Web.config` settings have been migrated to `appsettings.json` or environment variables.

### 6. Run the Application Locally

Start the application and manually exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that:
- The application starts without runtime exceptions.
- Key pages and endpoints respond correctly.
- Database connections (if applicable) are functional.
- Authentication and authorization behave as expected.

### 7. Review Middleware and Startup Configuration

If this is an ASP.NET Core web project, review `Program.cs` (and `Startup.cs` if present) to confirm:

- Middleware is registered in the correct order.
- Services such as Entity Framework, Identity, or session are properly configured.
- Static file serving is enabled if required.

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version in use is compatible:

```bash
dotnet ef database update
```

Ensure migrations are present and the schema matches expectations.

### 9. Test on Target Platform

If the goal is cross-platform deployment, run the application on the intended target operating system (Linux or macOS) to surface any platform-specific runtime issues that would not appear on Windows.

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Then execute the published output on the target platform and verify behavior.