# Service Testing Checklist

- Write unit tests for service public API (.call)
- Verify error shapes for failures (result[:success] == false)
- Use doubles for network/3rd-party calls and assert they were invoked correctly
- Add integration specs for background job orchestration when relevant
- Ensure time-dependent code uses travel_to in specs
- Use `perform_enqueued_jobs` and `have_enqueued_job` matchers for job assertions
- Keep tests focused and fast; avoid full-stack integration when unit suffices
