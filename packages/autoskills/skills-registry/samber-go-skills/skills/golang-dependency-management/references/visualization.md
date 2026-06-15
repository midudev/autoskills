# Visualizing the Dependency Graph

## go mod graph (Built-in)

```bash
go mod graph
```

Output: each line contains two space-separated fields (module and its requirement) in `path@version` format:

```
example.com/main github.com/google/uuid@v1.6.0
example.com/main golang.org/x/text@v0.3.7
github.com/google/uuid@v1.6.0 golang.org/x/sys@v0.0.0-20210615035016
```

## go mod why

```bash
go mod why -m github.com/some/module
```

Shows the shortest import path from your code to the module — useful for understanding why an unexpected dependency exists.

## Generate a Graph Image with modgraphviz

Pin `modgraphviz` as a module tool, then pipe `go mod graph` into it.

```bash
go get -tool golang.org/x/exp/cmd/modgraphviz@latest
go mod graph | go tool modgraphviz | dot -Tpng -o deps.png
```

Green nodes represent versions selected by MVS (in the final build list). Grey nodes are versions that exist in the requirement graph but are not used.

## Interactive Visualization with go-mod-graph

`go-mod-graph` (samber/go-mod-graph) is a web-based interactive dependency explorer with zoomable graph, module weight indicators, searchable module list, and MVS algorithm visualization.

## Complementary Analysis

Pin `digraph` as a module tool for graph queries.

```bash
go get -tool golang.org/x/tools/cmd/digraph@latest
# General graph queries on go mod graph output
go mod graph | go tool digraph reverse example.com/some/module
```
