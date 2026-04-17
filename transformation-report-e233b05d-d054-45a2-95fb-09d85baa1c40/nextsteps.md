# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts that may cause runtime issues even if they do not produce build errors.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Ensure it is not targeting `net5.0` or `net6.0` unless that is intentional, as those versions are out of support.

### 4. Check for Runtime Dependencies
Some legacy dependencies may resolve at build time but fail at runtime. Review the following:

- Any use of `System.Web` namespaces, which are not available in cross-platform .NET.
- References to Windows-specific APIs (e.g., registry access, Windows authentication) that may fail on non-Windows platforms.
- Any `<PackageReference>` items that are compatibility shims (e.g., `Microsoft.Windows.Compatibility`) and assess whether they are still needed.

### 5. Run the Application Locally
Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows, particularly any areas that relied on legacy ASP.NET features such as:

- Session and authentication handling
- HTTP modules or handlers that may have been migrated to middleware
- Database connectivity (Entity Framework or ADO.NET)

### 6. Execute Existing Tests
If a test project exists in the solution, run it to validate core logic:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy framework and the new target framework.

### 7. Verify Static Assets and Views
If the project is a web application, confirm that:

- Razor views render correctly.
- Static files (CSS, JavaScript, images) are served as expected.
- Any `bundleconfig.json` or asset pipeline configuration has been migrated appropriately (e.g., using LibMan or a compatible tool).

### 8. Database Migrations
If the project uses Entity Framework, verify that existing migrations are compatible with the new version:

```bash
dotnet ef migrations list
dotnet ef database update
```

If migrations fail, you may need to review changes in EF Core behavior compared to EF6.

### 9. Publish a Test Build
Produce a published output to confirm the application packages correctly before any deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to ensure all required files, including configuration files and static assets, are present.