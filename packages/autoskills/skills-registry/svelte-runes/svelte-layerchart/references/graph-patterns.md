# LayerChart Graph & Network Patterns

## ForceGraph Basic

```svelte
<script lang="ts">
	import {
		Chart,
		ForceSimulation,
		Group,
		Link,
		ForceGraph,
		Svg,
		Text,
	} from 'layerchart'
	import {
		forceCenter,
		forceCollide,
		forceLink,
		forceManyBody,
	} from 'd3-force'

	type Node = { id: string; label: string; group?: string }
	type LinkType = { source: string; target: string }

	let { nodes, links }: { nodes: Node[]; links: LinkType[] } = $props()
</script>

<div class="h-96">
	<Chart>
		<Svg>
			<ForceGraph {nodes} {links}>
				<ForceSimulation
					forces={{
						charge: forceManyBody().strength(-100),
						center: forceCenter(),
						collide: forceCollide(20),
						link: forceLink().id((d) => d.id),
					}}
				>
					{#snippet children({ simulation })}
						{#each simulation.links as link}
							<Link
								data={link}
								class="stroke-surface-content/30"
							/>
						{/each}
						{#each simulation.nodes as node}
							<Group x={node.x} y={node.y}>
								<circle r="8" class="fill-primary" />
								<Text
									value={node.label}
									dy={-12}
									textAnchor="middle"
									class="text-xs"
								/>
							</Group>
						{/each}
					{/snippet}
				</ForceSimulation>
			</ForceGraph>
		</Svg>
	</Chart>
</div>
```

## ForceGraph with Transform (Zoom/Pan)

```svelte
<Chart>
	<Canvas>
		<Transform mode="canvas" initialTransform={{ scale: 0.8 }}>
			<ForceGraph {nodes} {links}>
				<ForceSimulation>
					<!-- ... -->
				</ForceSimulation>
			</ForceGraph>
		</Transform>
	</Canvas>
</Chart>
```

**CRITICAL**: Use `mode="canvas"` for zoom/pan controls in Canvas
context.

## Force Configuration

```ts
import {
  forceCenter,
  forceCollide,
  forceLink,
  forceManyBody,
  forceX,
  forceY,
} from "d3-force";

const forces = {
  // Repulsion between nodes
  charge: forceManyBody().strength(-200),

  // Center gravity
  center: forceCenter(),

  // Prevent overlap
  collide: forceCollide(30),

  // Link distance
  link: forceLink()
    .id((d) => d.id)
    .distance(50),

  // Pull toward x/y positions
  x: forceX().strength(0.1),
  y: forceY().strength(0.1),
};
```

## Node Styling by Group

```svelte
{#each simulation.nodes as node}
	<Group x={node.x} y={node.y}>
		<circle
			r={node.size ?? 8}
			class={node.group === 'primary'
				? 'fill-primary'
				: 'fill-secondary'}
		/>
	</Group>
{/each}
```

## Link Styling

```svelte
{#each simulation.links as link}
	<Link
		data={link}
		class="stroke-surface-content/20"
		strokeWidth={link.weight ?? 1}
	/>
{/each}
```

## Common Imports

```ts
import {
  Canvas,
  Chart,
  ForceGraph,
  ForceSimulation,
  Group,
  Link,
  Svg,
  Text,
  Transform,
} from "layerchart";
import { forceCenter, forceCollide, forceLink, forceManyBody } from "d3-force";
```
