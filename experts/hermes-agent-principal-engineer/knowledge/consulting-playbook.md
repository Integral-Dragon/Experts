# Hermes Agent Principal Engineer Consulting Playbook

Use this when answering Hermes Agent product strategy, UX/DX/TUI design, architecture, implementation, operational, security, extension, or debugging questions.

## Default Mental Model

Hermes Agent behavior is the composition of product promise, active surface, conversation/session state, memory and skills, model/provider routing, tool/toolset/MCP/plugin exposure, gateway platform semantics, environment backend, command approval/security policy, and the current source/installed version.

The product should feel like one long-lived agent that grows with the user, even though implementation spans Python runtime, React/Ink TUI, platform gateways, web surfaces, tools, skills, MCP, cron, and environment backends.

## Review Checklist

- Which surface is active: classic CLI, TUI, web/dashboard/API, gateway platform, voice, cron, Python library, MCP/plugin/tool extension, or developer internals?
- Which source matters: live docs, pinned repo source, hydrated cache, or the user's local installed Hermes?
- Is the claim documented, source-derived, locally observed, or product/design judgment?
- Does the answer preserve Hermes' product thesis: long-lived, self-improving, cross-surface, server-capable, provider-flexible, and safely autonomous?
- For UI/TUI/UX, does the flow respect visible state, interruption, queueing, progressive disclosure, command parity, keyboard navigation, fallback behavior, and terminal constraints?
- For DX, does the change preserve hackable config, clear command semantics, source-visible extension points, tests, and documented migration/recovery?
- Which boundary matters: platform auth, user allowlists, command approvals, container/SSH/Daytona/Modal isolation, credential pools, memory persistence, MCP filtering, browser automation, cron delivery, or tool permissions?
- Which artifact type is involved: `~/.hermes/config.yaml`, profiles, SOUL.md, context files, skills, plugins, MCP config, toolsets, gateway platform config, sessions/state DB, release notes, or source code?
- What local command or test proves the claim: `hermes --help`, `hermes doctor`, `hermes --tui`, `hermes setup`, `hermes model`, `hermes tools`, `hermes gateway --help`, a targeted pytest, or a TUI vitest?

## Answer Pattern

1. Recommendation or direct answer.
2. Source basis: official docs, repo docs/source, and local CLI evidence when relevant.
3. Active surface and product/UX implication.
4. Risk boundaries: security, permissions, persistence, cross-platform behavior, and operational failure modes.
5. Exact command/config/file/API shape.
6. Concrete validation step with expected observation.
