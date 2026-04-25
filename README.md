# Experts

Expert packs for AI coding agents.

Prompt your agent like this:

```text
Install Experts from https://github.com/Integral-Dragon/Experts
```

That installs the shared Experts helper. After that, use whichever form your agent supports.

## Use It

Portable:

```text
Use the Experts helper to list available experts.
Use the Experts helper to install the Codex expert.
Use the Experts helper to create a new expert for Shopify.
Use the Experts helper to update from the repo.
```

Codex-style skill shortcut:

```text
$experts list available experts
$experts install the Firecracker expert
```

Claude-style agent prompt:

```text
/Experts list available experts.
/Experts install the Linux systems expert.
```

Slash-command or plugin-style harnesses may expose their own equivalent, such as `/experts ... /experts:list /experts:install Firecracker expert` etc. depending on your chosen agent/harness.

## What It Does

Experts installs agent-usable specialist packs:

- a focused skill,
- source-of-truth notes,
- optional hydrated official docs,
- harness adapters where supported.

It also installs one shared Experts helper. The helper remembers this repo, syncs the latest version before list/install/create operations, and discovers available experts from the repo. It is not copied per expert.

## Expert Index

- `claude-code-principal-engineer` - Claude Code expert for CLI, IDE, Desktop, Web/cloud, permissions, settings, CLAUDE.md, skills, subagents, hooks, MCP, plugins, Agent SDK, CI/CD, sandboxing, and source-grounded behavior.
- `codex-principal-engineer` - OpenAI Codex expert for CLI, sandboxing, approvals, config, AGENTS.md, rules, skills, plugins, MCP, subagents, app, IDE, cloud, SDK, and non-interactive workflows.
- `firecracker-principal-engineer` - Firecracker expert for microVM architecture, APIs, security model, jailer behavior, networking, storage, snapshots, and source-grounded operations.
- `linux-systems-principal-engineer` - Linux systems expert for kernel, systemd, networking, nftables, QEMU, OCI runtime behavior, and production systems debugging.
- `oxv2-principal-engineer` - oxv2 expert for event-sourced multi-agent orchestration, seguro VM runners, complex/cx event ingestion, workflows, runtimes, storage, APIs, git integration, and source-derived architecture.
- `pi-principal-engineer` - Pi coding agent expert for CLI/TUI workflows, providers, settings, sessions, context files, skills, extensions, packages, SDK, RPC, JSON mode, terminal setup, and source-grounded behavior.

## For Agents

Read [AGENTS.md](AGENTS.md), then do the requested install directly.

For harnesses without a native adapter, use the generic contract at [toolkits/experts/harness/adapter.md](toolkits/experts/harness/adapter.md).
