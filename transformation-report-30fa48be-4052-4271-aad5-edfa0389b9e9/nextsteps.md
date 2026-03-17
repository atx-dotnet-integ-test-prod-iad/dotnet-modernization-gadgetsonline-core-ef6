# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Project
Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Run Unit Tests
If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release --logger "console;verbosity=detailed"
```

Review any failing tests and compare behavior against the original legacy project.

### 4. Verify Runtime Behavior
Start the application and manually exercise core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to areas that commonly differ between legacy .NET Framework and cross-platform .NET, including:

- **Configuration**: Ensure `appsettings.json` is being read correctly if the project previously relied on `web.config` or `app.config`.
- **Database connectivity**: Confirm connection strings and any ORM (e.g., Entity Framework) migrations work as expected against the target database.
- **Authentication and Authorization**: If the project uses ASP.NET Identity or cookie-based auth, verify login and session behavior.
- **Static files and routing**: Confirm all routes resolve correctly and static assets are served as expected.
- **HTTP Client usage**: Verify any outbound HTTP calls function correctly, as `HttpClient` behavior has differences in cross-platform .NET.

### 5. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended version:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and desired, update this value and re-run the build and test steps above.

### 6. Review Removed or Replaced APIs
Check the codebase for any use of APIs that were available in .NET Framework but have changed behavior or been removed in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) can assist with identifying these if not already run.

### 7. Publish the Application
Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present before deploying to the target environment.