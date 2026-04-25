# oxv2 Source-Derived Map

This is a compact orientation derived from the user-provided source repositories. It is not a substitute for reading the referenced files. Use it to choose the right docs/source path quickly, then inspect the cited files before making precise claims.

Created from:

- `Integral-Dragon/oxv2` at `09464b52b05feb6787367476afe1623dde96e821`
- `dragon-panic/seguro` at `2c28edf4d0022a7c0850a2226f1e020e8bfdf40d`
- `dragon-panic/complex` at `e8de6d5026b6abf3188ef8192d27be70cc3c88b5`

## System Shape

oxv2 is an event-sourced workflow engine for multi-agent work in a git repository. The operational loop is:

1. `cx` stores a task graph under `.complex/`.
2. `ox-cx-watcher` observes committed cx changes via git history and posts source events.
3. `ox-server` appends canonical events, maintains projections, serves HTTP/SSE/git/artifact endpoints, and stores secrets.
4. `ox-herder` subscribes to SSE and reacts by creating executions, dispatching steps, advancing workflows, retrying, escalating, and merging.
5. `ox-runner` registers with the server, receives `step.dispatched`, clones from the server's git endpoint, places resolved files, starts runtime proxies, spawns the runtime, collects signals/artifacts/metrics, and confirms or fails the step.
6. The runtime process calls `ox-rt` over the Unix socket pointed to by `OX_SOCKET` to report `done`, metrics, and artifacts.
7. `ox-ctl up` starts the local ensemble and launches runners through seguro VMs.

Primary source paths:

- oxv2 docs: `docs/design.md`, `docs/api.md`, `docs/protocols.md`, `docs/storage.md`, `docs/workflows-design.md`, `docs/event-sources-design.md`, `docs/git-integration.md`, `docs/vm-layout.md`
- oxv2 source: `ox-core/src/events.rs`, `ox-core/src/workflow.rs`, `ox-core/src/runtime.rs`, `ox-server/src/*`, `ox-herder/src/*`, `ox-runner/src/runner.rs`, `ox-ctl/src/up.rs`, `ox-cx-watcher/src/*`, `ox-rt/src/main.rs`

## Component Boundaries

### ox-core

Shared types, events, config loading, workflow definitions, runtime definitions, interpolation, personas, and HTTP client. It should stay mostly I/O-light except configuration file reads and client calls.

Important files:

- `ox-core/src/events.rs`: canonical event envelope and internal event kind constants.
- `ox-core/src/workflow.rs`: workflow vars, steps, workspace specs, transitions, triggers, and trigger var interpolation.
- `ox-core/src/runtime.rs`: runtime TOML schema and server-side resolution into `ResolvedStepSpec`.
- `ox-core/src/config.rs`: embedded defaults extraction and config search path.
- `ox-core/src/client.rs`: typed client used by herder, runner, ctl, watcher.

### ox-server

The passive hub. It owns the SQLite event log, in-memory projections, REST API, SSE stream, git smart HTTP, artifact storage, secrets API, watcher cursor storage, and merge implementation. It should not poll source systems or make scheduling decisions.

Important files:

- `ox-server/src/main.rs`: startup, defaults extraction, replay reconciliation, `server.ready`, SIGHUP config reload, heartbeat checker.
- `ox-server/src/db.rs`: schema and migrations.
- `ox-server/src/events.rs`: event append, ingest transaction, cursor CAS, idempotency, projection update, broadcast.
- `ox-server/src/projections.rs`: pool, executions, and secrets projections.
- `ox-server/src/api.rs`: API handlers for runners, executions, steps, watchers, secrets, workflows, state, status.
- `ox-server/src/sse.rs`: SSE stream and replay.
- `ox-server/src/git.rs`: git smart HTTP endpoint.
- `ox-server/src/merge.rs`: git2 merge-to-main logic.
- `ox-server/src/artifacts.rs`: artifact metadata/content.
- `ox-server/src/pty_relay.rs`: interactive PTY websocket bridge.

### ox-herder

The active control loop. It subscribes to ox-server SSE and calls API endpoints to trigger executions, dispatch steps to idle runners, advance confirmed steps, apply retry/visit rules, handle liveness, and perform merges. It never mutates state directly.

Important files:

- `ox-herder/src/herder.rs`
- `docs/workflows-design.md`
- `defaults/workflows/*.toml`
- `defaults/workflows/triggers.toml`

### ox-runner

The step executor. It registers after draining SSE replay, heartbeats every 10 seconds, receives dispatches targeted to its `RunnerId`, provisions a workspace, spawns a runtime process, listens on the runtime socket, ships logs, scans failure signals, reports step events, and cleans the workspace.

Important files:

- `ox-runner/src/runner.rs`: main lifecycle and execution path.
- `ox-runner/src/socket.rs`: runtime line protocol server.
- `ox-runner/src/proxy.rs`: runtime API proxies and metrics.
- `ox-runner/src/pty.rs`: PTY spawning and relay client.
- `ox-runner/src/scan.rs`: failure signal tail scanning.

Source-derived invariants:

- The runner drains historical SSE before registering so old events cannot target it before it is live.
- The runner clones from `ox-server`'s `/git/` endpoint for `git_clone` workspaces.
- Runtime file destinations resolve `{workspace}`, `{tmp_dir}`, and `{home}`; bare relative paths are placed under the runner temp directory.
- A zero exit without `ox-rt done` is treated as implicit done with empty output.
- No `ox-rt done` plus process exit emits `exited_silent`, which is treated as a hard failure.
- `fast_exit`, `no_commits`, and `dirty_workspace` are currently informational signals; `exited_silent` is the hard failure signal in the inspected runner path.

### ox-ctl

The operator CLI. `ox-ctl up` starts server, seeds credentials, starts herder, starts configured watcher binaries, stages `cx`, and launches seguro runner VMs.

Important files:

- `ox-ctl/src/main.rs`
- `ox-ctl/src/up.rs`
- `ox-ctl/src/output.rs`

Source-derived invariants:

- Project runtime state lives under `{repo}/.ox/run/`.
- `ox-ctl up` requires `seguro` on PATH.
- Runner VMs are launched with seguro `--net dev-bridge --unsafe-dev-bridge` so they can reach host `ox-server` at `10.0.2.2:<port>`.
- `cx` is copied into `.ox/run/scripts/cx` and mounted read-only into runner VMs at `/ox/scripts`.
- `claude_credentials` is seeded from `~/.claude/.credentials.json`; `codex_auth` is seeded from `~/.codex/auth.json`.

### ox-cx-watcher

The reference source watcher. It is stateless on disk and stores its cursor on ox-server. On cold start it snapshots current cx state; after that it reads `cx log --since <cursor>` and fetches touched nodes.

Important files:

- `ox-cx-watcher/src/main.rs`: polling loop, cursor handling, cold/incremental batches.
- `ox-cx-watcher/src/cx.rs`: shelling out to cx/git and parsing snapshots/logs.
- `ox-cx-watcher/src/mapping.rs`: editorial mapping from cx facts to source events.
- `docs/event-sources-design.md`
- `docs/prd/cx.md`

Source-derived mapping:

- Watcher source is `cx`.
- Emitted kinds are `node.ready`, `node.claimed`, `node.done`, and `comment.added`.
- `latent` nodes emit nothing.
- `ready` nodes that are `shadowed` emit nothing.
- `claimed` and `integrated` nodes still emit events even when shadowed.
- Idempotency keys combine node/comment facts with a short cursor SHA.

### ox-rt

Runtime helper for the runner socket. Runtimes should call this instead of speaking the socket protocol directly.

Important files:

- `ox-rt/src/main.rs`
- `docs/protocols.md`

## State Owners

- Event source of truth: SQLite `events` table in `ox-server`.
- Fast operational state: projections rebuilt from events.
- Mutable exception: runner heartbeat table, because high-frequency timestamps are not event-log facts.
- Watcher cursors and ingest dedup: `watcher_cursors` and `ingest_idempotency`.
- Agent work graph: `.complex/` files in the managed repo.
- Code and cx changes from agents: git branches pushed to ox-server's smart HTTP endpoint.
- Runner execution state: seguro VM process plus `/work/current` and temp socket/log files during a step.

## Config and Defaults

Defaults are embedded into binaries with `include_dir` from oxv2 `defaults/` and extracted to `~/.ox/defaults/` on first run or version/fingerprint change. They are marked read-only as a convention.

Search path, first match wins:

1. `{repo}/.ox/`
2. each directory in `$OX_HOME`, left to right
3. `~/.ox/defaults/`

Important files:

- `ox-core/src/config.rs`
- `defaults/config.toml`
- `defaults/workflows/*.toml`
- `defaults/runtimes/*.toml`
- `defaults/personas/**/*.md`

## Workflow Semantics

Workflows are ordered step lists with conditional transitions, not DAGs. Transitions match a step output by exact or prefix-with-colon match. No transition means advance to the next step in declaration order. `complete` and `escalate` are sentinel targets.

Important files:

- `docs/workflows-design.md`
- `ox-core/src/workflow.rs`
- `defaults/workflows/code-task.toml`

Default `code-task` shape:

- `propose`
- `review-plan`
- `plan-tiebreak`
- `implement`
- `review-code`
- `code-tiebreak`
- merge/integration steps as defined in the default TOML

Important prompt invariant from `docs/git-integration.md`: every workflow prompt that expects completion must put `git push origin <branch>` immediately before `ox-rt done` in the same code block, because Claude Code follows code blocks literally.

## Runtime Semantics

Runtime definitions declare command, optional args, file mappings, env, proxies, metrics, and failure signals. ox-server resolves a step's runtime spec into a self-contained `ResolvedStepSpec` before dispatch. The runner should not need local `.ox/` config to execute.

Important files:

- `ox-core/src/runtime.rs`
- `defaults/runtimes/claude.toml`
- `defaults/runtimes/codex.toml`
- `defaults/runtimes/shell.toml`
- `ox-runner/src/runner.rs`

Secrets are interpolated into resolved env/files for runner delivery, but persisted `step.dispatched` events store secret names, not values.

## Git Integration

ox-server manages a non-bare repo and serves `/git/`. Agents clone from that endpoint, work on branches, push branches back, and ox-server merges via git2.

Important files:

- `docs/git-integration.md`
- `ox-server/src/git.rs`
- `ox-server/src/merge.rs`
- `ox-runner/src/runner.rs`

Source-derived operational constraints:

- The host repo should stay on `main`.
- Agents must not write the host worktree directly; seguro isolation enforces this in real runs.
- Direct human commits to main while ox is running can confuse watcher cursor and merge state.
- `.ox/run/` and build artifacts should not make the working tree dirty for merge checks.

## seguro Boundary

seguro is the VM sandbox. It runs QEMU with virtiofs mounts, a per-session overlay, SSH access, and controlled network modes.

Important files:

- seguro `README.md`
- seguro `docs/prd/README.md`
- seguro `src/api.rs`
- seguro `src/commands/run.rs`
- seguro `src/config.rs`
- seguro `src/vm/mod.rs`
- seguro `src/session/mod.rs`
- seguro `src/proxy/filter.rs`

Source-derived constraints:

- `--net dev-bridge` requires `--unsafe-dev-bridge`.
- Default network mode from seguro docs is `full-outbound`; oxv2 intentionally uses dev-bridge for host service access.
- SSRF filtering blocks private, loopback, link-local, and SLIRP gateway ranges unless configured exceptions apply.
- Session runtime metadata lives under `$XDG_RUNTIME_DIR/seguro/<id>/`; qcow2 overlays live under a state/overlay directory to avoid filling tmpfs.
- The API supports programmatic sandbox sessions, output capture/streaming, restart policy, and health events.

## complex/cx Boundary

complex is a passive, git-native issue registry. It stores a graph in `.complex/`, materializes into in-memory SQLite for queries, and writes mutations back to files. It does not assign work, run agents, retry, enforce workflows, or track liveness.

Important files:

- complex `README.md`
- complex `docs/design.md`
- complex `src/model.rs`
- complex `src/store.rs`
- complex `src/db.rs`
- complex `src/log.rs`
- complex `src/main.rs`
- complex `src/agent.rs`

Source-derived constraints and doc/source notes:

- Current `src/id.rs` generates flat 4-character base62 IDs. `src/model.rs` tracks hierarchy with an explicit `parent` field. The complex README agrees with flat IDs and explicit parent fields.
- `CLAUDE.md` in the inspected complex repo still describes hierarchical dot IDs. Treat that as stale unless current source has changed.
- Node states are `latent`, `ready`, `claimed`, and `integrated`; `shadowed` is an orthogonal boolean.
- `ready_nodes` excludes shadowed nodes and nodes blocked by non-integrated blockers on self/ancestor paths.
- Tags are effective as own tags plus ancestor tags.
- Per-node JSON files plus markdown bodies/comments reduce merge conflicts across parallel branches.
- `cx log` uses git history as the event stream; oxv2 only sees changes that are committed.

## Common Failure Modes

- Workflow does not start: cx node not committed, missing `workflow:code-task` effective tag, node is shadowed, watcher cursor stuck, or trigger vars do not match source payload.
- Runner idle forever: no registered runners, seguro failed to boot, runner cannot reach `10.0.2.2:<port>`, or herder did not dispatch due to active dedup/escalation state.
- Step exits but workflow stalls: runtime skipped `ox-rt done`, branch was not pushed, log contains hard failure signal, or no transition matches expected output.
- Merge fails: host repo dirty, branch ref missing, conflict in git2 merge, main changed outside ox, or ignored files are not filtered correctly.
- cx state seems wrong: agent edited host repo instead of VM clone, `.complex/` changes not committed/pushed, branch not merged, or watcher is still on old cursor.
- seguro issues: missing KVM/virtiofsd/QEMU tools, base image not built, dev-bridge not acknowledged, overlay disk fills, guest SSH not ready, or network policy blocks required endpoints.

## Validation Commands

Use these as starting points; adapt to the user's environment:

```bash
cargo test
cargo build
ox-ctl up
ox-ctl status
ox-ctl events
ox-ctl workflows
ox-ctl runners list
ox-ctl exec list
ox-ctl exec show <execution-id>
ox-ctl exec logs <execution-id> <step> -f
curl -fsS http://localhost:4840/api/status
curl -N http://localhost:4840/api/events/stream?last_event_id=0
cx status
cx surface --json
cx log --json
seguro sessions ls
seguro proxy-log <session-id>
```
