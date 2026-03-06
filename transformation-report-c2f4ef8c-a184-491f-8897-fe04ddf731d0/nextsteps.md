# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully. There are no build errors present in the solution. The following steps outline how to validate, test, and deploy the migrated project.

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

## 3. Review Replaced or Removed APIs

Cross-platform .NET removes or replaces certain APIs that were available in .NET Framework. Manually review the following areas of `GadgetsOnline` for potential runtime issues:

- **`System.Web` dependencies**: Any remaining usage of `HttpContext`, `HttpRequest`, or other `System.Web` types should be replaced with their `Microsoft.AspNetCore` equivalents.
- **`ConfigurationManager`**: Replace with `Microsoft.Extensions.Configuration` and `appsettings.json`.
- **`App.config` / `Web.config`**: Ensure configuration has been migrated to `appsettings.json` and that connection strings are correctly referenced.
- **Windows-only APIs**: Check for any P/Invoke calls or Windows Registry access that may not function on non-Windows platforms.

## 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

## 5. Manual Functional Testing

Run the application locally and manually exercise core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Specifically verify:

- Database connectivity and query execution.
- Authentication and session management, if applicable.
- Any file system operations (paths may behave differently across platforms).
- Email or external service integrations.

## 6. Validate Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to a current and supported version:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is targeting an older version such as `net6.0`, consider upgrading to `net8.0`, which is the current Long Term Support (LTS) release.

## 7. Review NuGet Package Versions

Check that all NuGet packages are up to date and compatible with the target framework:

```bash
dotnet list package --outdated
```

Update packages where appropriate, paying close attention to any that previously targeted `net4x` and may have newer cross-platform compatible versions available.

## 8. Publish the Application

Once validation is complete, publish the application to a target runtime:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

Replace `win-x64` with the appropriate runtime identifier (e.g., `linux-x64`, `osx-x64`) depending on the deployment target. Review the contents of the `publish` output folder before deploying to the target environment.