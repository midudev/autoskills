#!/bin/bash
# security-checklist.sh - Generate a security review checklist
# Usage: ./security-checklist.sh [--output checklist.md]

set -euo pipefail

OUTPUT="${{1:-/dev/stdout}}"

cat > "$OUTPUT" << 'CHECKLIST'
# Security Review Checklist

## Authentication & Authorization
- [ ] All endpoints require authentication
- [ ] Role-based access control implemented
- [ ] Session management is secure

## Input Validation
- [ ] All user inputs are validated
- [ ] SQL injection prevention
- [ ] XSS prevention

## Data Protection
- [ ] Sensitive data encrypted at rest
- [ ] Sensitive data encrypted in transit
- [ ] PII handling compliant

## TODO: Add domain-specific security checks
CHECKLIST

echo "Checklist generated: $OUTPUT" >&2
