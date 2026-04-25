# Codex Official Sources

This skill is pinned to official OpenAI Codex sources. Created against `openai/codex` main commit `bce74c70ce058982534507330ff33f7b196708ef` on 2026-04-25. The local CLI observed during creation was `codex-cli 0.125.0`.

Use live official docs or `main` when the user wants the current state. Use the pinned commit when repeatability matters.

## Roots

- Codex developer docs: `https://developers.openai.com/codex`
- Codex CLI page: `https://developers.openai.com/codex/cli`
- Codex configuration reference: `https://developers.openai.com/codex/config-reference`
- Codex sandbox and approvals: `https://developers.openai.com/codex/agent-approvals-security`, `https://developers.openai.com/codex/concepts/sandboxing`
- Codex subagents: `https://developers.openai.com/codex/subagents`, `https://developers.openai.com/codex/concepts/subagents`
- Codex skills: `https://developers.openai.com/codex/skills`
- Codex plugins: `https://developers.openai.com/codex/plugins`, `https://developers.openai.com/codex/plugins/build`
- Codex rules: `https://developers.openai.com/codex/rules`
- Codex GitHub repo: `https://github.com/openai/codex`
- Raw live root: `https://raw.githubusercontent.com/openai/codex/main/`
- Raw pinned root: `https://raw.githubusercontent.com/openai/codex/bce74c70ce058982534507330ff33f7b196708ef/`
- Local cache root: `$HOME/.agents/knowledge/codex/upstream/codex/`

## Primary Reading Order

- Product and surface overview: developer docs `codex.md`, `codex/quickstart.md`, `codex/cli.md`, repo `README.md`.
- CLI command behavior: developer docs `codex/cli/reference.md`, `codex/cli/features.md`, repo `docs/exec.md`, `docs/getting-started.md`, and local `codex --help`.
- Sandboxing, approvals, and network access: developer docs `codex/agent-approvals-security.md`, `codex/concepts/sandboxing.md`, repo `docs/sandbox.md`, `docs/execpolicy.md`, `codex-rs/sandboxing/`, `codex-rs/shell-escalation/`, `codex-rs/execpolicy/`.
- Configuration: developer docs `codex/config-basic.md`, `codex/config-advanced.md`, `codex/config-reference.md`, `codex/config-sample.md`, repo `docs/config.md`, `docs/example-config.md`, `codex-rs/config.md`, `codex-rs/config/`.
- Instructions and customization: developer docs `codex/concepts/customization.md`, `codex/guides/agents-md.md`, repo `docs/agents_md.md`, `AGENTS.md`.
- Rules and command policy: developer docs `codex/rules.md`, repo `docs/execpolicy.md`, `codex-rs/execpolicy/`, `codex-rs/execpolicy-legacy/`.
- Skills and plugins: developer docs `codex/skills.md`, `codex/plugins.md`, `codex/plugins/build.md`, repo `docs/skills.md`, `.codex/skills/`, `codex-rs/skills/`, `codex-rs/plugin/`, `codex-rs/core-skills/`, `codex-rs/core-plugins/`.
- Subagents and custom agents: developer docs `codex/subagents.md`, `codex/concepts/subagents.md`, config reference `agents.*` keys, `codex-rs/core/`, `codex-rs/protocol/`.
- MCP and integrations: developer docs `codex/mcp.md`, `codex/guides/agents-sdk.md`, repo `codex-rs/mcp-server/`, `codex-rs/codex-mcp/`, `codex-rs/rmcp-client/`.
- Non-interactive and review workflows: developer docs `codex/noninteractive.md`, `codex/cli/features.md`, repo `docs/exec.md`, local `codex exec --help`.
- Prompting and model guidance: developer docs `codex/prompting.md`, `cookbook/examples/gpt-5/codex_prompting_guide.md`, repo `codex-rs/core/*prompt*.md`, `codex-rs/model-provider-info/`, `codex-rs/models-manager/`.
- App, IDE, cloud, and GitHub Action: relevant developer docs under `codex/app/`, `codex/ide/`, `codex/cloud/`, and `codex/github-action.md`.
- Security: developer docs `codex/security*.md`, repo `SECURITY.md`, sandbox/approval docs, and source paths named above.

## Topic Map

| Topic | Official paths |
| --- | --- |
| Overview and install | Developer docs `codex.md`, `codex/quickstart.md`, `codex/cli.md`; repo `README.md`, `docs/install.md` |
| CLI flags and subcommands | Developer docs `codex/cli/reference.md`; local `codex --help`; repo `codex-rs/cli/` |
| Interactive features | Developer docs `codex/cli/features.md`, `codex/cli/slash-commands.md`; repo `docs/slash_commands.md`, `codex-rs/tui/` |
| Non-interactive exec | Developer docs `codex/noninteractive.md`; repo `docs/exec.md`; local `codex exec --help` |
| Authentication | Developer docs `codex/auth.md`; repo `docs/authentication.md`, `codex-rs/login/`, `codex-rs/chatgpt/`, `codex-rs/device-key/` |
| Models and reasoning | Developer docs `codex/models.md`, `codex/prompting.md`; repo `codex-rs/models-manager/`, `codex-rs/model-provider-info/` |
| Configuration | Developer docs `codex/config-basic.md`, `codex/config-advanced.md`, `codex/config-reference.md`, `codex/config-sample.md`; repo `docs/config.md`, `docs/example-config.md`, `codex-rs/config.md`, `codex-rs/config/` |
| Sandboxing | Developer docs `codex/concepts/sandboxing.md`, `codex/agent-approvals-security.md`; repo `docs/sandbox.md`, `codex-rs/sandboxing/`, `codex-rs/linux-sandbox/`, `codex-rs/windows-sandbox-rs/` |
| Approvals and escalation | Developer docs `codex/agent-approvals-security.md`, config reference `approval_policy`; repo `codex-rs/shell-escalation/`, `codex-rs/shell-command/`, `codex-rs/core/` |
| Rules and exec policy | Developer docs `codex/rules.md`; repo `docs/execpolicy.md`, `codex-rs/execpolicy/`, `codex-rs/execpolicy-legacy/` |
| Network and web search | Developer docs `codex/agent-approvals-security.md`, `codex/cloud/internet-access.md`, config reference `web_search`, `sandbox_workspace_write.network_access` |
| AGENTS.md | Developer docs `codex/guides/agents-md.md`; repo `docs/agents_md.md`, `AGENTS.md` |
| Skills | Developer docs `codex/skills.md`; repo `docs/skills.md`, `.codex/skills/`, `codex-rs/skills/`, `codex-rs/core-skills/` |
| Plugins | Developer docs `codex/plugins.md`, `codex/plugins/build.md`; repo `codex-rs/plugin/`, `codex-rs/core-plugins/` |
| Subagents and custom agents | Developer docs `codex/subagents.md`, `codex/concepts/subagents.md`, config reference `agents.*`; repo `codex-rs/core/`, `codex-rs/protocol/` |
| MCP | Developer docs `codex/mcp.md`, `codex/guides/agents-sdk.md`; repo `codex-rs/mcp-server/`, `codex-rs/codex-mcp/`, `codex-rs/rmcp-client/` |
| Hooks | Developer docs `codex/hooks.md`; repo `codex-rs/hooks/` |
| Memories | Developer docs `codex/memories.md`, `codex/memories/chronicle.md`; repo `codex-rs/state/`, `codex-rs/thread-store/` |
| IDE extension | Developer docs `codex/ide.md`, `codex/ide/features.md`, `codex/ide/settings.md`, `codex/ide/commands.md`, `codex/ide/slash-commands.md` |
| Codex app | Developer docs `codex/app.md`, `codex/app/features.md`, `codex/app/settings.md`, `codex/app/commands.md`, `codex/app/local-environments.md`, `codex/app/worktrees.md` |
| Codex cloud | Developer docs `codex/cloud.md`, `codex/cloud/environments.md`, `codex/cloud/internet-access.md` |
| GitHub Action | Developer docs `codex/github-action.md` |
| SDK | Developer docs `codex/sdk.md`; repo `sdk/` |
| Security | Developer docs `codex/security.md`, `codex/security/setup.md`, `codex/security/faq.md`, `codex/security/threat-model.md`; repo `SECURITY.md` |

## Developer Docs Manifest

The sync script hydrates these official Markdown pages under `developers.openai.com/`:

- `codex.md`
- `codex/quickstart.md`
- `codex/cli.md`
- `codex/cli/features.md`
- `codex/cli/reference.md`
- `codex/cli/slash-commands.md`
- `codex/auth.md`
- `codex/models.md`
- `codex/pricing.md`
- `codex/agent-approvals-security.md`
- `codex/concepts/customization.md`
- `codex/concepts/sandboxing.md`
- `codex/concepts/subagents.md`
- `codex/config-basic.md`
- `codex/config-advanced.md`
- `codex/config-reference.md`
- `codex/config-sample.md`
- `codex/guides/agents-md.md`
- `codex/guides/agents-sdk.md`
- `codex/mcp.md`
- `codex/rules.md`
- `codex/skills.md`
- `codex/plugins.md`
- `codex/plugins/build.md`
- `codex/subagents.md`
- `codex/noninteractive.md`
- `codex/hooks.md`
- `codex/memories.md`
- `codex/memories/chronicle.md`
- `codex/prompting.md`
- `codex/workflows.md`
- `codex/speed.md`
- `codex/security.md`
- `codex/security/setup.md`
- `codex/security/faq.md`
- `codex/security/threat-model.md`
- `codex/ide.md`
- `codex/ide/features.md`
- `codex/ide/settings.md`
- `codex/ide/commands.md`
- `codex/ide/slash-commands.md`
- `codex/app.md`
- `codex/app/features.md`
- `codex/app/settings.md`
- `codex/app/commands.md`
- `codex/app/local-environments.md`
- `codex/app/worktrees.md`
- `codex/cloud.md`
- `codex/cloud/environments.md`
- `codex/cloud/internet-access.md`
- `codex/github-action.md`
- `codex/sdk.md`
- `codex/open-source.md`
- `codex/feature-maturity.md`
- `cookbook/examples/gpt-5/codex_prompting_guide.md`

## Last-Resort Rule

Do not use non-OpenAI sources for Codex facts. If official sources do not cover the need, say:

1. which official OpenAI paths were checked,
2. why they were insufficient,
3. what can be inferred from official source code, local CLI output, or reproducible testing,
4. what remains unsupported.
