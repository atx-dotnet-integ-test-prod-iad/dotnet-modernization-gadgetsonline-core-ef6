# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET was completed without introducing any compilation issues.

## Validation Steps

### 1. Review the Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework is still set to `net48` or any other `.NET Framework` moniker, update it accordingly.

### 2. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages. Replace any packages that do not support the target framework with their cross-platform equivalents.

### 3. Build the Solution

Perform a clean build to confirm there are no errors or warnings that may have been suppressed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression introduced during migration or a pre-existing issue.

### 6. Verify Database Connectivity

If the project uses Entity Framework or another data access layer, confirm that:

- The connection string in `appsettings.json` (or equivalent) is correct for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- Queries execute without errors at runtime.

### 7. Check for Windows-Specific APIs

Even with a successful build, certain APIs may only fail at runtime on non-Windows platforms. Search the codebase for usages of the following and verify they have cross-platform alternatives:

- `System.Web` types that were shimmed during migration
- `Registry` access (`Microsoft.Win32.Registry`)
- Windows-specific file path assumptions (e.g., hardcoded backslashes)
- `HttpContext.Current` patterns from classic ASP.NET

### 8. Review `appsettings.json` and Configuration

Confirm that configuration previously held in `Web.config` has been fully migrated to `appsettings.json` or environment variables, including:

- Connection strings
- Application settings
- Authentication configuration

### 9. Test on a Non-Windows Machine (Optional but Recommended)

To fully validate cross-platform compatibility, run the application on Linux or macOS:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

This will surface any remaining platform-specific runtime issues.

## Deployment

### 1. Publish the Application

Use the `dotnet publish` command to produce a deployment-ready output:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

### 2. Verify the Published Output

Inspect the `./publish` directory and confirm all required files, static assets, and configuration files are present.

### 3. Deploy to the Target Environment

Copy the contents of the `./publish` directory to the target server or hosting environment. Ensure the correct .NET runtime version is installed on the target machine:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

### 4. Configure the Web Server

If hosting behind IIS, Nginx, or Apache, update the server configuration to forward requests to the Kestrel process or serve the application directly. For IIS specifically, ensure the **ASP.NET Core Module (ANCM)** is installed via the .NET Hosting Bundle.