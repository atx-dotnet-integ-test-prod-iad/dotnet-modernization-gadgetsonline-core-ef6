# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Verify that both commands complete with no errors or warnings that could indicate missing dependencies or incompatible package versions.

### 2. Review NuGet Package Compatibility

Open the `.csproj` file and review all `<PackageReference>` entries. Confirm that each package targets a compatible .NET version (e.g., `net6.0`, `net7.0`, `net8.0`). You can check compatibility using the [NuGet Package Explorer](https://www.nuget.org/packages) or by running:

```bash
dotnet list package --outdated
```

Update any outdated packages as needed:

```bash
dotnet add package <PackageName>
```

### 3. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application URL shown in the console output and confirm the core functionality works correctly.

### 4. Review Runtime Configuration

Check `appsettings.json` and `appsettings.Development.json` for any configuration values that were previously stored in `Web.config` or `App.config`. Ensure the following have been migrated correctly:

- Connection strings
- Application settings keys
- Logging configuration
- Authentication/authorization settings

### 5. Verify Database Connectivity

If the project uses Entity Framework or any other ORM, run the following to confirm migrations are up to date and the database connection is functional:

```bash
dotnet ef database update
```

If using a different data access strategy, manually test queries against the target database to confirm connectivity and correctness.

### 6. Execute Unit and Integration Tests

If a test project exists within the solution, run all tests to confirm no regressions were introduced during the migration:

```bash
dotnet test
```

Review any failing tests and address issues related to API changes between the legacy .NET Framework and the current .NET version.

### 7. Check for Platform-Specific Code

Search the codebase for any APIs or libraries that were Windows-specific in the original project. Common areas to review include:

- `System.Web` references (should be replaced with `Microsoft.AspNetCore` equivalents)
- Windows Registry access
- COM interop
- `HttpContext.Current` usage (replace with dependency-injected `IHttpContextAccessor`)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) to identify any remaining compatibility concerns.

### 8. Test on Target Platforms

If cross-platform support is a goal, test the application on each intended operating system (e.g., Linux, macOS) to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish
```

Review the contents of the `./publish` directory and confirm all required files, static assets, and configuration files are present before deploying to the target environment.