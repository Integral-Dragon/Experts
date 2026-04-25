# Claude Code Principal Engineer Official Sources

This expert is pinned to official Anthropic Claude Code sources discovered from `https://code.claude.com/llms.txt` on 2026-04-25.

Use live official docs or repo `main` when the user wants the current state. Use hydrated docs and recorded `SOURCE_REF` metadata when repeatability matters.

## Roots

- Claude Code docs root: `https://code.claude.com/docs/en/`
- Claude Code docs machine-readable index: `https://code.claude.com/llms.txt`
- Claude Code overview: `https://code.claude.com/docs/en/overview`
- Claude Code changelog: `https://code.claude.com/docs/en/changelog`
- Claude Code setup: `https://code.claude.com/docs/en/setup`
- Claude Code CLI reference: `https://code.claude.com/docs/en/cli-reference`
- Claude Code settings: `https://code.claude.com/docs/en/settings`
- Claude Code permissions: `https://code.claude.com/docs/en/permissions`
- Claude Code permission modes: `https://code.claude.com/docs/en/permission-modes`
- Claude Code sandboxing: `https://code.claude.com/docs/en/sandboxing`
- Claude Code hooks: `https://code.claude.com/docs/en/hooks`
- Claude Code MCP: `https://code.claude.com/docs/en/mcp`
- Claude Code skills: `https://code.claude.com/docs/en/skills`
- Claude Code subagents: `https://code.claude.com/docs/en/sub-agents`
- Claude Code plugins: `https://code.claude.com/docs/en/plugins`
- Claude Agent SDK docs: `https://code.claude.com/docs/en/agent-sdk/overview`
- Claude Code GitHub repo: `https://github.com/anthropics/claude-code`
- Claude Code GitHub Action: `https://github.com/anthropics/claude-code-action`
- Claude Code base action: `https://github.com/anthropics/claude-code-base-action`
- Official Claude Code plugins directory: `https://github.com/anthropics/claude-plugins-official`
- Official Anthropic skills repo: `https://github.com/anthropics/skills`
- Raw live root for Claude Code repo: `https://raw.githubusercontent.com/anthropics/claude-code/main/`
- Local cache root: `$HOME/.agents/knowledge/claude-code/upstream/claude-code/`

## Source Policy

Treat these as first-class authoritative sources:

- `code.claude.com` docs and Markdown pages linked from `llms.txt`.
- The official `anthropics/claude-code` repo for public source, plugin examples, packaged commands, release metadata, and README-level product statements.
- Official CI/CD and distribution repos managed by Anthropic: `claude-code-action`, `claude-code-base-action`, `claude-plugins-official`, and `skills`.
- Local installed CLI output only as evidence of the user's installed version, not as a substitute for live docs.

Do not use leaked source, third-party reverse engineering, unofficial mirrors, blog posts, Discord comments, Stack Overflow, or community gists as source of truth unless the user explicitly approves that source. If an external source is used, label it as external context and state which official sources were insufficient.

## Primary Reading Order

- Product model and surfaces: `overview.md`, `quickstart.md`, `how-claude-code-works.md`, `platforms.md`, `common-workflows.md`, `best-practices.md`, repo `README.md`.
- Installation, update, release channels, and troubleshooting: `setup.md`, `troubleshooting.md`, `errors.md`, `changelog.md`, repo `README.md`, local `claude --version` and `claude --help`.
- CLI and interactive behavior: `cli-reference.md`, `interactive-mode.md`, `commands.md`, `tools-reference.md`, `terminal-config.md`, `keybindings.md`, `statusline.md`, `fullscreen.md`, local slash-command output when relevant.
- Context, memory, and configuration: `memory.md`, `claude-directory.md`, `settings.md`, `env-vars.md`, `model-config.md`, `debug-your-config.md`, `context-window.md`, `/context`, `/doctor`.
- Permissions and security: `permission-modes.md`, `permissions.md`, `sandboxing.md`, `security.md`, `data-usage.md`, `legal-and-compliance.md`, `zero-data-retention.md`, `network-config.md`, `devcontainer.md`, `authentication.md`.
- Extension primitives: `features-overview.md`, `skills.md`, `sub-agents.md`, `hooks.md`, `hooks-guide.md`, `mcp.md`, `commands.md`, `output-styles.md`, `plugins.md`, `plugins-reference.md`, `plugin-marketplaces.md`, `plugin-dependencies.md`, `discover-plugins.md`.
- Agent SDK and programmatic use: `headless.md`, `agent-sdk/overview.md`, `agent-sdk/quickstart.md`, `agent-sdk/typescript.md`, `agent-sdk/python.md`, `agent-sdk/sessions.md`, `agent-sdk/permissions.md`, `agent-sdk/hooks.md`, `agent-sdk/mcp.md`, `agent-sdk/subagents.md`, `agent-sdk/skills.md`, `agent-sdk/user-input.md`, `agent-sdk/structured-outputs.md`.
- IDE/Desktop/Web/cloud/mobile surfaces: `vs-code.md`, `jetbrains.md`, `desktop.md`, `desktop-quickstart.md`, `desktop-scheduled-tasks.md`, `claude-code-on-the-web.md`, `web-quickstart.md`, `remote-control.md`, `chrome.md`, `computer-use.md`, `voice-dictation.md`, `ultraplan.md`, `ultrareview.md`.
- CI/CD and collaboration: `github-actions.md`, `gitlab-ci-cd.md`, `code-review.md`, `slack.md`, `channels.md`, `channels-reference.md`, `routines.md`, `scheduled-tasks.md`, `agent-teams.md`.
- Enterprise deployment and providers: `admin-setup.md`, `authentication.md`, `server-managed-settings.md`, `auto-mode-config.md`, `analytics.md`, `monitoring-usage.md`, `costs.md`, `amazon-bedrock.md`, `google-vertex-ai.md`, `microsoft-foundry.md`, `llm-gateway.md`, `third-party-integrations.md`.
- Source-derived behavior: start with the official docs above, then inspect hydrated official repo files from `repos/anthropics/claude-code/`, `repos/anthropics/claude-code-action/`, `repos/anthropics/claude-code-base-action/`, `repos/anthropics/claude-plugins-official/`, and `repos/anthropics/skills/`. Clearly label conclusions from implementation rather than documentation.

## Topic Map

| Topic | Official paths |
| --- | --- |
| Overview and product surfaces | `docs/overview.md`, `docs/platforms.md`, `docs/how-claude-code-works.md`, repo `anthropics/claude-code/README.md` |
| Install/update/version | `docs/setup.md`, `docs/troubleshooting.md`, `docs/changelog.md`, repo README, local `claude --version` |
| CLI flags and commands | `docs/cli-reference.md`, `docs/interactive-mode.md`, `docs/commands.md`, `docs/tools-reference.md`, local `claude --help` |
| CLAUDE.md and memory | `docs/memory.md`, `docs/claude-directory.md`, `docs/context-window.md`, `docs/debug-your-config.md` |
| Settings and env vars | `docs/settings.md`, `docs/env-vars.md`, `docs/model-config.md`, `docs/server-managed-settings.md` |
| Permissions and sandboxing | `docs/permission-modes.md`, `docs/permissions.md`, `docs/sandboxing.md`, `docs/auto-mode-config.md` |
| Hooks | `docs/hooks.md`, `docs/hooks-guide.md`, repo hook examples under `anthropics/claude-code/examples/` when present |
| Skills | `docs/skills.md`, repo `anthropics/skills/`, Claude Code repo packaged skills or commands when present |
| Subagents | `docs/sub-agents.md`, `docs/agent-sdk/subagents.md`, Claude Code repo agent examples when present |
| Commands and output styles | `docs/commands.md`, `docs/output-styles.md`, Claude Code repo `.claude/commands/` when present |
| Plugins | `docs/plugins.md`, `docs/plugins-reference.md`, `docs/plugin-marketplaces.md`, repo `anthropics/claude-plugins-official/`, Claude Code repo `plugins/` |
| MCP | `docs/mcp.md`, `docs/agent-sdk/mcp.md`, local `claude mcp list` |
| Agent SDK | `docs/headless.md`, `docs/agent-sdk/*.md` |
| IDEs | `docs/vs-code.md`, `docs/jetbrains.md` |
| Desktop and Web | `docs/desktop.md`, `docs/desktop-quickstart.md`, `docs/claude-code-on-the-web.md`, `docs/web-quickstart.md`, `docs/remote-control.md` |
| Browser/computer use | `docs/chrome.md`, `docs/computer-use.md` |
| CI/CD and code review | `docs/github-actions.md`, `docs/gitlab-ci-cd.md`, `docs/code-review.md`, repos `anthropics/claude-code-action/`, `anthropics/claude-code-base-action/` |
| Slack, channels, routines | `docs/slack.md`, `docs/channels.md`, `docs/channels-reference.md`, `docs/routines.md`, `docs/scheduled-tasks.md` |
| Enterprise providers | `docs/admin-setup.md`, `docs/authentication.md`, `docs/amazon-bedrock.md`, `docs/google-vertex-ai.md`, `docs/microsoft-foundry.md`, `docs/llm-gateway.md`, `docs/third-party-integrations.md` |
| Monitoring, costs, analytics | `docs/costs.md`, `docs/monitoring-usage.md`, `docs/analytics.md`, `docs/agent-sdk/cost-tracking.md`, `docs/agent-sdk/observability.md` |
| Security and compliance | `docs/security.md`, `docs/data-usage.md`, `docs/legal-and-compliance.md`, `docs/zero-data-retention.md`, repo `SECURITY.md` |
| Source-derived internals | Hydrated official repo files under `upstream/claude-code/repos/anthropics/...`; label all implementation conclusions as source-derived inference |

## Hydrated Manifest

The sync script hydrates the following official material under `$HOME/.agents/knowledge/claude-code/upstream/claude-code/`:

- `llms.txt`
- `docs/*.md` for curated Claude Code docs pages listed in the sync script.
- `repos/anthropics/claude-code/` selected public repo files and example/plugin/command directories.
- `repos/anthropics/claude-code-action/` selected action docs, metadata, source, scripts, examples, and package files.
- `repos/anthropics/claude-code-base-action/` selected base action docs, metadata, source, scripts, examples, and package files.
- `repos/anthropics/claude-plugins-official/` selected plugin directory metadata and plugin definitions.
- `repos/anthropics/skills/` selected official skill docs and skill packages.
- `SOURCE_REF` with sync timestamp and live repo SHAs when available.

Hydrated docs should not be bulk-loaded into context. Start with this manifest, then read only the topic-specific docs/source paths needed for the answer.

## Version-Sensitive Questions

For "latest", "current", "today", install/update, release channel, plan availability, model/provider, Agent SDK API, plugin, permission-mode, sandbox, or GitHub Action questions:

1. Check live `code.claude.com` docs or the relevant official repo `main`.
2. Compare against local hydrated `SOURCE_REF`.
3. If local Claude Code is installed, use `claude --version`, `claude --help`, and targeted subcommand/slash-command output only as local installed-version evidence.
4. State whether the answer is based on live docs, pinned hydrated docs, official source, or local CLI output.

## Last-Resort External Source Rule

Do not use non-Anthropic sources for Claude Code facts unless the user approves that source. If official sources do not cover the need, say:

1. which official Anthropic paths were checked,
2. why they were insufficient,
3. what can be inferred from official source code, local CLI output, or reproducible testing,
4. what remains unsupported.
