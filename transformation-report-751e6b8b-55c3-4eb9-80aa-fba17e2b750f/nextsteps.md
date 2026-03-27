# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Verify Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 2. Restore and Build from the Command Line

Run the following commands from the solution root to confirm a clean restore and build outside of any IDE:

```bash
dotnet restore
dotnet build
```

Ensure both commands complete with no errors or warnings that could indicate unresolved dependencies.

### 3. Run the Test Suite

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review the output for any failing tests and address them before proceeding.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows and confirm core functionality behaves correctly.

### 5. Check for Removed or Changed APIs

Review any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` on non-Windows platforms
- Any third-party NuGet packages that may still target only .NET Framework — verify each package supports the new target framework

### 6. Review NuGet Package Compatibility

Open the `.csproj` file and inspect each `<PackageReference>`. For any package that looks outdated, check [NuGet.org](https://www.nuget.org) to confirm a compatible version exists for your target framework and update accordingly:

```bash
dotnet list package --outdated
```

### 7. Validate Configuration Files

If the project previously used `Web.config` or `App.config`, confirm that configuration has been migrated to `appsettings.json` and that values such as connection strings and application settings are loading correctly at runtime.

### 8. Test on Target Platforms

If cross-platform support is a goal, run the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues that would not appear during a build.

## Deployment

Once all validation steps above pass:

1. Publish a release build using:
   ```bash
   dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish
   ```
2. Verify the contents of the `./publish` output directory contain all expected files.
3. Deploy the contents of the `./publish` directory to the target hosting environment following the environment's standard deployment procedure.