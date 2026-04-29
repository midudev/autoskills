---
name: minimal-api-file-upload
description: File upload endpoints in ASP.NET minimal APIs (.NET 8+)
license: MIT
---

# Implementing File Uploads in ASP.NET Core Minimal APIs

## When to Use
- File upload endpoints in ASP.NET Core minimal APIs (.NET 8+)
- Handling IFormFile or IFormFileCollection parameters
- When you need size limits, content type validation, or streaming large files

## When Not to Use
- MVC controllers → `[FromForm] IFormFile` works directly with attributes
- Simple JSON body → no file upload needed
- Very large files (> 1GB) → use streaming with `MultipartReader` instead

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| File parameter(s) | Yes | IFormFile or IFormFileCollection |
| Size limits | Yes | Max file/request size |
| Allowed types | No | Content type or extension restrictions |

## Workflow

### Step 1: CRITICAL — Understand IFormFile Binding in Minimal APIs

```csharp
// In .NET 8+ minimal APIs, IFormFile binds automatically from multipart/form-data
// when it is the only complex parameter.
app.MapPost("/upload", (IFormFile file) => ...);

// CRITICAL: When you mix files with other form fields, use [FromForm] on all
// form-bound parameters (or group them into a single [FromForm] DTO).
app.MapPost("/upload-with-metadata",
    ([FromForm] IFormFile file, [FromForm] string description) =>
{
    return Results.Ok(new { file.FileName, Description = description });
});

// Multiple files: IFormFileCollection also binds automatically from multipart/form-data.
// You only need [FromForm] if you mix it with other form fields, as shown above.
app.MapPost("/upload-multiple", (IFormFileCollection files) =>
{
    return Results.Ok(files.Select(f => new { f.FileName, f.Length }));
});
```

### Step 2: CRITICAL — File Size Limits Are Separate from Request Size Limits

```csharp
// CRITICAL: There are TWO different size limits and you need to configure BOTH

// 1. Request body size limit (Kestrel level) — default is 30MB
builder.WebHost.ConfigureKestrel(options =>
{
    options.Limits.MaxRequestBodySize = 10 * 1024 * 1024; // 10 MB
});

// 2. Form options — multipart body length limit — default is 128MB
builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = 10 * 1024 * 1024; // 10 MB
    options.ValueLengthLimit = 1024 * 1024; // 1 MB for form values
    options.MultipartHeadersLengthLimit = 16384; // 16 KB for section headers
});

// COMMON MISTAKE: Only increasing Kestrel MaxRequestBodySize
// upload still fails because FormOptions.MultipartBodyLengthLimit is exceeded

// COMMON MISTAKE: Only increasing FormOptions
// upload fails with "Request body too large" from Kestrel before reaching form parsing

// CRITICAL: Per-endpoint override with RequestSizeLimit attribute
app.MapPost("/upload-large", [RequestSizeLimit(200_000_000)] (IFormFile file) =>
{
    return Results.Ok(new { file.FileName, file.Length });
});

// CRITICAL: To disable the limit entirely (for streaming):
app.MapPost("/upload-unlimited", [DisableRequestSizeLimit] async (HttpContext context) =>
{
    // Handle manually
});
```

### Step 3: CRITICAL — Anti-Forgery Auto-Validates Form Uploads in .NET 8+

```csharp
// CRITICAL: In .NET 8+ with UseAntiforgery(), ALL form-bound endpoints
// automatically validate anti-forgery tokens, INCLUDING file uploads

builder.Services.AddAntiforgery();
var app = builder.Build();
app.UseAntiforgery();

// This endpoint now REQUIRES an anti-forgery token:
app.MapPost("/upload", (IFormFile file) => Results.Ok(file.FileName));
// Without the token → 400 Bad Request

// CRITICAL: For API-only file uploads (no anti-forgery needed), opt out:
app.MapPost("/api/upload", (IFormFile file) => Results.Ok(file.FileName))
    .DisableAntiforgery();  // CRITICAL: Must explicitly opt out

// COMMON MISTAKE: Getting 400 errors on file uploads and not realizing
// it's because UseAntiforgery() is in the pipeline

// WARNING: DisableAntiforgery() is safe for unauthenticated endpoints and
// endpoints using JWT bearer authentication. However, for endpoints
// authenticated with cookies, disabling antiforgery removes CSRF protection
// and exposes the endpoint to cross-site request forgery attacks.
// For cookie-authenticated endpoints, include a valid antiforgery token instead.
```

### Step 4: CRITICAL — Validate File Content, Not Just Extension

```csharp
app.MapPost("/upload", async (IFormFile file) =>
{
    // CRITICAL: Check content type AND file signature (magic bytes)
    // NEVER trust file extension alone — it can be spoofed

    // Allow only JPEG/PNG by default. To support more (e.g., GIF),
    // add the MIME type here AND validate its magic bytes below.
    var allowedTypes = new[] { "image/jpeg", "image/png" };
    if (!allowedTypes.Contains(file.ContentType, StringComparer.OrdinalIgnoreCase))
        return Results.BadRequest("File type not allowed");

    // CRITICAL: Check magic bytes for file type verification
    using var stream = file.OpenReadStream();
    var header = new byte[8];
    var bytesRead = await stream.ReadAsync(header, 0, header.Length);
    if (bytesRead < 4)
        return Results.BadRequest("File content is too short or invalid");

    // JPEG: FF D8 FF
    // PNG: 89 50 4E 47
    var isJpeg = header[0] == 0xFF && header[1] == 0xD8 && header[2] == 0xFF;
    var isPng = header[0] == 0x89 && header[1] == 0x50 && header[2] == 0x4E && header[3] == 0x47;

    // Determine the actual content type from magic bytes
    string? detectedContentType = isJpeg ? "image/jpeg" : isPng ? "image/png" : null;
    if (detectedContentType is null)
        return Results.BadRequest("File content is not a supported image format (only JPEG and PNG are allowed).");

    // Ensure the declared Content-Type matches what the magic bytes detected
    if (!string.Equals(file.ContentType, detectedContentType, StringComparison.OrdinalIgnoreCase))
        return Results.BadRequest("File content type does not match the declared ContentType header.");

    // CRITICAL: Never use the user-provided filename directly for the save path — it can
    // contain path traversal characters (e.g., "../../../etc/passwd").
    // Generate a safe filename; derive the extension from validated content, not user input.
    var extension = detectedContentType == "image/jpeg" ? ".jpg" : ".png";
    var safeFileName = $"{Guid.NewGuid()}{extension}";
    // NEVER: var path = Path.Combine("uploads", file.FileName);     // Path traversal!

    var filePath = Path.Combine("uploads", safeFileName);
    Directory.CreateDirectory("uploads");
    stream.Position = 0;
    using var fileStream = File.Create(filePath);
    await stream.CopyToAsync(fileStream);

    return Results.Ok(new { FileName = safeFileName, file.Length });
});
```

### Step 5: CRITICAL — Streaming Large Files Without Buffering

```csharp
// CRITICAL: IFormFile relies on multipart form parsing that buffers content in memory
// (up to a threshold) then spills to temp files on disk. For very large uploads,
// this overhead is unnecessary if you can process the data in chunks.
// Use MultipartReader to stream directly — e.g., to a final storage location —
// without buffering the entire file first.

app.MapPost("/upload-stream",
    [DisableRequestSizeLimit]
    async (HttpContext context) =>
{
    // Extract the multipart boundary from the Content-Type header
    var contentType = context.Request.ContentType;
    if (contentType == null)
        return Results.BadRequest("Missing Content-Type");

    // Safely parse the Content-Type header to avoid FormatException from MediaTypeHeaderValue.Parse
    if (!MediaTypeHeaderValue.TryParse(contentType, out var mediaType))
        return Results.BadRequest("Invalid Content-Type");

    var boundary = HeaderUtilities.RemoveQuotes(mediaType.Boundary).Value;
    if (string.IsNullOrWhiteSpace(boundary))
        return Results.BadRequest("Not a multipart request");

    var reader = new MultipartReader(boundary, context.Request.Body);

    // CRITICAL: ReadNextSectionAsync returns null when there are no more sections
    while (await reader.ReadNextSectionAsync() is { } section)
    {
        // Parse Content-Disposition to identify file sections
        if (!ContentDispositionHeaderValue.TryParse(section.ContentDisposition, out var contentDisposition))
            continue;

        if (contentDisposition.DispositionType.Equals("form-data")
            && !string.IsNullOrEmpty(contentDisposition.FileName.Value))
        {
            // Sanitize the user-provided filename to prevent path traversal
            var originalFileName = contentDisposition.FileName.Value ?? string.Empty;
            var sanitizedFileName = Path.GetFileName(originalFileName.Trim('"'));
            var safeFile = $"{Guid.NewGuid()}";

            // CRITICAL: Stream directly to disk — avoids buffering in memory
            Directory.CreateDirectory("uploads");
            using var fileStream = File.Create(Path.Combine("uploads", safeFile));
            await section.Body.CopyToAsync(fileStream);
        }
    }

    return Results.Ok("Uploaded");
}).DisableAntiforgery();

// COMMON MISTAKE: Using IFormFile for very large files
// Multipart form parsing can buffer large uploads and consume memory/disk.
// Use MultipartReader for streaming directly to storage.
```

## Common Mistakes

1. **Only configuring one size limit**: Must configure BOTH Kestrel `MaxRequestBodySize` AND `FormOptions.MultipartBodyLengthLimit`.
2. **400 errors from anti-forgery**: In .NET 8+, `UseAntiforgery()` auto-validates form uploads. Use `.DisableAntiforgery()` for API endpoints (safe for JWT/unauthenticated; do NOT disable for cookie-authenticated endpoints).
3. **Trusting file.FileName**: User-provided filename can contain path traversal. Generate a safe filename with `Guid.NewGuid()` and derive the extension from validated content.
4. **Trusting Content-Type only**: Content type is client-spoofable. Always check magic bytes for actual file type verification.
5. **Using IFormFile for very large files**: Multipart form parsing buffers with a memory threshold and spills to temp files. Use `MultipartReader` to stream data in chunks directly to storage without buffering the entire file.
6. **Deriving file extension from user input**: Prefer deriving the extension from the validated content type or magic bytes rather than `Path.GetExtension(file.FileName)`. If the original extension must be preserved, validate it against the detected content type.
