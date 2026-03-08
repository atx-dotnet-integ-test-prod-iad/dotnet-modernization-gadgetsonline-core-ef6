# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Verify that no legacy framework monikers such as `net472` or `net48` remain unless intentionally retained.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify that behavior matches the original legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that are known to behave differently or have been removed in modern .NET, including:

- `System.Web` dependencies, which are not available outside of ASP.NET on .NET Framework
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages that may require updating to the ASP.NET Core equivalents
- Any third-party libraries that may still target .NET Framework and have not been updated

### 7. Review Configuration Files

Confirm that configuration has been migrated correctly:

- `Web.config` settings should be moved to `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings, app settings, and custom configuration sections should all be verified
- Ensure `Program.cs` and `Startup.cs` (if applicable) correctly register services and middleware

### 8. Validate Static Files and Routing

If this is a web application, verify that:

- Static files such as CSS, JavaScript, and images are served correctly
- All routes resolve as expected
- Any areas or controllers that existed in the legacy project are still functioning

### 9. Check Database Connectivity

If the application uses a database:

- Confirm connection strings in `appsettings.json` are correct
- Run any Entity Framework migrations if applicable:

```bash
dotnet ef database update
```

- Verify that data access operations function correctly end to end

### 10. Deploy to Target Environment

Once all local validation steps pass:

- Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

- Copy the published output to the target server or hosting environment
- Verify the application starts and operates correctly in that environment