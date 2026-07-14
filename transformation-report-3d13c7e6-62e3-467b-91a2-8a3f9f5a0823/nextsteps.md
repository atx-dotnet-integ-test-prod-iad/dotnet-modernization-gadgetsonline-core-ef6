# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running the project, ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to a current long-term support (LTS) release.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality is preserved:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime.

### 5. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to identify any API usage that may have been removed or changed between the legacy .NET Framework and the current .NET version:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to:
- `System.Web` usages, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types if this is a web project
- Any Windows-specific APIs if cross-platform support is required

### 6. Verify Runtime Behavior

Run the application locally and manually exercise the core workflows to confirm runtime behavior matches the legacy application:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Test all major features, particularly those that interact with external resources such as databases, file systems, or network services.

### 7. Review Configuration Files

Ensure that configuration has been properly migrated from `Web.config` or `App.config` to the appropriate `appsettings.json` format. Verify that:
- Connection strings are present and correct
- Environment-specific settings are accounted for
- Any custom configuration sections have been re-implemented using the `Microsoft.Extensions.Configuration` APIs

### 8. Deployment

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and deploy them to the target environment according to your hosting setup, such as IIS, a self-hosted executable, or a reverse proxy configuration.