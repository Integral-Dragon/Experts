# Pi Principal Engineer Official Sources

This expert is pinned to official Pi sources discovered from `https://pi.dev/`.
Created against `badlogic/pi-mono` main commit `05f79b08516809e0e06756013645c37419bf5570` on 2026-04-25.
The npm package observed during creation was `@mariozechner/pi-coding-agent@0.70.2`.

Use live official docs or `main` when the user wants the current state. Use the pinned commit when repeatability matters.

## Roots

- Pi landing page and package index: `https://pi.dev/`
- Pi packages page: `https://pi.dev/packages`
- Pi coding agent source: `https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent`
- Pi coding agent docs: `https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent/docs`
- Pi npm package: `https://www.npmjs.com/package/@mariozechner/pi-coding-agent`
- Pi package metadata: `https://registry.npmjs.org/@mariozechner%2Fpi-coding-agent`
- Pi rationale by the maintainer: `https://mariozechner.at/posts/2025-11-30-pi-coding-agent/`
- Pi no-MCP rationale by the maintainer: `https://mariozechner.at/posts/2025-11-02-what-if-you-dont-need-mcp/`
- Pi monorepo root: `https://github.com/badlogic/pi-mono`
- Raw live root: `https://raw.githubusercontent.com/badlogic/pi-mono/main/`
- Raw pinned root: `https://raw.githubusercontent.com/badlogic/pi-mono/05f79b08516809e0e06756013645c37419bf5570/`
- Local cache root: `$HOME/.agents/knowledge/pi/upstream/pi/`

## Source Policy

Treat these as first-class authoritative sources:

- `pi.dev` and links from it to the Pi repo, docs, npm package, packages page, examples, and maintainer rationale posts.
- `badlogic/pi-mono`, especially `packages/coding-agent`.
- Sibling monorepo packages used by the coding agent: `packages/agent`, `packages/ai`, and `packages/tui`.
- Official package metadata from npm for version, Node engine, package entry points, and published files.

Use external sources only when the user approves them or when the Pi docs explicitly reference them as standards or examples. Label those as external references, not Pi source of truth. Examples include the Agent Skills standard, Discord discussions, and third-party Pi packages.

## Primary Reading Order

- Product model and philosophy: `pi.dev`, `packages/coding-agent/README.md`, `packages/coding-agent/docs/index.md`, maintainer rationale posts.
- Installation and CLI behavior: npm metadata, `packages/coding-agent/package.json`, `packages/coding-agent/README.md`, `packages/coding-agent/src/cli.ts`, `packages/coding-agent/src/main.ts`, and docs under `docs/`.
- Providers and models: `docs/providers.md`, `docs/models.md`, `docs/custom-provider.md`, `packages/ai/README.md`, `packages/ai/src/`, `packages/coding-agent/src/core/`, and `packages/coding-agent/src/config.ts`.
- Interactive terminal behavior: `docs/tui.md`, `docs/keybindings.md`, `docs/terminal-setup.md`, `packages/tui/README.md`, `packages/tui/src/`, and `packages/coding-agent/src/modes/interactive/`.
- Sessions and history: `docs/session.md`, `docs/tree.md`, `docs/compaction.md`, `packages/agent/README.md`, `packages/agent/src/`, and session-related coding-agent source.
- Context and customization: `docs/settings.md`, `docs/extensions.md`, `docs/skills.md`, `docs/prompt-templates.md`, `docs/themes.md`, `docs/packages.md`, and `.pi/` example resources.
- Extension patterns: `docs/extensions.md`, `packages/coding-agent/examples/extensions/`, `packages/coding-agent/src/core/`, and exported extension API types in `packages/coding-agent/src/index.ts`.
- Skills and prompt templates: `docs/skills.md`, `docs/prompt-templates.md`, `.pi/prompts/`, and any example package manifests.
- Packages and distribution: `docs/packages.md`, `pi.dev/packages`, npm metadata, package-manager source, and package examples.
- Programmatic integration: `docs/sdk.md`, `docs/rpc.md`, `docs/json.md`, `docs/tui.md`, `packages/coding-agent/examples/sdk/`, `packages/coding-agent/src/modes/`, and `packages/coding-agent/src/index.ts`.
- Platform setup: `docs/windows.md`, `docs/termux.md`, `docs/tmux.md`, `docs/terminal-setup.md`, `docs/shell-aliases.md`.
- Development and contribution: `packages/coding-agent/docs/development.md`, `CONTRIBUTING.md`, root `AGENTS.md`, root `package.json`, package `package.json` files, and tests.
- Source-derived internals: use `packages/coding-agent/src/` first, then `packages/agent/src/`, `packages/ai/src/`, and `packages/tui/src/`. Clearly label conclusions from implementation rather than docs.

## Topic Map

| Topic | Official paths |
| --- | --- |
| Overview and philosophy | `pi.dev`, `packages/coding-agent/README.md`, `packages/coding-agent/docs/index.md`, maintainer rationale posts |
| Install and update | npm package page/registry, `packages/coding-agent/package.json`, `packages/coding-agent/README.md`, `docs/packages.md` |
| CLI flags and commands | `packages/coding-agent/README.md`, `packages/coding-agent/src/cli.ts`, `packages/coding-agent/src/package-manager-cli.ts`, docs under `packages/coding-agent/docs/` |
| Built-in tools | `packages/coding-agent/README.md`, `packages/coding-agent/src/core/`, `packages/agent/src/` |
| Providers and models | `docs/providers.md`, `docs/models.md`, `docs/custom-provider.md`, `packages/ai/README.md`, `packages/ai/src/` |
| Authentication | `docs/providers.md`, `packages/coding-agent/src/core/`, `packages/ai/src/`, config source |
| Settings and config | `docs/settings.md`, `packages/coding-agent/src/config.ts`, `packages/coding-agent/src/migrations.ts`, `package.json` `piConfig` |
| Interactive mode | `docs/tui.md`, `docs/keybindings.md`, `packages/tui/README.md`, `packages/coding-agent/src/modes/interactive/` |
| Sessions and branching | `docs/session.md`, `docs/tree.md`, `docs/compaction.md`, `packages/agent/src/`, `packages/coding-agent/src/core/` |
| Context files | `packages/coding-agent/README.md`, `docs/settings.md`, source paths that load `AGENTS.md`, `CLAUDE.md`, `SYSTEM.md`, and `APPEND_SYSTEM.md` |
| Skills | `docs/skills.md`, Agent Skills standard linked from docs, `.pi` examples, skill-loading source |
| Prompt templates | `docs/prompt-templates.md`, `.pi/prompts/`, prompt-template loading source |
| Extensions | `docs/extensions.md`, `packages/coding-agent/examples/extensions/`, extension API exports/source |
| Themes | `docs/themes.md`, `packages/coding-agent/src/modes/interactive/theme/`, `packages/tui/src/` |
| Pi packages | `docs/packages.md`, `pi.dev/packages`, package-manager source, npm metadata |
| SDK | `docs/sdk.md`, `packages/coding-agent/examples/sdk/`, `packages/coding-agent/src/index.ts`, `packages/agent/src/` |
| RPC mode | `docs/rpc.md`, `packages/coding-agent/src/modes/rpc/` |
| JSON event stream mode | `docs/json.md`, `packages/coding-agent/src/modes/json/` |
| TUI components | `docs/tui.md`, `packages/tui/README.md`, `packages/tui/src/` |
| Platform setup | `docs/windows.md`, `docs/termux.md`, `docs/tmux.md`, `docs/terminal-setup.md`, `docs/shell-aliases.md` |
| Development | `docs/development.md`, `CONTRIBUTING.md`, root/package `package.json`, test files |
| Security model | `docs/extensions.md`, `docs/skills.md`, `docs/packages.md`, platform docs, source paths for tool execution and extension loading |
| Source-derived internals | `packages/coding-agent/src/`, `packages/agent/src/`, `packages/ai/src/`, `packages/tui/src/` |

## Hydrated Manifest

The sync script hydrates the following official material under `$HOME/.agents/knowledge/pi/upstream/pi/`:

- `landing/pi.dev.html`
- `landing/pi.dev_packages.html`
- `landing/maintainer-pi-coding-agent.html`
- `landing/maintainer-no-mcp.html`
- `npm/pi-coding-agent.latest.json`
- `repo/SOURCE_REF`
- `repo/README.md`, `repo/CONTRIBUTING.md`, `repo/AGENTS.md`, `repo/LICENSE`, root `package.json`, root TypeScript/config files
- `repo/packages/coding-agent/README.md`
- `repo/packages/coding-agent/CHANGELOG.md`
- `repo/packages/coding-agent/package.json`
- `repo/packages/coding-agent/docs/`
- `repo/packages/coding-agent/examples/`
- `repo/packages/coding-agent/src/`
- `repo/packages/agent/README.md`, `package.json`, `src/`
- `repo/packages/ai/README.md`, `package.json`, `src/`
- `repo/packages/tui/README.md`, `package.json`, `src/`
- selected root `.pi/` examples

Hydrated docs should not be bulk-loaded into context. Start with this manifest, then read only the topic-specific docs/source paths needed for the answer.

## Version-Sensitive Questions

For "latest", "current", "today", install, package, model/provider, extension API, or CLI behavior questions:

1. Check live `pi.dev`, npm metadata, or `badlogic/pi-mono` main.
2. Compare against the local hydrated `SOURCE_REF`.
3. If local Pi is installed, use `pi --version` and `pi --help` only as local installed-version evidence.
4. State whether the answer is based on live docs, pinned hydrated docs, npm metadata, source code, or local CLI output.

## Last-Resort External Source Rule

Do not use third-party tutorials, unofficial package READMEs, Discord messages, GitHub issues, blog commentary, Stack Overflow, or mirrors as source of truth unless the user approves that source for the question. If an external source is used, explicitly state:

1. which official Pi paths were checked,
2. why they were insufficient,
3. what external source is being used,
4. whether the conclusion is documented fact, source-derived inference, community convention, or uncertainty.
