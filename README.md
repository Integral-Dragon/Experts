# Experts

Reusable expert packages for Codex, Claude, and other coding-agent harnesses.

Each expert installs as:

- a progressive-disclosure skill,
- a Codex custom agent,
- a Claude agent,
- official-source manifests and sync scripts for local documentation caches.

## Quick Agent Prompt

Point an agent at this repo and say:

```text
Install the codex-principal-engineer expert from https://github.com/Integral-Dragon/Experts
```

That should be enough. The agent should read `AGENTS.md`, clone or open the repo, and run the installer.

## Expert Index

Click an expert to inspect its package. Use the expert name directly in the install prompt.

| Expert | What it helps with |
| --- | --- |
| [`codex-principal-engineer`](experts/codex-principal-engineer/) | OpenAI Codex CLI, sandboxing, approvals, config, skills, plugins, MCP, subagents, app, IDE, cloud, and SDK behavior from official OpenAI sources. |
| [`firecracker-principal-engineer`](experts/firecracker-principal-engineer/) | Firecracker microVM architecture, API, jailer, KVM integration, networking, storage, snapshots, MMDS, seccomp, performance, and host integration. |
| [`linux-systems-principal-engineer`](experts/linux-systems-principal-engineer/) | Linux, KVM, containers, namespaces, cgroups, capabilities, networking, nftables, iproute2, systemd, Debian, storage, observability, and host operations. |

## Install

Install one expert:

```bash
./install.sh --expert codex-principal-engineer --hydrate
```

Install all experts:

```bash
./install.sh --all --hydrate
```

Skip `--hydrate` when offline:

```bash
./install.sh --expert codex-principal-engineer
```

List available experts:

```bash
./install.sh --list
```

Restart your agent harness after installation if the new expert does not appear.

## What Gets Installed

The installer writes to the current user's standard agent locations:

| Artifact | Destination |
| --- | --- |
| Skills | `$HOME/.agents/skills/<expert>/` |
| Knowledge manifests and sync scripts | `$HOME/.agents/knowledge/<domain>/` |
| Codex custom agents | `$HOME/.codex/agents/<expert>.toml` |
| Claude agents | `$HOME/.claude/agents/<expert>.md` |

Codex agent files are rendered from templates, so installed paths use the current user's `$HOME`.

## How The Experts Stay Lightweight

The repo does not vendor large upstream documentation dumps. Each expert includes a small skill plus an `official-sources.md` index. When used, the expert loads only the specific official docs or source files needed for the task.

Use `--hydrate` to fetch official upstream docs into the local cache:

```text
$HOME/.agents/knowledge/<domain>/upstream/
```

Hydrated docs are generated locally and are not committed to this repo.

## Add A New Expert

Use [templates/EXPERT_BLUEPRINT.md](templates/EXPERT_BLUEPRINT.md). New experts go under:

```text
experts/<expert-name>/
```

The installer discovers experts automatically when they follow the repo structure.
