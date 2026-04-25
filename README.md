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
Use the Experts agent to list available experts.
Use the Experts agent to install the Linux systems expert.
```

Slash-command or plugin-style harnesses may expose their own equivalent, such as `/experts ...`. Use the native form your agent installs.

## What It Does

Experts installs agent-usable specialist packs:

- a focused skill,
- source-of-truth notes,
- optional hydrated official docs,
- harness adapters where supported.

It also installs one shared Experts helper. The helper remembers this repo, syncs the latest version before list/install/create operations, and discovers available experts from the repo. It is not copied per expert.

## For Agents

Read [AGENTS.md](AGENTS.md), then do the requested install directly.

For harnesses without a native adapter, use the generic contract at [toolkits/experts/harness/adapter.md](toolkits/experts/harness/adapter.md).
