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

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to check for any runtime exceptions or unexpected behavior that would not have been caught at compile time.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures. Pay particular attention to tests that cover data access, external service integrations, or platform-specific functionality, as these areas are most likely to surface issues after a cross-platform migration.

### 6. Verify Platform-Specific Code

Search the codebase for any remaining usage of Windows-specific APIs or libraries that may not be available on other platforms. Common areas to check include:

- **Registry access** (`Microsoft.Win32.Registry`)
- **Windows Authentication** or NTLM-specific configurations
- **File path separators** — ensure `Path.Combine` and `Path.DirectorySeparatorChar` are used rather than hardcoded backslashes
- **`System.Drawing`** — if used, consider replacing with a cross-platform alternative such as `SkiaSharp` or `ImageSharp`

### 7. Review Configuration and Middleware

If this is an ASP.NET Core web application, review `Program.cs` and any `Startup.cs` to confirm:

- Middleware is registered in the correct order
- Connection strings and configuration values are being read from `appsettings.json` or environment variables rather than hardcoded values or Windows-specific configuration sources
- Static file serving and routing are configured correctly

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection string in `appsettings.json` is correct for the target environment and that the chosen database provider (e.g., SQL Server, SQLite, PostgreSQL) is supported cross-platform. Run any pending Entity Framework Core migrations if applicable:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```