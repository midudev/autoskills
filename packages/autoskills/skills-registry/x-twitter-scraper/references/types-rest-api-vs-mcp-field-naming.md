# Xquik REST API and MCP field naming

Hosted MCP exposes `explore` and `xquik`. It no longer exposes
operation-named tools with separate legacy response models.

Use `explore` to inspect the current operation. Then use its OpenAPI response
schema. Do not map fields through old names such as `eventData`,
`monitoredAccountId`, `following`, or `followedBy`.

Preserve every returned ID and cursor exactly. If a client transforms field
case, follow that client's serializer documentation.
