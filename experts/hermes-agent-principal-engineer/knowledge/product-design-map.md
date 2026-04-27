# Hermes Agent Product And Design Map

Use this map when the user asks product, UX, DX, TUI, CLI, gateway, web, voice, onboarding, roadmap, or design-quality questions. It is an index and interpretation guide, not a pasted documentation dump.

## Product Thesis

Hermes Agent is positioned as a long-lived autonomous agent, not a single-IDE coding copilot or one-off chatbot wrapper. The product promise is that Hermes gets more useful over time through persistent memory, skill creation and improvement, cross-session recall, user modeling, scheduled automation, platform presence, and server-side runtime options.

Treat the product as a system of surfaces around one agent identity:

- Local terminal conversation through classic CLI and TUI.
- Remote conversation through gateway platforms such as Telegram, Discord, Slack, WhatsApp, Signal, Matrix, Mattermost, Email, SMS, DingTalk, Feishu, WeCom, BlueBubbles, and Home Assistant.
- Voice interaction through CLI, messaging platforms, and Discord voice channels.
- Web/API/dashboard surfaces.
- Scheduled automation and unattended delivery.
- Developer extension through tools, toolsets, plugins, skills, MCP servers, providers, and platform adapters.
- Research workflows through trajectories, batch processing, and Atropos/RL environments.

## Design Principles

- Continuity beats channel purity. A user should be able to start in one surface and continue in another without relearning the agent's state model.
- The agent should feel alive but controllable: visible state, interruption, approval prompts, queued messages, progress, rollback/checkpoints, and safe fallbacks matter.
- Learning is a product feature, not just storage. Memory, skills, context files, SOUL/personality, and Honcho-backed user modeling are part of the UX contract.
- Autonomy needs guardrails. Command approval, platform authorization, container/remote isolation, credential pools, MCP filtering, and toolset boundaries are product affordances as much as security mechanisms.
- Interface parity matters, but each surface gets native affordances: modal overlays in TUI, platform-specific gateway commands in messaging, terminal keybindings in CLI, and dashboard/API patterns on web.
- The TUI is the modern interactive default for power users: richer overlays, non-blocking input, queue editing, live status, and low-flicker rendering should reduce cognitive friction.
- DX should preserve hackability: clear config files, command references, source-visible adapters, documented plugin/tool/provider extension points, and reproducible local tests.

## Surface Map

| Surface | Product role | Official paths |
| --- | --- | --- |
| Landing page | Promise, positioning, quick install, feature hierarchy | `website/docs/index.md`, `README.md`, `website/src/` |
| Classic CLI | Baseline interactive and scripting surface | `website/docs/user-guide/cli.md`, `website/docs/reference/cli-commands.md`, `hermes_cli/`, `cli.py`, `hermes` |
| TUI | Modern terminal product surface | `website/docs/user-guide/tui.md`, `ui-tui/README.md`, `ui-tui/src/`, `tui_gateway/`, `tests/tui_gateway/`, `ui-tui/src/__tests__/` |
| Messaging gateway | "Lives where you do" remote surface | `website/docs/user-guide/messaging/index.md`, `website/docs/user-guide/messaging/`, `website/docs/developer-guide/gateway-internals.md`, `gateway/`, `agent/transports/`, `hermes_cli/gateway.py` |
| Voice | Real-time voice workflows | `website/docs/user-guide/features/voice-mode.md`, `website/docs/guides/use-voice-mode-with-hermes.md`, `hermes_cli/voice.py`, gateway voice adapter code |
| Web/API/dashboard | Browser-facing product and integration surface | `website/docs/user-guide/features/web-dashboard.md`, `website/docs/user-guide/features/api-server.md`, `web/`, `hermes_cli/web_server.py` |
| Memory and user model | Personalization and cross-session continuity | `website/docs/user-guide/features/memory.md`, `website/docs/user-guide/features/memory-providers.md`, `website/docs/user-guide/features/honcho.md`, `plugins/memory/`, `hermes_state.py` |
| Skills | Procedural memory and community extension | `website/docs/user-guide/features/skills.md`, `website/docs/guides/work-with-skills.md`, `website/docs/developer-guide/creating-skills.md`, `skills/`, `optional-skills/`, `hermes_cli/skills_config.py`, `hermes_cli/skills_hub.py` |
| Tools/toolsets/MCP/plugins | Capability extension and safety boundary | `website/docs/user-guide/features/tools.md`, `website/docs/reference/tools-reference.md`, `website/docs/reference/toolsets-reference.md`, `website/docs/user-guide/features/mcp.md`, `website/docs/reference/mcp-config-reference.md`, `tools/`, `plugins/`, `hermes_cli/mcp_config.py` |
| Providers/models | No-lock-in model choice | `website/docs/integrations/providers.md`, `website/docs/reference/model-catalog.md`, `hermes_cli/providers.py`, `hermes_cli/model_catalog.py`, `model_tools.py` |
| Environments | Execution/runtime placement | `website/docs/developer-guide/environments.md`, `website/docs/user-guide/features/code-execution.md`, `tools/environments/`, `environments/` |
| Security | Trust, permissions, isolation, authorization | `website/docs/user-guide/security.md`, `SECURITY.md`, `website/docs/user-guide/features/credential-pools.md`, `website/docs/user-guide/features/mcp.md`, `docker/` |

## TUI / UX Review Lens

For TUI work, inspect both docs and source. The design center is a terminal-native UI that keeps the agent responsive while preserving command parity with the classic CLI.

Checklist:

- Startup: Does the UI show an instant first frame and avoid a frozen terminal while dependencies/session setup completes?
- Input: Does it support multiline composition, queueing while busy, editing queued messages, paste safety, image/path attachment normalization, and interruption without surprising sends?
- Discoverability: Are slash commands, completions, model/session pickers, help, usage, and details exposed without flooding the transcript?
- State: Are ready/thinking/running/interrupted/resuming states visible and consistent with gateway/session lifecycle?
- Prompting: Are approval, clarify, sudo, secret, model picker, and session picker flows modal, keyboard navigable, cancellable where possible, and safe by default?
- Transcript: Does streaming output, tool activity, reasoning, Markdown, ANSI, tables, diffs, and links stay readable without flicker or scrollback clutter?
- Parity: Does the behavior match classic CLI contracts unless the TUI intentionally adds native affordances?
- Accessibility and terminal reality: Does it handle TTY fallback, terminal keybinding variance, mouse conflicts, OSC52 clipboard behavior, and editor handoff?
- Theme/personality: Do skins, personalities, prompt glyphs, status colors, and live theme updates reinforce control without hiding state?
- Failure: Does a missing Node bundle, gateway protocol error, stderr noise, lost session, or non-interactive stdin fail with a diagnostic and a recoverable path?

## Product Review Lens

For product strategy or feature design, evaluate against:

- Does this strengthen the long-lived agent loop: memory, skills, context, user model, and recurring work?
- Does it work across surfaces or clearly explain why it is surface-specific?
- Does it reduce user babysitting while preserving explicit control for risky operations?
- Does it improve setup, recovery, migration, observability, or day-two operation?
- Does it avoid provider/platform lock-in and respect existing config/profile/toolset concepts?
- Does it create source-visible extension points for providers, tools, platforms, skills, or plugins?
- Does it preserve a humane mental model: "one agent that grows with me" rather than a pile of disconnected commands?

## Source-Derived Inference Rule

When docs are thin, inspect the official source and label conclusions as source-derived. For UX/product recommendations, distinguish:

- documented behavior,
- source-derived current behavior,
- local installed-version observation,
- product/design recommendation,
- open question or unsupported claim.
