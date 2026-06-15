# LayerChart Svelte 5 Full Patterns

## Svelte 5 Snippet Patterns

### Tooltip.Root children snippet

**WRONG:**

```svelte
<Tooltip.Root let:data>
	<Tooltip.Header>{data.label}</Tooltip.Header>
</Tooltip.Root>
```

**CORRECT (Svelte 5):**

```svelte
<Tooltip.Root>
	{#snippet children({ data })}
		<Tooltip.Header>{data.label}</Tooltip.Header>
		<Tooltip.List>
			<Tooltip.Item label="Value" value={data.value} />
		</Tooltip.List>
	{/snippet}
</Tooltip.Root>
```

The `children` snippet receives `{ data, payload }`:

- `data` - The chart data point that triggered the tooltip
- `payload` - Array of tooltip payloads for multi-series charts

### Chart children snippet

Access context via the `children` snippet:

```svelte
<Chart {data} x="date" y="value">
	{#snippet children({ context })}
		<!-- Access scales, dimensions, tooltip state -->
		{const avg = mean(data, (d) => d.value)}
		<Svg>
			<Rule x={avg} />
			<Text x={context.xScale(avg)} y={0} value="Avg" />
		</Svg>
	{/snippet}
</Chart>
```

### LinearGradient children snippet

```svelte
<LinearGradient class="from-primary/50 to-primary/1" vertical>
	{#snippet children({ gradient })}
		<Area
			fill={gradient}
			line={{ class: 'stroke-primary stroke-2' }}
		/>
	{/snippet}
</LinearGradient>
```

### Highlight area snippet

```svelte
<Highlight>
	{#snippet area({ area })}
		<RectClipPath
			x={area.x}
			y={area.y}
			width={area.width}
			height={area.height}
		>
			<Bars class="fill-primary" />
		</RectClipPath>
	{/snippet}
</Highlight>
```

### Axis tickLabel snippet

```svelte
<Axis
	placement="bottom"
	format="day"
	ticks={(scale) => scale.domain()}
>
	{#snippet tickLabel({ props, index })}
		<Text {...props} textAnchor={index ? 'end' : 'start'} />
	{/snippet}
</Axis>
```

### Spline endContent snippet

```svelte
<Spline {data} class="stroke-2" stroke={color}>
	{#snippet endContent()}
		<Circle r={4} fill={color} />
		<Text value={label} dx={6} class="text-xs" fill={color} />
	{/snippet}
</Spline>
```

## Typing the Snippet Data

To avoid implicit `any` errors, type the data:

```svelte
<script lang="ts">
	type YearlyData = { year: string; visitors: number }
</script>

<Tooltip.Root>
	{#snippet children({ data }: { data: YearlyData })}
		<Tooltip.Header>{data.year}</Tooltip.Header>
	{/snippet}
</Tooltip.Root>
```

## Complete Bar Chart Example

```svelte
<script lang="ts">
	import { scaleBand } from 'd3-scale'
	import {
		Axis,
		Bars,
		Chart,
		Highlight,
		Svg,
		Tooltip,
	} from 'layerchart'

	type DataPoint = { label: string; value: number }
	let data: DataPoint[] = [
		{ label: '2023', value: 100 },
		{ label: '2024', value: 150 },
	]
</script>

<div class="h-64">
	<Chart
		{data}
		x="value"
		xDomain={[0, null]}
		xNice
		y="label"
		yScale={scaleBand().padding(0.4)}
		padding={{ left: 48, bottom: 24 }}
		tooltip={{ mode: 'band' }}
	>
		<Svg>
			<Axis placement="bottom" grid rule />
			<Axis placement="left" rule />
			<Bars radius={4} class="fill-primary" />
			<Highlight area />
		</Svg>
		<Tooltip.Root>
			{#snippet children({ data }: { data: DataPoint })}
				<Tooltip.Header>{data.label}</Tooltip.Header>
				<Tooltip.List>
					<Tooltip.Item label="Value" value={data.value} />
				</Tooltip.List>
			{/snippet}
		</Tooltip.Root>
	</Chart>
</div>
```

## Complete Area Chart Example

```svelte
<script lang="ts">
	import { Area, Axis, Chart, Highlight, Svg, Tooltip } from 'layerchart'

	type TimeData = { date: Date; value: number }
	let data: TimeData[] = [...]
</script>

<div class="h-48">
	<Chart
		{data}
		x="date"
		y="value"
		yDomain={[0, null]}
		yNice
		padding={{ left: 40, bottom: 24 }}
		tooltip={{ mode: 'bisect-x' }}
	>
		<Svg>
			<Axis placement="left" grid rule />
			<Axis placement="bottom" rule />
			<Area
				line={{ class: 'stroke-primary stroke-2' }}
				class="fill-primary/20"
			/>
			<Highlight points lines />
		</Svg>
		<Tooltip.Root>
			{#snippet children({ data }: { data: TimeData })}
				<Tooltip.Header
					>{data.date.toLocaleDateString()}</Tooltip.Header
				>
				<Tooltip.List>
					<Tooltip.Item label="Value" value={data.value} />
				</Tooltip.List>
			{/snippet}
		</Tooltip.Root>
	</Chart>
</div>
```

## Multi-series with Context Access

```svelte
<Chart
	data={flatData}
	x="date"
	y="value"
	c="series"
	cDomain={['apples', 'bananas']}
	cRange={['var(--color-info)', 'var(--color-success)']}
	tooltip={{ mode: 'quadtree' }}
>
	{#snippet children({ context })}
		<Svg>
			{#each seriesData as [series, data]}
				{const color = context.cScale?.(series)}
				{const active =
					context.tooltip.data == null ||
					context.tooltip.data.series === series}
				<g class={!active ? 'opacity-20' : ''}>
					<Spline {data} stroke={color} class="stroke-2" />
				</g>
			{/each}
			<Highlight points lines />
		</Svg>

		<Tooltip.Root>
			{#snippet children({ data })}
				<Tooltip.Header value={data.date} format="day" />
				<Tooltip.List>
					<Tooltip.Item
						label={data.series}
						value={data.value}
						color={context.cScale?.(data.series)}
					/>
				</Tooltip.List>
			{/snippet}
		</Tooltip.Root>
	{/snippet}
</Chart>
```

## Manual Tooltip Control

For custom tooltip behaviour (e.g., individual bar tooltips):

```svelte
<Chart {data} x="values" y="year">
	{#snippet children({ context })}
		<Svg>
			{#each data as d}
				<Bar
					data={d}
					onpointerenter={(e) => context.tooltip.show(e, d)}
					onpointermove={(e) => context.tooltip.show(e, d)}
					onpointerleave={() => context.tooltip.hide()}
					onclick={() => alert(JSON.stringify(d))}
				/>
			{/each}
		</Svg>

		<Tooltip.Root>
			{#snippet children({ data })}
				<Tooltip.Header>{data.year}</Tooltip.Header>
			{/snippet}
		</Tooltip.Root>
	{/snippet}
</Chart>
```

## Calendar Heatmap

```svelte
<script lang="ts">
	import { Calendar, Chart, Svg, Tooltip } from 'layerchart'
	import { scaleSequential } from 'd3-scale'
	import { interpolateGreens } from 'd3-scale-chromatic'

	type DayData = { date: Date; value: number }
	let { data }: { data: DayData[] } = $props()

	const colorScale = scaleSequential(interpolateGreens).domain([0, 10])
</script>

<div class="h-32">
	<Chart {data} x="date" tooltip={{ mode: 'band' }}>
		<Svg>
			<Calendar
				{colorScale}
				cellSize={12}
				cellGap={2}
				monthLabels
				weekdayLabels
			/>
		</Svg>
		<Tooltip.Root>
			{#snippet children({ data }: { data: DayData })}
				<Tooltip.Header>
					{data.date.toLocaleDateString()}
				</Tooltip.Header>
				<Tooltip.Item label="Count" value={data.value} />
			{/snippet}
		</Tooltip.Root>
	</Chart>
</div>
```

## Pie/Donut Chart

```svelte
<script lang="ts">
	import { Arc, Chart, Pie, Svg, Tooltip } from 'layerchart'

	type SliceData = { label: string; value: number; color: string }
	let { data }: { data: SliceData[] } = $props()
</script>

<div class="h-64">
	<Chart {data} tooltip={{ mode: 'manual' }}>
		<Svg>
			<Pie
				value="value"
				innerRadius={40}
				padAngle={0.02}
				cornerRadius={4}
			>
				{#snippet children({ arcs })}
					{#each arcs as arc}
						<Arc data={arc} fill={arc.data.color} />
					{/each}
				{/snippet}
			</Pie>
		</Svg>
	</Chart>
</div>
```

## Common Imports

```ts
import { scaleBand, scaleTime, scaleOrdinal } from "d3-scale";
import {
  Arc,
  Area,
  Axis,
  Bar,
  Bars,
  Calendar,
  Canvas,
  Chart,
  Circle,
  ForceGraph,
  ForceSimulation,
  Group,
  Highlight,
  Labels,
  Layer,
  LinearGradient,
  Link,
  Pie,
  Points,
  RectClipPath,
  Rule,
  Spline,
  Svg,
  Text,
  Tooltip,
  Transform,
} from "layerchart";
```
