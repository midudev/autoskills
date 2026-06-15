# LayerChart Tooltip Modes

## Required: Enable tooltip on Chart

The `Chart` component MUST have a `tooltip` prop to enable tooltip
detection:

```svelte
<!-- Bar charts with scaleBand -->
<Chart tooltip={{ mode: 'band' }} ...>

<!-- Area/Line charts with scaleTime -->
<Chart tooltip={{ mode: 'bisect-x' }} ...>
<Chart tooltip={{ mode: 'quadtree-x' }} ...>

<!-- Scatter plots -->
<Chart tooltip={{ mode: 'quadtree' }} ...>
```

## All Tooltip Modes

| Mode          | Use Case                                     | Notes                  |
| ------------- | -------------------------------------------- | ---------------------- |
| `band`        | Bar charts with `scaleBand()`                |                        |
| `bisect-x`    | Time-series area/line charts                 | Requires sorted values |
| `bisect-y`    | Vertical time-series charts                  | Requires sorted values |
| `bisect-band` | Mixed band/continuous scales                 | Requires sorted values |
| `quadtree`    | Scatter plots (finds nearest point)          |                        |
| `quadtree-x`  | Area charts (ignores y, finds nearest x)     |                        |
| `quadtree-y`  | Vertical charts (ignores x, finds nearest y) |                        |
| `bounds`      | Duration/range charts                        |                        |
| `voronoi`     | Complex scatter plots with voronoi cells     |                        |
| `manual`      | Custom tooltip control via `context.tooltip` | Default mode           |

## Tooltip with click handler

```svelte
<Chart
	tooltip={{
		mode: 'band',
		onclick(e, { data }) {
			alert('Clicked: ' + JSON.stringify(data))
		},
	}}
>
```

## TooltipContext Props

From the source (`TooltipContext.svelte`):

```ts
type TooltipContextProps = {
	mode?: TooltipMode // default: 'manual'
	findTooltipData?: 'closest' | 'left' | 'right' // default: 'closest'
	raiseTarget?: boolean // default: false
	locked?: boolean // default: false
	touchEvents?: 'none' | 'pan-x' | 'pan-y' | 'auto' // default: 'pan-y'
	radius?: number // default: Infinity (for quadtree/voronoi)
	debug?: boolean // default: false
	onclick?: (e: MouseEvent, { data }: { data: any }) => any
	hideDelay?: number // default: 0
}
```

## Mode Selection Guide

### For Bar Charts

```svelte
<!-- Standard horizontal bars -->
<Chart yScale={scaleBand()} tooltip={{ mode: 'band' }}>

<!-- Grouped/stacked bars -->
<Chart yScale={scaleBand()} tooltip={{ mode: 'band' }}>
```

### For Line/Area Charts

```svelte
<!-- Time-series (sorted by date) -->
<Chart x="date" tooltip={{ mode: 'bisect-x' }}>

<!-- Alternative: quadtree for unsorted -->
<Chart x="date" tooltip={{ mode: 'quadtree-x' }}>
```

### For Scatter Plots

```svelte
<!-- Find nearest point -->
<Chart tooltip={{ mode: 'quadtree' }}>

<!-- With voronoi cells (visible regions) -->
<Chart tooltip={{ mode: 'voronoi' }}>
```

### For Duration/Range Charts

```svelte
<!-- Charts with start/end values -->
<Chart x={['start', 'end']} tooltip={{ mode: 'bounds' }}>
```

## Debug Mode

Enable debug to see tooltip hit areas:

```svelte
<Chart tooltip={{ mode: 'band', debug: true }}>
```

This shows red outlines around tooltip detection areas.
