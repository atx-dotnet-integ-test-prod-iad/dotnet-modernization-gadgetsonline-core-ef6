# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully. There are no build errors present in the solution. The following steps outline how to validate, test, and deploy the migrated project.

## 1. Restore Dependencies

Run the following command in the root of your solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or packages that could not be resolved. If any packages fail to restore, check that their versions are compatible with your target .NET framework.

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Review the build output for any warnings, particularly around nullable reference types, obsolete APIs, or platform compatibility. While warnings do not prevent a build, they can indicate areas that may cause runtime issues.

## 3. Review Removed or Changed APIs

Cross-platform .NET removes or changes certain APIs that were available in .NET Framework. Manually review the following areas of `GadgetsOnline` for potential runtime issues:

- **`System.Web` dependencies**: Any remaining references to `System.Web` (e.g., `HttpContext`, `HttpRequest`) should have been replaced with ASP.NET Core equivalents. Search the codebase for any lingering `using System.Web;` statements.
- **Configuration**: Verify that `Web.config` settings have been migrated to `appsettings.json` and that `IConfiguration` is used where configuration values are read.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been updated to Entity Framework Core and that migrations are compatible.
- **Session and Authentication**: Confirm that any session handling or authentication middleware is configured correctly in `Program.cs` or `Startup.cs`.

## 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that need to be updated to reflect the new platform behavior.

## 5. Run the Application Locally

Start the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the primary user-facing features of the application, particularly:

- Product browsing and search
- Shopping cart operations
- Checkout and order processing
- User authentication and account management
- Any administrative interfaces

## 6. Check Static Files and Routing

ASP.NET Core handles static files and routing differently from ASP.NET MVC on .NET Framework. Confirm the following:

- Static files (CSS, JavaScript, images) are served correctly and are located under the `wwwroot` folder.
- All routes resolve correctly and return expected responses.
- Any custom route configurations have been carried over accurately.

## 7. Review Logging and Error Handling

Verify that logging is configured and functioning:

- Check that `ILogger` is injected and used in place of any legacy logging mechanisms.
- Trigger known error conditions and confirm that errors are handled and logged appropriately.
- Review middleware order in `Program.cs` to ensure error handling middleware is registered before other middleware.

## 8. Validate Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the application can connect and query data as expected at runtime. Run any pending migrations if using Entity Framework Core:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

## 9. Publish the Application

Once local validation is complete, publish the application to prepare it for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present, including configuration files and static assets.

## 10. Deploy to Target Environment

Copy the published output to your target server or hosting environment. Ensure the target environment has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

Confirm the runtime version matches the target framework specified in `GadgetsOnline.csproj`. Start the application on the server and perform a final round of smoke testing against the deployed instance.