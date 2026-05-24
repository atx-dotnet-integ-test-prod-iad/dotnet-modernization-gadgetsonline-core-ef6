# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or packages that could not be resolved.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these may indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a currently supported version of .NET:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are approaching or have reached end-of-life.

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the core functionality of the application to confirm expected behavior is preserved.

### 5. Check for Replaced or Removed APIs

Legacy .NET Framework projects often rely on APIs that have been removed or replaced in cross-platform .NET. Manually review the following areas if they were present in the original project:

- `System.Web` usages — these are not available in .NET Core/5+. Replacements are typically found in `Microsoft.AspNetCore.*`.
- `HttpContext` and related types — verify these have been migrated to their ASP.NET Core equivalents.
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`.
- `EntityFramework` (v6) — if used, confirm migration to `Microsoft.EntityFrameworkCore`.

### 6. Verify Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correctly configured and that the application can connect at runtime:

```json
"ConnectionStrings": {
  "DefaultConnection": "your-connection-string-here"
}
```

Run any Entity Framework Core migrations if applicable:

```bash
dotnet ef database update
```

### 7. Execute Unit Tests

If a test project exists within the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 8. Validate Static Assets and Configuration Files

For web projects, confirm the following:

- `wwwroot` contains the expected static files (CSS, JS, images).
- `appsettings.json` and `appsettings.Development.json` are present and correctly structured.
- Middleware configuration in `Program.cs` or `Startup.cs` reflects the intended request pipeline.

## Deployment

### 1. Publish the Application

Generate a published output ready for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Published Output

Inspect the `./publish` directory to confirm all necessary files are present, including the application binary, configuration files, and static assets.

### 3. Deploy to the Target Environment

Copy the contents of the `./publish` directory to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

### 4. Run the Application on the Target Environment

Start the application on the target server and confirm it is accessible and functioning as expected:

```bash
dotnet GadgetsOnline.dll
```