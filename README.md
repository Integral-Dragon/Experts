# Experts

Expert packs for AI coding agents.

Point your agent at this repo once:

```text
Install Experts from https://github.com/Integral-Dragon/Experts
```

After that, use the Experts helper from any supported agent session:

```text
Experts: list available experts
Experts: install the Codex expert
Experts: install the Firecracker expert
Experts: create a new expert for Shopify
Experts: update from the repo
```

`$experts`, `@experts`, slash commands, and similar shortcuts are optional harness-specific aliases. The portable interface is plain language that names `Experts`.

## What It Does

Experts installs agent-usable specialist packs:

- a focused skill,
- source-of-truth notes,
- optional hydrated official docs,
- harness adapters where supported.

It also installs one shared Experts helper. The helper remembers this repo, syncs the latest version before list/install/create operations, and discovers available experts dynamically. It is not copied per expert.

## For Agents

Read [AGENTS.md](AGENTS.md), then do the requested install directly.

For harnesses without a native adapter, use the generic contract at [toolkits/experts/harness/adapter.md](toolkits/experts/harness/adapter.md).
