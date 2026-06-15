---
name: svelte-layerchart
# prettier-ignore
description: "Build Svelte LayerChart components. Use for tooltip snippets, Chart context access, gradients, highlights, axes, and Svelte 5 snippet patterns."
metadata:
  last_updated: "2026-05-31"
  verified_against: "Svelte 5 official docs and sveltejs/svelte#18282"
---

# Svelte LayerChart

Docs: **layerchart.com**

## Install

```bash
npm i layerchart d3-scale
```

## Quick Start

```svelte
<Chart {data} x="date" y="value" tooltip={{ mode: 'bisect-x' }}>
	<Svg><Area class="fill-primary/20" /><Highlight points /></Svg>
	<Tooltip.Root>{#snippet children({ data })}{data.value}{/snippet}</Tooltip.Root>
</Chart>
```

## Core Patterns

- **Tooltip**: `{#snippet children({ data })}` - NOT `let:data`
- **Chart context**: `{#snippet children({ context })}`
- **Gradient**: `{#snippet children({ gradient })}`
- **Enable tooltip**: `tooltip={{ mode: 'band' | 'bisect-x' }}`
- **Type data**: `{#snippet children({ data }: { data: MyType })}`

## Tooltip Modes

| Mode         | Use Case               |
| ------------ | ---------------------- |
| `band`       | Bar charts (scaleBand) |
| `bisect-x`   | Time-series area/line  |
| `quadtree-x` | Area (nearest x)       |
| `quadtree`   | Scatter plots          |

## References

- [full-patterns.md](references/full-patterns.md) - Area, Bar, Pie,
  Calendar
- [tooltip-modes.md](references/tooltip-modes.md) - All modes
- [graph-patterns.md](references/graph-patterns.md) - ForceGraph,
  zoom/pan
