# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your intended deployment environment.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to check for runtime exceptions that would not surface at build time.

### 5. Review Removed or Changed APIs

Cross-platform .NET removes certain Windows-specific or legacy APIs that were available in .NET Framework. Manually review the following areas if they were present in the original project:

- `System.Web` dependencies (e.g., `HttpContext`, `HttpRequest`) — these should now use `Microsoft.AspNetCore.Http` equivalents.
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`.
- `EntityFramework` (classic) — if used, verify migration to `Microsoft.EntityFrameworkCore`.
- `BinaryFormatter` — this is disabled by default in modern .NET and should be replaced with a supported serialization mechanism.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are caused by behavioral differences between .NET Framework and modern .NET.

### 7. Check Static Files and Configuration

For web projects, verify the following:

- `wwwroot` contains all expected static assets.
- `appsettings.json` contains the configuration values previously held in `Web.config` or `App.config`.
- Middleware configuration in `Program.cs` or `Startup.cs` correctly registers services such as authentication, authorization, session, and routing.

### 8. Validate Database Connectivity

If the application uses a database, confirm that connection strings in `appsettings.json` are correct and that the application can connect and perform operations against the database in the target environment.

## Deployment

### 1. Publish the Application

Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify Published Output

Inspect the `./publish` directory to confirm all required files are present, including configuration files and static assets.

### 3. Deploy to Target Environment

Copy the published output to your target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed, or use self-contained deployment by adding `--self-contained true` and specifying a runtime identifier:

```bash
dotnet publish --configuration Release --self-contained true --runtime win-x64 --output ./publish
```

Replace `win-x64` with the appropriate runtime identifier for your target platform (e.g., `linux-x64`, `osx-x64`).