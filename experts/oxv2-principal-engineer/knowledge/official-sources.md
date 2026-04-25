# oxv2 Principal Engineer Official Sources

This expert is pinned to user-approved team repositories. Created against these repository heads on 2026-04-25:

- `Integral-Dragon/oxv2` main commit `09464b52b05feb6787367476afe1623dde96e821`
- `dragon-panic/seguro` main commit `2c28edf4d0022a7c0850a2226f1e020e8bfdf40d`
- `dragon-panic/complex` main commit `e8de6d5026b6abf3188ef8192d27be70cc3c88b5`

Use live repo `main` when the user wants the current state. Use the pinned/hydrated cache when repeatability matters.

## Roots

- oxv2 source: `https://github.com/Integral-Dragon/oxv2`
- seguro source: `https://github.com/dragon-panic/seguro`
- complex/cx source: `https://github.com/dragon-panic/complex`
- oxv2 raw live root: `https://raw.githubusercontent.com/Integral-Dragon/oxv2/main/`
- seguro raw live root: `https://raw.githubusercontent.com/dragon-panic/seguro/main/`
- complex raw live root: `https://raw.githubusercontent.com/dragon-panic/complex/main/`
- Local cache root: `$HOME/.agents/knowledge/oxv2/upstream/oxv2/`
- Supplemental source-derived map: `$HOME/.agents/knowledge/oxv2/source-derived-map.md`

## Source Policy

Treat the three repositories above as authoritative because the user explicitly supplied them. These projects may have incomplete docs; source-derived guidance is expected and acceptable when it is based on these repos only.

Allowed source classes:

- Repository docs, PRDs, READMEs, and contribution notes.
- Rust source, tests, Cargo manifests, default TOML workflow/runtime/persona files, site files, scripts, and examples from the three repos.
- Local installed command output only as installed-version evidence.
- Reasoned implementation inference from those files, clearly labeled as source-derived inference.

Disallowed source classes unless the user explicitly asks:

- General web search.
- Third-party tutorials, unrelated projects with similar names, Stack Overflow, blog posts, mirrors, or community commentary.
- Assumptions about private intent that cannot be tied to these repos.

## Primary Reading Order

- Product model and setup: oxv2 `README.md`, `docs/prd/README.md`, `CONTRIBUTING.md`.
- Architecture overview: oxv2 `docs/design.md`, `docs/api.md`, `docs/protocols.md`, `docs/storage.md`, `docs/workflows-design.md`, `docs/event-sources-design.md`, `docs/git-integration.md`, `docs/vm-layout.md`.
- Product requirements and roadmap intent: oxv2 `docs/prd/*.md`.
- Crate contracts: oxv2 root `Cargo.toml`, per-crate `Cargo.toml`, and source under `ox-core/`, `ox-server/`, `ox-herder/`, `ox-runner/`, `ox-ctl/`, `ox-cx-watcher/`, and `ox-rt/`.
- Defaults and config surface: oxv2 `defaults/config.toml`, `defaults/workflows/*.toml`, `defaults/runtimes/*.toml`, and `defaults/personas/**/*.md`.
- seguro runner isolation and VM behavior: seguro `README.md`, `docs/prd/*.md`, `src/api.rs`, `src/commands/run.rs`, `src/config.rs`, `src/vm/`, `src/session/`, `src/proxy/`, `src/cli.rs`, and tests.
- complex/cx work graph behavior: complex `README.md`, `docs/design.md`, `src/model.rs`, `src/store.rs`, `src/db.rs`, `src/log.rs`, `src/main.rs`, `src/agent.rs`, and tests.
- Source-derived internals: use `$HOME/.agents/knowledge/oxv2/source-derived-map.md` first for a compact orientation, then inspect the hydrated source paths it points to.

## Topic Map

| Topic | Official/team paths |
| --- | --- |
| Product overview | `repos/Integral-Dragon/oxv2/README.md`, `docs/prd/README.md`, `site/` |
| Install and local ensemble | oxv2 `README.md`, `ox-ctl/src/up.rs`, `defaults/config.toml`, seguro `README.md` |
| Crate boundaries | oxv2 `docs/design.md`, root `Cargo.toml`, per-crate `Cargo.toml`, `source-derived-map.md` |
| Event model | oxv2 `docs/design.md`, `docs/prd/events.md`, `ox-core/src/events.rs` |
| Storage and projections | oxv2 `docs/storage.md`, `ox-server/src/db.rs`, `ox-server/src/projections.rs`, `ox-server/src/events.rs` |
| HTTP API and SSE | oxv2 `docs/api.md`, `ox-server/src/api.rs`, `ox-server/src/sse.rs`, `ox-core/src/client.rs` |
| Workflows and triggers | oxv2 `docs/workflows-design.md`, `docs/prd/workflows.md`, `defaults/workflows/*.toml`, `ox-core/src/workflow.rs`, `ox-herder/src/*` |
| Runtime resolution | oxv2 `docs/protocols.md`, `defaults/runtimes/*.toml`, `ox-core/src/runtime.rs`, `ox-runner/src/runner.rs`, `ox-rt/src/main.rs` |
| Runner lifecycle | oxv2 `ox-runner/src/runner.rs`, `docs/protocols.md`, `docs/vm-layout.md`, seguro source |
| PTY and interactive sessions | oxv2 `ox-runner/src/pty.rs`, `ox-server/src/pty_relay.rs`, `docs/api.md`, `defaults/workflows/interactive.toml` |
| Artifacts and logs | oxv2 `docs/prd/artifacts.md`, `docs/storage.md`, `ox-server/src/artifacts.rs`, `ox-runner/src/runner.rs` |
| Secrets | oxv2 `docs/prd/secrets.md`, `ox-server/src/api.rs`, `ox-server/src/projections.rs`, `ox-ctl/src/up.rs`, runtime defaults |
| Git integration | oxv2 `docs/git-integration.md`, `ox-server/src/git.rs`, `ox-server/src/merge.rs`, `ox-runner/src/runner.rs` |
| cx watcher | oxv2 `docs/event-sources-design.md`, `docs/prd/cx.md`, `ox-cx-watcher/src/main.rs`, `ox-cx-watcher/src/cx.rs`, `ox-cx-watcher/src/mapping.rs` |
| complex/cx semantics | complex `README.md`, `docs/design.md`, `src/model.rs`, `src/store.rs`, `src/db.rs`, `src/main.rs` |
| seguro VM isolation | seguro `README.md`, `docs/prd/README.md`, `src/api.rs`, `src/commands/run.rs`, `src/vm/`, `src/session/`, `src/proxy/` |
| Operational troubleshooting | oxv2 `README.md`, `ox-ctl/src/up.rs`, `ox-ctl/src/output.rs`, seguro `README.md`, complex `README.md` |
| Tests and validation | oxv2 `tests` inside each crate/source file modules, complex `tests/integration.rs`, seguro `tests/*.rs` |

## Hydrated Manifest

The sync script hydrates the following material under `$HOME/.agents/knowledge/oxv2/upstream/oxv2/`:

- `repos/Integral-Dragon/oxv2/`: README, CONTRIBUTING, Cargo files, docs, PRDs, defaults, site, all `ox-*` crate source and tests.
- `repos/dragon-panic/seguro/`: README, CLAUDE, Cargo files, docs, scripts, demos, source, and tests.
- `repos/dragon-panic/complex/`: README, AGENT, CLAUDE, CONTRIBUTING, Cargo files, docs, source, and tests.
- `SOURCE_REF`: repo refs, SHAs, archive URLs, and sync timestamp.
- `official-roots.txt`: the three authoritative repo roots.

Hydrated source should not be bulk-loaded into context. Start with this manifest and `source-derived-map.md`, then read only the topic-specific docs/source paths needed.

## Version-Sensitive Questions

For "latest", "current", install, CLI, config, workflow, protocol, repo layout, or dependency behavior questions:

1. Check live repo `main` for the relevant repo.
2. Compare against local hydrated `SOURCE_REF`.
3. If local binaries are installed, use targeted `--help` or version output only as local installed-version evidence.
4. State whether the answer is based on hydrated docs, live source, source-derived inference, or local CLI output.

## Source-Derived Inference Rule

When docs are incomplete, inspect source and answer from code. Be explicit:

1. name the source files inspected,
2. state what behavior is directly implemented there,
3. label design intent as inference unless the docs say it,
4. call out doc/source conflicts instead of smoothing them over.
