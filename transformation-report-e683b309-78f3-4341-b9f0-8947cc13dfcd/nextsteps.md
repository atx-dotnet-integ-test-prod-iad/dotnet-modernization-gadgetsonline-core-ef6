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

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas where the code relies on legacy behavior.

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

## 4. Verify Application Configuration

- Confirm that `appsettings.json` (and `appsettings.Development.json` if applicable) contains all configuration values that were previously held in `Web.config` or `App.config`.
- Check that connection strings, application settings, and any environment-specific values have been correctly migrated.

## 5. Check Static Files and wwwroot

If this is a web project, verify that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, as this is the expected structure for ASP.NET Core applications.

## 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL indicated in the console output and manually verify that core functionality behaves as expected.

## 7. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that require updates due to API changes in the new framework.

## 8. Review Middleware and HTTP Pipeline

For ASP.NET Core web projects, review `Program.cs` (and `Startup.cs` if still present) to confirm that middleware is registered in the correct order. Pay particular attention to:

- Authentication and authorization middleware
- Session middleware
- Static file middleware
- Routing configuration

## 9. Validate Database Connectivity

If the project uses Entity Framework or another data access layer, run a quick connectivity check and, if applicable, verify that any pending migrations are applied:

```bash
dotnet ef database update
```

Confirm that the database schema matches what the application expects.

## 10. Review Removed or Changed APIs

Cross-reference any usages of APIs that were available in the .NET Framework but have changed or been removed in modern .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/) and the official [.NET API compatibility documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/) are useful references for this step.