# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution appears to have transformed successfully. No build errors were detected in any of the projects within the solution. Below are steps to validate, test, and deploy the migrated project.

---

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or packages that could not be resolved. If any packages are missing or incompatible, check their NuGet pages for .NET-compatible versions and update the `.csproj` file accordingly.

---

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Review the output for any warnings, even if the build succeeds. Warnings related to nullable reference types, obsolete APIs, or platform compatibility should be addressed before proceeding.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `net6.0`), consider updating it to a current Long-Term Support (LTS) release.

---

## 4. Run Unit Tests

If the solution contains test projects, execute them with:

```bash
dotnet test --configuration Release
```

Review the test results for any failures. Failures may indicate behavioral differences between the legacy .NET Framework APIs and their cross-platform .NET equivalents.

---

## 5. Verify Runtime Behavior

Run the application locally to confirm it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Manually exercise the key features of the application, paying particular attention to:

- Database connectivity and queries
- File system operations, as path separators differ between Windows and Linux/macOS
- Any authentication or session management logic
- HTTP client calls or external service integrations

---

## 6. Check for Platform-Specific Code

Search the codebase for any APIs that were available in .NET Framework but behave differently or are unavailable in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` usage
- `BinaryFormatter`, which is disabled by default in modern .NET due to security concerns

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool to identify remaining compatibility issues:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

---

## 7. Validate Configuration

Confirm that any configuration previously stored in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or environment variables. Verify that:

- Connection strings are present and correct
- Application settings keys are mapped properly
- Environment-specific settings are handled via `appsettings.{Environment}.json`

---

## 8. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.