# Hermes Agent Principal Engineer Official Sources

This expert is pinned to official Hermes Agent / Nous Research sources. Created against `NousResearch/hermes-agent` main commit `65f648ee84ff97a90fd43d85e521a7100c6a999d` on 2026-04-27, with the public docs and landing page at `hermes-agent.nousresearch.com`.

Use live official docs or repo `main` when the user wants the current state. Use the pinned commit when repeatability matters.

## Roots

- https://hermes-agent.nousresearch.com/
- https://hermes-agent.nousresearch.com/docs
- https://github.com/NousResearch/hermes-agent
- Raw live root: `https://raw.githubusercontent.com/NousResearch/hermes-agent/main/`
- Raw pinned root: `https://raw.githubusercontent.com/NousResearch/hermes-agent/65f648ee84ff97a90fd43d85e521a7100c6a999d/`
- Local cache root: `$HOME/.agents/knowledge/hermes-agent/upstream/hermes-agent/`
- Product and design map: `$HOME/.agents/knowledge/hermes-agent/product-design-map.md`

## Primary Reading Order

- Product positioning and mental model: landing page `https://hermes-agent.nousresearch.com/`, docs `website/docs/index.md`, repo `README.md`, release notes `RELEASE_v*.md`.
- Getting started and day-one UX: `website/docs/getting-started/installation.md`, `quickstart.md`, `learning-path.md`, `updating.md`, `termux.md`, `nix-setup.md`, plus `scripts/install.sh`.
- CLI and command behavior: `website/docs/user-guide/cli.md`, `website/docs/reference/cli-commands.md`, `website/docs/reference/slash-commands.md`, `hermes_cli/`, `cli.py`, `hermes`, and local `hermes --help` when installed behavior matters.
- TUI, UI, UX, and DX: `website/docs/user-guide/tui.md`, `ui-tui/README.md`, `ui-tui/src/`, `tui_gateway/`, `ui-tui/src/__tests__/`, `tests/tui_gateway/`, and `$HOME/.agents/knowledge/hermes-agent/product-design-map.md`.
- Configuration, providers, and models: `website/docs/user-guide/configuration.md`, `website/docs/user-guide/profiles.md`, `website/docs/reference/profile-commands.md`, `website/docs/integrations/providers.md`, `website/docs/reference/environment-variables.md`, `website/docs/reference/model-catalog.md`, `hermes_cli/config.py`, `providers.py`, `models.py`, `model_catalog.py`, `model_switch.py`, `runtime_provider.py`.
- Gateway and platform UX: `website/docs/user-guide/messaging/index.md`, `website/docs/user-guide/messaging/`, `website/docs/developer-guide/gateway-internals.md`, `website/docs/developer-guide/adding-platform-adapters.md`, `gateway/`, `agent/transports/`, `hermes_cli/gateway.py`, `tests/gateway/`.
- Memory, personalization, context, and SOUL: `website/docs/user-guide/features/memory.md`, `memory-providers.md`, `honcho.md`, `personality.md`, `context-files.md`, `context-references.md`, `website/docs/guides/use-soul-with-hermes.md`, `plugins/memory/`, `plugins/context_engine/`, `hermes_state.py`, `hermes_cli/memory_setup.py`, `default_soul.py`.
- Skills and procedural learning: `website/docs/user-guide/features/skills.md`, `website/docs/guides/work-with-skills.md`, `website/docs/developer-guide/creating-skills.md`, `website/docs/reference/skills-catalog.md`, `website/docs/reference/optional-skills-catalog.md`, `skills/`, `optional-skills/`, `hermes_cli/skills_config.py`, `hermes_cli/skills_hub.py`.
- Tools, toolsets, MCP, plugins, and extension points: `website/docs/user-guide/features/tools.md`, `tool-gateway.md`, `mcp.md`, `plugins.md`, `built-in-plugins.md`, `website/docs/guides/use-mcp-with-hermes.md`, `website/docs/reference/tools-reference.md`, `toolsets-reference.md`, `mcp-config-reference.md`, `website/docs/developer-guide/adding-tools.md`, `tools-runtime.md`, `plugins/`, `tools/`, `hermes_cli/tools_config.py`, `mcp_config.py`, `plugins.py`.
- Environments, execution, delegation, browser, cron, voice, and research: `website/docs/developer-guide/environments.md`, `website/docs/user-guide/features/code-execution.md`, `delegation.md`, `browser.md`, `cron.md`, `voice-mode.md`, `rl-training.md`, `website/docs/guides/delegation-patterns.md`, `automate-with-cron.md`, `use-voice-mode-with-hermes.md`, `tools/environments/`, `cron/`, `environments/`, `batch_runner.py`.
- Architecture and internals: `website/docs/developer-guide/architecture.md`, `agent-loop.md`, `provider-runtime.md`, `prompt-assembly.md`, `context-compression-and-caching.md`, `session-storage.md`, `acp-internals.md`, `trajectory-format.md`, `agent/`, `tools/`, `gateway/`, `cron/`, `acp_adapter/`, `acp_registry/`.
- Security and production operations: `website/docs/user-guide/security.md`, `SECURITY.md`, `website/docs/user-guide/docker.md`, `checkpoints-and-rollback.md`, `git-worktrees.md`, `features/credential-pools.md`, `features/mcp.md`, `docker/`, `.env.example`, `cli-config.yaml.example`.
- Troubleshooting and validation: `website/docs/reference/faq.md`, `hermes_cli/doctor.py`, `tests/`, `scripts/run_tests.sh`, `ui-tui/src/__tests__/`, `website/docs/developer-guide/contributing.md`.

## Topic Map

| Topic | Official paths |
| --- | --- |
| Product positioning | Landing page, `website/docs/index.md`, `README.md`, `RELEASE_v*.md` |
| Install and onboarding | `website/docs/getting-started/installation.md`, `quickstart.md`, `learning-path.md`, `scripts/install.sh`, `hermes_cli/setup.py` |
| CLI and slash commands | `website/docs/user-guide/cli.md`, `website/docs/reference/cli-commands.md`, `website/docs/reference/slash-commands.md`, `hermes_cli/`, `cli.py` |
| TUI UX and interaction model | `website/docs/user-guide/tui.md`, `ui-tui/README.md`, `ui-tui/src/`, `tui_gateway/`, `ui-tui/src/__tests__/`, `tests/tui_gateway/` |
| Web/dashboard/API | `website/docs/user-guide/features/web-dashboard.md`, `features/api-server.md`, `web/`, `hermes_cli/web_server.py` |
| Messaging platforms | `website/docs/user-guide/messaging/index.md`, `website/docs/user-guide/messaging/`, `website/docs/developer-guide/gateway-internals.md`, `gateway/`, `agent/transports/`, `hermes_cli/gateway.py` |
| Voice | `website/docs/user-guide/features/voice-mode.md`, `website/docs/guides/use-voice-mode-with-hermes.md`, `hermes_cli/voice.py` |
| Configuration and profiles | `website/docs/user-guide/configuration.md`, `profiles.md`, `website/docs/reference/environment-variables.md`, `hermes_cli/config.py`, `profiles.py` |
| Providers and model routing | `website/docs/integrations/providers.md`, `website/docs/reference/model-catalog.md`, `hermes_cli/providers.py`, `model_catalog.py`, `model_switch.py`, `runtime_provider.py` |
| Memory, personalization, context | `website/docs/user-guide/features/memory.md`, `memory-providers.md`, `honcho.md`, `personality.md`, `context-files.md`, `plugins/memory/`, `plugins/context_engine/`, `hermes_state.py` |
| Skills and learning loop | `website/docs/user-guide/features/skills.md`, `website/docs/guides/work-with-skills.md`, `website/docs/developer-guide/creating-skills.md`, `skills/`, `optional-skills/`, `hermes_cli/skills_config.py` |
| Tools/toolsets/MCP/plugins | `website/docs/user-guide/features/tools.md`, `tool-gateway.md`, `mcp.md`, `plugins.md`, `website/docs/reference/tools-reference.md`, `toolsets-reference.md`, `mcp-config-reference.md`, `tools/`, `plugins/` |
| Delegation, environments, cron | `website/docs/user-guide/features/delegation.md`, `code-execution.md`, `cron.md`, `website/docs/developer-guide/environments.md`, `tools/environments/`, `cron/` |
| Browser, vision, image, TTS | `website/docs/user-guide/features/browser.md`, `vision.md`, `image-generation.md`, `tts.md`, `tools/browser_providers/`, `plugins/image_gen/` |
| Architecture and runtime | `website/docs/developer-guide/architecture.md`, `agent-loop.md`, `provider-runtime.md`, `prompt-assembly.md`, `tools-runtime.md`, `agent/`, `tools/` |
| Security and operations | `website/docs/user-guide/security.md`, `SECURITY.md`, `website/docs/user-guide/docker.md`, `checkpoints-and-rollback.md`, `docker/` |
| Research and training | `website/docs/user-guide/features/rl-training.md`, `website/docs/developer-guide/trajectory-format.md`, `batch_runner.py`, `environments/`, `tinker-atropos/` |

## Complete Manifest

The sync script hydrates these official materials:

- Landing/docs HTML: `https://hermes-agent.nousresearch.com/`, `https://hermes-agent.nousresearch.com/docs`.
- Official docs tree from repo: `website/docs/`.
- Website structure and visual/product source: `website/src/`, `website/static/`, `website/docusaurus.config.ts`, `website/sidebars.ts`.
- Top-level repo docs: `README.md`, `AGENTS.md`, `CONTRIBUTING.md`, `SECURITY.md`, `LICENSE`, `.env.example`, `cli-config.yaml.example`, `RELEASE_v*.md`, `pyproject.toml`.
- Product/runtime source slices: `hermes_cli/`, `agent/`, `gateway/`, `tui_gateway/`, `ui-tui/README.md`, `ui-tui/src/`, `web/`, `tools/`, `plugins/`, `skills/`, `optional-skills/`, `cron/`, `environments/`, `acp_adapter/`, `acp_registry/`.
- Validation slices: `tests/`, `ui-tui/src/__tests__/`.

Hydrated upstream files are reference material only and should not be committed to this repo.

## Last-Resort External Source Rule

Do not use non-official or non-authoritative sources for Hermes Agent facts unless the user explicitly approves them. If official sources do not cover the need, say:

1. which official Hermes paths were checked,
2. why they were insufficient,
3. what can be inferred from official source code, local CLI output, or reproducible testing,
4. what is product/design judgment rather than documented behavior,
5. what remains unsupported.
