# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate, such as `net8.0` for ASP.NET Core.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality works as expected, including any database connections, authentication, and page rendering.

### 5. Check for Runtime Compatibility Issues

Even with a clean build, certain legacy patterns may cause runtime exceptions. Pay attention to the following areas:

- **Database access**: If the project used `System.Data` or an older ORM such as Entity Framework 6, verify that the correct version compatible with .NET is referenced and that connection strings are valid.
- **Configuration**: Legacy projects often used `Web.config` or `App.config`. Confirm that configuration has been migrated to `appsettings.json` and that `IConfiguration` is used to read values.
- **HTTP modules and handlers**: These are not supported in ASP.NET Core. Confirm they have been replaced with middleware.
- **Session and authentication**: Verify that any `FormsAuthentication` or legacy session handling has been replaced with ASP.NET Core equivalents.

### 6. Run Existing Tests

If the solution contains test projects, run them to validate that behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Static Files and wwwroot

If the project serves static content, confirm that static files such as CSS, JavaScript, and images have been moved to the `wwwroot` folder and that the following middleware is present in the application startup:

```csharp
app.UseStaticFiles();
```

### 8. Verify Middleware Pipeline Order

In ASP.NET Core, the order of middleware registration matters. Review the `Program.cs` or `Startup.cs` file and confirm the pipeline is configured in the correct order, for example:

```csharp
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and confirm all expected files are present.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the correct .NET runtime installed. You can verify this with:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).