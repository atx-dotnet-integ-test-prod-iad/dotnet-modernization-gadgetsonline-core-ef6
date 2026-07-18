# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Project

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework APIs and the new cross-platform .NET runtime.

### 5. Check for Runtime-Only Issues

Some issues do not surface at compile time. Pay particular attention to the following areas at runtime:

- **Configuration**: Ensure `appsettings.json` is present and replaces any legacy `Web.config` or `App.config` values that were previously used.
- **Static files and content**: Verify that static assets (CSS, JS, images) are served correctly if this is a web project.
- **Database connectivity**: Test all database connection strings and confirm Entity Framework migrations (if applicable) run successfully with `dotnet ef database update`.
- **Authentication and authorization**: If the project uses ASP.NET Identity or custom middleware, validate login and access control flows manually.
- **File paths**: Cross-platform .NET is case-sensitive on Linux and macOS. Verify that all file path references use the correct casing.

### 6. Check for Removed or Changed APIs

Review the code for any use of APIs that were removed or significantly changed in cross-platform .NET. Microsoft provides a compatibility analyzer that can assist:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
```

Run the build again after adding the analyzer and address any reported compatibility warnings.

### 7. Run the Application Locally

Start the application and perform a manual walkthrough of its core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Test all major user-facing features, including any e-commerce flows such as product browsing, cart management, and checkout if applicable to this project.

### 8. Publish a Release Build

Once the application has been validated locally, produce a published output to confirm the publish process works correctly:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.