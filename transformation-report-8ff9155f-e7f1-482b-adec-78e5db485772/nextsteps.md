# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as it did in the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 6. Check for Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any runtime issues that would not appear as build errors, such as:

- `System.Web` dependencies that may have been stubbed out
- Windows-specific registry or file path assumptions
- `HttpContext` or `HttpRuntime` usage patterns that differ in ASP.NET Core

### 7. Verify Configuration and Middleware

If this is an ASP.NET Core project, confirm that:

- `appsettings.json` contains all configuration values previously held in `Web.config`
- Middleware is registered correctly in `Program.cs` or `Startup.cs`
- Authentication, session, and routing behave as expected

### 8. Test Data Access

If the project uses Entity Framework or another data access layer, run the application against a real or test database and confirm:

- Migrations apply correctly (`dotnet ef database update`)
- Queries return expected results
- Connection strings in `appsettings.json` are correct for the target environment