# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated project.

---

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these may indicate subtle compatibility issues.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

---

## 4. Verify Runtime Behavior

Run the application locally to verify that it behaves as expected at runtime:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Check for any runtime exceptions that would not have been caught at compile time, such as:

- Missing configuration keys in `appsettings.json`
- Removed or changed APIs in the new .NET version
- Middleware or startup configuration issues if this is an ASP.NET Core project

---

## 5. Check for Replaced or Removed APIs

Cross-reference the code against the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/) or use the following command to run the compatibility analyzer:

```bash
dotnet add package Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers
```

Pay particular attention to:

- `System.Web` usages, which are not available in .NET Core and beyond
- `HttpContext`, `HttpRequest`, and `HttpResponse` API differences
- Any usage of `ConfigurationManager`, which should be replaced with `IConfiguration`

---

## 6. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review the test results and investigate any failures. If no tests exist, consider writing basic integration or smoke tests to cover critical paths before deploying.

---

## 7. Validate Static Assets and Configuration Files

Ensure the following files are present and correctly configured:

- `appsettings.json` and `appsettings.Production.json` for environment-specific configuration
- Any static files (CSS, JS, images) are placed under the `wwwroot` folder if this is an ASP.NET Core web project
- Connection strings and other settings previously in `Web.config` have been migrated to `appsettings.json`

---

## 8. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.