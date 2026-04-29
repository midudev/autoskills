# Redis Development

A structured repository for creating and maintaining Redis development guidelines optimized for agents and LLMs.


## Structure

- `rules/` - Individual rule files (one per rule)
  - `_sections.md` - Section metadata (titles, impacts, descriptions)
  - `_template.md` - Template for creating new rules
  - `_contributing.md` - Contribution guidelines (excluded from build)
  - `prefix-description.md` - Individual rule files
- `metadata.json` - Document metadata (version, organization, abstract)
- `AGENTS.md` - Compiled output (generated)
- `SKILL.md` - Skill definition and entry point
- `README.md` - This file


## Getting Started

1. Install dependencies from the repo root:
   ```bash
   npm install
   ```

3. Validate rule files:
   ```bash
   npm run validate
   ```

4. Build AGENTS.md from rules:
   ```bash
   npm run build
   ```


## Creating a New Rule

1. Copy `rules/_template.md` to `rules/prefix-description.md`
2. Choose the appropriate area prefix:
   - `data-` for Data Structures & Keys
   - `ram-` for Memory & Expiration
   - `conn-` for Connection & Performance
   - `json-` for JSON Documents
   - `rqe-` for Redis Query Engine
   - `vector-` for Vector Search & RedisVL
   - `semantic-cache-` for Semantic Caching
   - `stream-` for Streams & Pub/Sub
   - `cluster-` for Clustering & Replication
   - `security-` for Security
   - `observe-` for Observability
3. Fill in the frontmatter and content
4. Ensure you have clear examples with explanations
5. Run `npm run build` (in the build package) to regenerate AGENTS.md


## Rule File Structure

Each rule file should follow this structure:

```markdown
---
title: Rule Title Here
impact: MEDIUM
impactDescription: Optional description
tags: tag1, tag2, tag3
description: Rule Title Here
alwaysApply: true
---

## Rule Title Here

Brief explanation of the rule and why it matters.
```

**Incorrect: (description of what's wrong)**

```python
# Bad code example
```

**Correct: (description of what's right)**

```python
# Good code example
```

Optional explanatory text after examples.

Reference: [Link](https://example.com/)

## File Naming Convention

- Files starting with `_` are special (excluded from build)
- Rule files: `prefix-description.md` (e.g., `data-key-naming.md`)
- Section is automatically inferred from filename prefix
- Rules are sorted alphabetically by title within each section


## Impact Levels

- `HIGH` - Significant performance improvements or critical security practices
- `MEDIUM` - Moderate performance improvements or recommended patterns
- `LOW` - Incremental improvements


## Scripts

(Run these from the repo root)

- `npm run build` - Compile rules into AGENTS.md
- `npm run validate` - Validate all rule files
- `npm run dev` - Build and validate (if configured)


## Contributing

When adding or modifying rules:

1. Use the correct filename prefix for your section
2. Follow the `_template.md` structure
3. Include clear bad/good examples with explanations
4. Add appropriate tags
5. Run `npm run build` to regenerate AGENTS.md
