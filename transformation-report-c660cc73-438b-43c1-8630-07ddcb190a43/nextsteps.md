# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully. There are no build errors present in the solution. The following steps outline how to validate, test, and deploy the migrated project.

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

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

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

## 4. Verify Runtime Behavior

Run the application locally to confirm it starts and behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to identify any runtime exceptions that would not surface at compile time.

## 5. Check for Removed or Changed APIs

Cross-platform .NET removed several APIs that were available in .NET Framework. Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any calls to APIs that may behave differently or are unavailable on non-Windows platforms:

```bash
dotnet tool install -g dotnet-compatibility
```

Pay particular attention to:
- `System.Web` dependencies that may have been replaced with ASP.NET Core equivalents
- Windows-specific registry or file path APIs
- `HttpContext` and session handling patterns

## 6. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

## 7. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues that would not appear in a single-environment test.

## 8. Review Static Files and Configuration

For web projects, confirm that:
- `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder
- Connection strings and environment-specific settings are correctly configured

## 9. Publish the Application

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm all required assets and dependencies are present before deploying to the target environment.