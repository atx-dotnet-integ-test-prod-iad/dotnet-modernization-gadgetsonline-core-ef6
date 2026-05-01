# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, particularly any areas that relied on Windows-specific APIs or legacy ASP.NET features prior to the transformation.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Review Removed or Changed APIs

Check for any usage of APIs that may have been removed or changed in cross-platform .NET. Common areas to review include:

- `System.Web` references, which are not available in .NET Core and later
- Windows-specific registry or file path assumptions
- Any third-party libraries that may have been updated or replaced during transformation

### 7. Check Static Assets and Configuration

- Verify that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`
- Confirm that static files, views, and other content files are present and correctly referenced in the new project structure

### 8. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.