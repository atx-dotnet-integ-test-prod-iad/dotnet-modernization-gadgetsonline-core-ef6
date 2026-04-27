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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Review the output and confirm that the build succeeds with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as it did in the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently across .NET versions. Review the following areas manually:

- **HTTP and middleware configuration**: Ensure `Startup.cs` or `Program.cs` follows the current .NET hosting model conventions.
- **Entity Framework**: If EF is used, confirm migrations are compatible and the database context is correctly configured for the new runtime.
- **Authentication and Authorization**: Verify that any authentication middleware has been updated to the current API surface.
- **Static files and routing**: Confirm that static file serving and route configuration work correctly under the new framework.

### 7. Review NuGet Package Compatibility

Check that all NuGet packages referenced in the project support the target framework. Packages that were designed for .NET Framework may have limited or no support on cross-platform .NET:

```bash
dotnet list package --outdated
```

Update packages where newer, compatible versions are available.

### 8. Test on Target Platforms

Since the goal of the transformation is cross-platform support, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues.

### 9. Publish the Application

Once validation is complete, publish the application using the appropriate runtime identifier for your deployment target:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Replace `linux-x64` with the appropriate runtime identifier for your environment. Review the publish output directory to confirm all required files are present.