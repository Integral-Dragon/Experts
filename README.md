# Experts

Reusable expert packages for AI coding-agent harnesses.

This project is meant to be used primarily by agents, not as a human-facing package catalog. A user should be able to point Codex, Claude, Pi, OpenCode, Hermes, or another coding-agent harness at this repo once, install an expert or the shared Experts helper, and then manage experts through natural-language agent prompts after that.

Each expert package contains:

- a progressive-disclosure skill,
- official-source manifests and sync scripts for local documentation caches,
- optional harness-specific agent adapters.

The repo also includes one shared Experts helper. Installing an expert installs or refreshes that shared helper by default; it does not create a separate helper per expert. The helper remembers this repo URL, syncs a working checkout from it, and lets future agent sessions list, install, update, and create experts without retyping the URL.

Codex and Claude adapters are included today because they have known local agent formats. Other harnesses can integrate by loading the harness-neutral files installed under `$HOME/.agents/`.

## First-Time Agent Prompt

Point an agent at this repo and say:

```text
Install the codex-principal-engineer expert from https://github.com/Integral-Dragon/Experts
```

That should be enough. The agent should read `AGENTS.md`, clone or open the repo, and run the installer.

To install only the shared helper first:

```text
Install the Experts helper from https://github.com/Integral-Dragon/Experts
```

## Expert Index

Use an expert name directly in an install prompt. Agents should treat this index as documentation only; available experts are discovered dynamically with `./install.sh --list`.

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

This also installs or refreshes the single shared Experts helper unless you pass `--no-experts-toolkit`.

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

Install only the shared helper:

```bash
./install.sh --experts-toolkit-only
```

Restart or reload your agent harness after installation if the new expert or shared helper does not appear.

## Reuse With Agent Prompts

After the shared helper has been installed, ask future agent sessions to use the Experts helper instead of pasting this repository URL again:

```text
Experts: list available experts
Experts: install the firecracker expert
Experts: create a new expert for Shopify
Experts: update from the repo
```

Harnesses with explicit routing tokens may also expose aliases such as `$experts`, `@experts`, or another local convention. Those aliases are adapter-specific. The portable interface is ordinary natural language that names the Experts helper.

The helper syncs from the remembered repo URL, then discovers available experts dynamically by running `./install.sh --list`. It does not hardcode the current Expert Index, so newly added experts are picked up from the repo structure.

## Harness Model

The portable interface is the installed `.agents` tree:

| Artifact | Purpose |
| --- | --- |
| `$HOME/.agents/skills/<name>/SKILL.md` | Harness-neutral instructions for when and how to use the expert. |
| `$HOME/.agents/knowledge/<domain>/` | Source manifests, playbooks, sync scripts, and optional hydrated official docs. |
| `$HOME/.agents/toolkits/experts/manifest.json` | Machine-readable Experts helper manifest for any harness. |
| `$HOME/.agents/toolkits/experts/adapter.md` | Generic adapter contract for harnesses without a native package in this repo. |

Harness-specific adapters are optional wrappers around those portable files. This repo currently renders Codex and Claude adapters; other coding-agent harnesses can read the manifest and adapter contract to provide the same Experts helper behavior using their own invocation conventions.

## What Gets Installed

The installer writes to the current user's standard agent locations:

| Artifact | Destination |
| --- | --- |
| Skills | `$HOME/.agents/skills/<expert>/` |
| Knowledge manifests and sync scripts | `$HOME/.agents/knowledge/<domain>/` |
| Codex custom agents | `$HOME/.codex/agents/<expert>.toml` |
| Claude agents | `$HOME/.claude/agents/<expert>.md` |
| Shared Experts helper skill | `$HOME/.agents/skills/experts/` |
| Experts helper state | `$HOME/.agents/knowledge/experts/install-state.env` |
| Experts harness manifest | `$HOME/.agents/toolkits/experts/manifest.json` |
| Experts generic adapter contract | `$HOME/.agents/toolkits/experts/adapter.md` |
| Experts Codex agent | `$HOME/.codex/agents/experts.toml` |
| Experts Claude agent | `$HOME/.claude/agents/experts.md` |

Codex agent files are rendered from templates, so installed paths use the current user's `$HOME`. Claude agent files are copied as Markdown. Other harnesses should use the harness manifest and adapter contract.

## How The Experts Stay Lightweight

The repo does not vendor large upstream documentation dumps. Each expert includes a small skill plus an `official-sources.md` index. When used, the expert loads only the specific official docs or source files needed for the task.

With `--hydrate`, the installer runs the expert's `sync-*.sh` script to fetch the latest relevant official docs and source references, then builds the local reference library at:

```text
$HOME/.agents/knowledge/<domain>/upstream/
```

Hydrated docs are generated locally and are not committed to this repo.

## Add A New Expert

Ask an agent:

```text
Create a new expert for Shopify from https://github.com/Integral-Dragon/Experts
```

The agent should follow [templates/CREATE_EXPERT.md](templates/CREATE_EXPERT.md): clarify scope and delivery when needed, identify official sources, scaffold the package, customize hydration, validate the result, and either install it locally or help prepare a PR if you ask.

New experts go under:

```text
experts/<expert-name>/
```

The installer discovers experts automatically when they follow the repo structure in [templates/EXPERT_BLUEPRINT.md](templates/EXPERT_BLUEPRINT.md).
