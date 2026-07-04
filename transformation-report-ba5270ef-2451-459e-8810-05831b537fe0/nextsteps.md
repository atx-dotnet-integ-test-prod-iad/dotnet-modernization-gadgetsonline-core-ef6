# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution to cross-platform .NET appears to have completed successfully. No build errors were detected in any of the projects within the solution.

## Validation and Testing

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

### 2. Build the Solution

Perform a full build to confirm the solution compiles cleanly:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that may indicate deprecated APIs or compatibility concerns, even if they do not block the build.

### 3. Review Replaced or Removed APIs

Cross-platform .NET does not support certain legacy APIs that were available in .NET Framework. Manually review the following areas of `GadgetsOnline` for potential runtime issues:

- **`System.Web` dependencies**: Any remaining usage of `System.Web` types (e.g., `HttpContext`, `HttpRequest`) should be replaced with their `Microsoft.AspNetCore.Http` equivalents.
- **`ConfigurationManager`**: If the project previously used `System.Configuration.ConfigurationManager`, ensure configuration has been migrated to `appsettings.json` and `IConfiguration`.
- **`Global.asax`**: If a `Global.asax` file existed, confirm its logic has been moved to `Program.cs` or `Startup.cs`.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been updated to Entity Framework Core and that migrations are functioning correctly.

### 4. Run Unit Tests

If the solution contains test projects, execute the tests to verify functional correctness:

```bash
dotnet test --configuration Release
```

Address any failing tests before proceeding to deployment.

### 5. Run the Application Locally

Start the application locally and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the primary user flows of the application, including:

- Page rendering and navigation
- Database read and write operations
- Authentication and authorization flows, if applicable
- Any third-party integrations

### 6. Check the Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If you intend to use a different supported version of .NET, update this value accordingly and re-run the build.

### 7. Review `appsettings.json`

Confirm that all connection strings, application settings, and environment-specific configuration values have been correctly migrated from `Web.config` to `appsettings.json` or `appsettings.{Environment}.json`.

### 8. Publish the Application

Once local validation is complete, publish the application to a folder to verify the output:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present, then deploy the contents to your target hosting environment.