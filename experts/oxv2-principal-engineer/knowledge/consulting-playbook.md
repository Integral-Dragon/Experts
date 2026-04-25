# oxv2 Principal Engineer Consulting Playbook

Use this when answering oxv2 design reviews, debugging tasks, implementation work, operations, workflow design, or cross-repo questions involving seguro and complex.

## Default Mental Model

oxv2 is an event-sourced local orchestration system. `cx` provides git-native work facts, `ox-cx-watcher` ingests those facts, `ox-server` persists and broadcasts canonical events, `ox-herder` decides what to do next, `ox-runner` executes resolved step specs, and seguro isolates each runner in a QEMU VM. The repo under orchestration stays on `main`; agents work on branches cloned from ox-server's git endpoint.

## Review Checklist

- Which component owns the behavior: ox-server, ox-herder, ox-runner, ox-ctl, ox-cx-watcher, ox-rt, seguro, or complex?
- Is the claim documented, source-derived, local-version evidence, or a recommendation?
- Which state is authoritative: event log, in-memory projection, mutable runner heartbeat table, cx `.complex/` files, git refs, seguro session metadata, or local process pidfile?
- Which boundary matters: watcher/source boundary, server/herder boundary, server/runner SSE boundary, runtime socket boundary, git smart HTTP boundary, seguro VM boundary, or cx CLI boundary?
- Is the failure in config loading, trigger matching, execution creation, dispatch, runtime resolution, workspace clone, runtime process, `ox-rt done`, push/merge, cx state mutation, or seguro boot/networking?
- Are secrets present only where intended: persisted event log stores names only where designed, runner receives values only in dispatch, and host credentials are seeded by `ox-ctl up`?
- Are branch and worktree invariants preserved: host repo clean on `main`, agents push branch refs, merge updates both ref and working tree, and humans avoid direct `main` commits while ox is running?
- Does the answer need seguro-specific constraints: Linux/KVM, QEMU, virtiofsd, dev-bridge risk, session overlay location, network mode, proxy logging, or SSH readiness?
- Does the answer need cx-specific constraints: flat node IDs, parent field hierarchy, state transitions, shadow filtering, effective tags, git-log event stream, or committed `.complex/` changes?

## Answer Pattern

1. Recommendation or direct answer.
2. Source basis: docs paths, source files, tests, and local command output when relevant.
3. Active component boundary and state owner.
4. Failure modes or security/operational risks.
5. Exact command, config, API request, event shape, or code path.
6. Validation step with expected observation.

## Debugging Paths

- Startup failure: read `.ox/run/logs/server.log`, `herder.log`, watcher logs, runner logs, then inspect `ox-ctl/src/up.rs` and `ox-server/src/main.rs`.
- Workflow does not start: check `cx surface`, committed `.complex/` changes, `ox-cx-watcher` cursor, `/api/watchers`, `defaults/workflows/triggers.toml`, and `ox-herder` trigger logs.
- Step does not run: check runner pool state, `step.dispatched` events, `ox-runner/src/runner.rs`, and whether seguro runners can reach `http://10.0.2.2:<port>`.
- Agent finished but workflow stalls: check whether `ox-rt done` ran, `step.done` and `step.confirmed` events exist, branch was pushed, and no `exited_silent` signal was emitted.
- Merge failure: check host repo dirty status, branch ref, `docs/git-integration.md`, and `ox-server/src/merge.rs`.
- cx mismatch: compare complex README/design against `src/model.rs`, `src/store.rs`, and oxv2 `ox-cx-watcher/src/mapping.rs`; source wins for current behavior.

## Engineering Stance

- Prefer changing one boundary at a time. A bug that appears in a workflow can belong to trigger config, herder traversal, runner execution, runtime prompt, cx state, or seguro networking.
- Do not make ox-server source-specific. Add source-specific lifecycle knowledge to watchers, then ingest generic source events.
- Do not bypass seguro isolation for real work. Local execution is useful for runner debugging, but it invalidates the safety and git-branch invariants that oxv2 relies on.
- Keep docs, defaults, and source aligned. For oxv2 especially, the defaults are part of the product contract because installed binaries extract them into `~/.ox/defaults/`.
- Treat source-derived notes as an index, not gospel. Re-read the referenced source when making precise claims.
