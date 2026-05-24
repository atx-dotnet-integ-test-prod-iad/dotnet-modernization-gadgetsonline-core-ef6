# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution appears to have completed successfully. No build errors were detected across any of the projects in the solution.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the root of your solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution
Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally
Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying attention to areas that relied on Windows-specific APIs or legacy ASP.NET features prior to transformation.

### 5. Check for Replaced or Removed APIs
Review the code for any usage of APIs that were commonly replaced during migration, including:

- `System.Web` references (should be replaced with `Microsoft.AspNetCore.*`)
- `HttpContext.Current` (should use injected `IHttpContextAccessor`)
- `Session` and `Cache` usage (should use `ISession` and `IMemoryCache` respectively)
- `Global.asax` logic (should be moved to `Program.cs` or `Startup.cs`)

### 6. Verify Static Files and Content
Confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder, as ASP.NET Core serves static files from that directory by default. Files left in their legacy locations will not be served correctly.

### 7. Validate Configuration
Check that `Web.config` settings have been properly migrated to `appsettings.json`. Connection strings, application settings, and custom configuration sections should all be present and correctly formatted:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  },
  "AppSettings": {
    "Key": "Value"
  }
}
```

### 8. Test Data Access
If the project uses Entity Framework, confirm the version being used is Entity Framework Core and run any pending migrations:

```bash
dotnet ef database update
```

If the project uses raw ADO.NET or another ORM, verify that the connection and query logic functions correctly against your database.

### 9. Execute Existing Tests
If the solution contains test projects, run them to establish a baseline:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 10. Publish the Application
Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files, including views, static assets, and configuration files, are present before deploying to your target environment.