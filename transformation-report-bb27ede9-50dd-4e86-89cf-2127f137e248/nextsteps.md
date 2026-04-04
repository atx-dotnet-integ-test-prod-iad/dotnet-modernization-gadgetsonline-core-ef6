# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-breaking, may indicate deprecated APIs or framework-specific code paths that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET release schedule](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure you are targeting a version that is still within its support window.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Manually exercise the primary features of the application to verify runtime behavior matches expectations from the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them with:

```bash
dotnet test
```

Review any failing tests to determine whether they indicate regressions introduced during the migration or tests that need to be updated to reflect new framework behavior.

### 6. Check for Removed or Changed APIs

Even without build errors, certain APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm any such usages have been fully replaced with ASP.NET Core equivalents.
- **Configuration**: Ensure `web.config`-based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` stack.
- **Authentication and Authorization**: Verify that any membership or identity providers have been migrated to ASP.NET Core Identity or an equivalent.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that all queries function correctly.
- **HTTP Modules and Handlers**: These do not exist in ASP.NET Core. Confirm they have been replaced with middleware.

### 7. Validate Static Files and Routing

Confirm that static file serving and routing are configured correctly in `Program.cs` or `Startup.cs`, particularly:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.MapControllerRoute(...);
```

### 8. Test on Target Operating Systems

Since the goal is cross-platform compatibility, run the application on each operating system you intend to support (Windows, Linux, macOS) and verify consistent behavior, particularly around:

- File path handling (case sensitivity on Linux)
- Date and time formatting
- Culture-specific behavior

### 9. Review Warnings as Errors

Consider enabling `<TreatWarningsAsErrors>true</TreatWarningsAsErrors>` in the project file temporarily to surface any latent issues that are currently reported only as warnings:

```xml
<PropertyGroup>
  <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
</PropertyGroup>
```

Address any issues surfaced before reverting this setting if needed.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required assets, configuration files, and binaries are present before deploying to the target environment.