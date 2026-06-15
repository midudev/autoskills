# Prometheus Go Runtime Metrics Reference

Complete listing of Go runtime metrics **actually exposed as Prometheus metrics** by `prometheus/client_golang` library.

---

## Important Clarification

**`runtime/metrics` are NOT Prometheus metrics.** They're Go runtime data structures.

The Prometheus Go client library (`prometheus/client_golang`) **selectively converts some** `runtime/metrics` into Prometheus format. By default, it exposes only the traditional `go_memstats_*` and `go_gc_*` metrics to keep cardinality low.

**This document lists only Prometheus metrics** (the ones you actually scrape from `/metrics` endpoint).

---

## Quick Reference

### Metrics with Labels

| Metric                   | Label      | Values                |
| ------------------------ | ---------- | --------------------- |
| `go_gc_duration_seconds` | `quantile` | 0, 0.25, 0.5, 0.75, 1 |
| `go_info`                | `version`  | e.g., "go1.21.3"      |

### All Other Metrics

All other metrics have **no labels**.

---

## Default Go Metrics (Always Exposed)

These are exposed by default by `prometheus/client_golang`.

### Memory Allocation

| Metric                          | Type    | Description                     |
| ------------------------------- | ------- | ------------------------------- |
| `go_memstats_alloc_bytes`       | gauge   | Current bytes allocated on heap |
| `go_memstats_alloc_bytes_total` | counter | Cumulative bytes allocated      |
| `go_memstats_sys_bytes`         | gauge   | Total bytes requested from OS   |

### Heap State

| Metric                            | Type  | Description                 |
| --------------------------------- | ----- | --------------------------- |
| `go_memstats_heap_alloc_bytes`    | gauge | Allocated heap bytes        |
| `go_memstats_heap_idle_bytes`     | gauge | Idle heap bytes             |
| `go_memstats_heap_inuse_bytes`    | gauge | Heap bytes in use           |
| `go_memstats_heap_objects`        | gauge | Count of heap objects       |
| `go_memstats_heap_released_bytes` | gauge | Heap bytes released to OS   |
| `go_memstats_heap_sys_bytes`      | gauge | Heap bytes reserved from OS |

### Stack and Metadata

| Metric | Type | Description |
| --- | --- | --- |
| `go_memstats_stack_inuse_bytes` | gauge | Stack in-use bytes |
| `go_memstats_stack_sys_bytes` | gauge | Stack reserved bytes |
| `go_memstats_mspan_inuse_bytes` | gauge | Mspan in-use bytes |
| `go_memstats_mspan_sys_bytes` | gauge | Mspan reserved bytes |
| `go_memstats_mcache_inuse_bytes` | gauge | Mcache in-use bytes |
| `go_memstats_mcache_sys_bytes` | gauge | Mcache reserved bytes |
| `go_memstats_other_sys_bytes` | gauge | Other runtime bytes |
| `go_memstats_gc_sys_bytes` | gauge | GC internal bytes |
| `go_memstats_buck_hash_sys_bytes` | gauge | Profiling bucket hash table bytes |

### Allocation and Free Counters

| Metric                      | Type    | Description        |
| --------------------------- | ------- | ------------------ |
| `go_memstats_mallocs_total` | counter | Total malloc calls |
| `go_memstats_frees_total`   | counter | Total free calls   |

### GC Configuration and Timing

| Metric | Type | Description |
| --- | --- | --- |
| `go_gc_gogc_percent` | gauge | GOGC target percentage |
| `go_gc_gomemlimit_bytes` | gauge | GOMEMLIMIT soft memory limit |
| `go_memstats_last_gc_time_seconds` | gauge | Last GC end time (Unix timestamp) |
| `go_memstats_next_gc_bytes` | gauge | Heap size target for next GC |

### GC Pause Duration (with labels)

| Metric | Type | Labels | Description |
| --- | --- | --- | --- |
| `go_gc_duration_seconds` | summary | `quantile` (0, 0.25, 0.5, 0.75, 1) | GC pause durations with quantiles |
| `go_gc_duration_seconds_count` | counter | — | GC pause count |
| `go_gc_duration_seconds_sum` | counter | — | GC pause total time |

### Runtime State

| Metric                        | Type  | Description              |
| ----------------------------- | ----- | ------------------------ |
| `go_goroutines`               | gauge | Current goroutine count  |
| `go_threads`                  | gauge | Current OS thread count  |
| `go_sched_gomaxprocs_threads` | gauge | Current GOMAXPROCS value |

### Version Information (with labels)

| Metric    | Type  | Labels    | Description       |
| --------- | ----- | --------- | ----------------- |
| `go_info` | gauge | `version` | Go version string |

---

## Optional Go Metrics (Opt-in, Go 1.17+)

Enable via:

```go
prometheus.NewRegistry().MustRegister(
    collectors.NewGoCollector(
        collectors.WithGoCollectorRuntimeMetrics(
            collectors.MetricsAll,
        ),
    ),
)
```

### GC Cycles

| Metric | Type | Description |
| --- | --- | --- |
| `go_gc_cycles_automatic_gc_cycles_total` | counter | Automatic GC cycles (heap growth) |
| `go_gc_cycles_forced_gc_cycles_total` | counter | Forced GC cycles (runtime.GC()) |

### Additional Heap Metrics

| Metric | Type | Description |
| --- | --- | --- |
| `go_gc_heap_allocs_bytes_total` | counter | Cumulative heap allocations (bytes) |
| `go_gc_heap_allocs_objects_total` | counter | Cumulative heap allocations (count) |
| `go_gc_heap_frees_bytes_total` | counter | Cumulative heap frees (bytes) |
| `go_gc_heap_frees_objects_total` | counter | Cumulative heap frees (count) |
| `go_gc_heap_goal_bytes` | gauge | Heap size target for next GC |
| `go_gc_heap_live_bytes` | gauge | Live heap bytes |
| `go_gc_heap_objects_objects` | gauge | Total heap objects count |

### GC Pauses Distribution

| Metric                 | Type         | Description        |
| ---------------------- | ------------ | ------------------ |
| `go_gc_pauses_seconds` | distribution | GC pause durations |

### CPU Classes

| Metric | Type | Description |
| --- | --- | --- |
| `go_cpu_classes_gc_mark_assist_cpu_seconds_total` | counter | GC mark assist CPU time |
| `go_cpu_classes_gc_mark_dedicated_cpu_seconds_total` | counter | GC dedicated workers CPU time |
| `go_cpu_classes_gc_mark_idle_cpu_seconds_total` | counter | GC idle workers CPU time |
| `go_cpu_classes_gc_pause_cpu_seconds_total` | counter | GC pause CPU time |
| `go_cpu_classes_gc_total_cpu_seconds_total` | counter | Total GC CPU time |
| `go_cpu_classes_idle_cpu_seconds_total` | counter | Idle CPU time |
| `go_cpu_classes_scavenge_assist_cpu_seconds_total` | counter | Scavenger assist CPU time |
| `go_cpu_classes_scavenge_background_cpu_seconds_total` | counter | Background scavenger CPU time |
| `go_cpu_classes_scavenge_total_cpu_seconds_total` | counter | Total scavenger CPU time |
| `go_cpu_classes_total_cpu_seconds_total` | counter | Total CPU time (all classes) |
| `go_cpu_classes_user_cpu_seconds_total` | counter | User-mode CPU time |

### Memory Classes

| Metric | Type | Description |
| --- | --- | --- |
| `go_memory_classes_heap_free_bytes` | gauge | Free heap memory |
| `go_memory_classes_heap_objects_bytes` | gauge | Allocated heap objects |
| `go_memory_classes_heap_released_bytes` | gauge | Heap released memory |
| `go_memory_classes_heap_stacks_bytes` | gauge | Stack memory |
| `go_memory_classes_heap_unused_bytes` | gauge | Unused heap |
| `go_memory_classes_metadata_mcache_free_bytes` | gauge | Free mcache memory |
| `go_memory_classes_metadata_mcache_inuse_bytes` | gauge | In-use mcache memory |
| `go_memory_classes_metadata_mspan_free_bytes` | gauge | Free mspan memory |
| `go_memory_classes_metadata_mspan_inuse_bytes` | gauge | In-use mspan memory |
| `go_memory_classes_other_bytes` | gauge | Other memory |
| `go_memory_classes_total_bytes` | gauge | Total memory |

### Scheduler Metrics

| Metric | Type | Description |
| --- | --- | --- |
| `go_sched_goroutines_running_goroutines` | gauge | Running goroutines |
| `go_sched_goroutines_runnable_goroutines` | gauge | Runnable goroutines waiting |
| `go_sched_goroutines_goroutines` | gauge | Current total goroutines |
| `go_sched_goroutines_created_goroutines_total` | counter | Total goroutines ever created |
| `go_sched_goroutines_waiting_goroutines` | gauge | Goroutines waiting (not runnable) |
| `go_sched_latencies_seconds` | distribution | Goroutine scheduling latency |
| `go_sched_pauses_stopping_gc_seconds` | distribution | STW pause time (GC stop) |
| `go_sched_pauses_stopping_other_seconds` | distribution | STW pause time (other stop) |
| `go_sched_pauses_total_gc_seconds` | distribution | Total GC pause duration |
| `go_sched_pauses_total_other_seconds` | distribution | Total other pause duration |
| `go_sched_threads_total_threads` | counter | Total OS threads ever created |
| `go_sync_mutex_wait_total_seconds_total` | counter | Total time goroutines waited on mutex |

### CGO Metrics

| Metric                       | Type    | Description              |
| ---------------------------- | ------- | ------------------------ |
| `go_cgo_go_to_c_calls_total` | counter | Total calls from Go to C |

---

## Process Metrics

Exposed by Prometheus `process` collector (not Go-specific):

### CPU and Memory

| Metric | Type | Description |
| --- | --- | --- |
| `process_cpu_seconds_total` | counter | Total CPU time (user + system) |
| `process_resident_memory_bytes` | gauge | RSS (physical memory used) |
| `process_virtual_memory_bytes` | gauge | Virtual memory allocated |
| `process_virtual_memory_max_bytes` | gauge | Maximum virtual memory allowed |

### File Descriptors

| Metric             | Type  | Description                      |
| ------------------ | ----- | -------------------------------- |
| `process_open_fds` | gauge | Open file descriptors            |
| `process_max_fds`  | gauge | Maximum file descriptors allowed |

### Process Information

| Metric                       | Type  | Description                         |
| ---------------------------- | ----- | ----------------------------------- |
| `process_start_time_seconds` | gauge | Process start time (Unix timestamp) |

### Page Faults

| Metric                            | Type    | Description       |
| --------------------------------- | ------- | ----------------- |
| `process_page_faults_total`       | counter | Total page faults |
| `process_page_faults_minor_total` | counter | Minor page faults |
| `process_page_faults_major_total` | counter | Major page faults |

---

## Common PromQL Queries

### Memory Leak Detection

```promql
# Current heap allocation (should be stable under constant load)
go_memstats_alloc_bytes

# Live heap bytes (optional metric)
go_gc_heap_live_bytes

# Heap growth rate
rate(go_memstats_alloc_bytes_total[5m])
```

### GC Pressure

```promql
# Worst-case GC pause (quantile 1 = max)
go_gc_duration_seconds{quantile="1"}

# Average GC pause
rate(go_gc_duration_seconds_sum[5m]) / rate(go_gc_duration_seconds_count[5m])

# GC frequency (cycles per second)
rate(go_gc_duration_seconds_count[5m])
```

### Goroutine Leaks

```promql
# Current goroutine count
go_goroutines

# Goroutine growth (leak indicator)
delta(go_goroutines[1h])
```

### CPU Usage

```promql
# Total CPU time consumed
rate(process_cpu_seconds_total[5m])

# CPU utilization ratio (0-1)
rate(process_cpu_seconds_total[5m]) / <GOMAXPROCS>
```

### File Descriptor Leaks

```promql
# FD growth
delta(process_open_fds[1h])

# FD saturation ratio
process_open_fds / process_max_fds
```

→ See `samber/cc-skills@promql-cli` skill for executing these queries directly against your Prometheus instance from the CLI.

## References

- [prometheus/client_golang collectors](https://github.com/prometheus/client_golang/tree/main/prometheus/collectors)
- [Go runtime/metrics package](https://pkg.go.dev/runtime/metrics)
