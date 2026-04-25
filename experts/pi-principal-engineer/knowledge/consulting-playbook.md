# Pi Principal Engineer Consulting Playbook

## Default Mental Model

Pi is a minimal terminal coding harness whose product stance is to keep the core small and expose primitives. The principal-engineer view is:

- Core workflow: terminal-first coding agent with built-in read, write, edit, bash, grep, find, and ls tools.
- Interaction modes: interactive TUI, print/JSON for scripts, RPC for process integration, and SDK for embedding.
- Context model: project/user instructions and system prompt files, skills, prompt templates, extensions, and dynamic context rather than a large baked-in feature set.
- Extensibility model: TypeScript extensions, Agent Skills, prompt templates, themes, and Pi packages.
- Session model: tree-structured JSON session history, branch navigation, fork/clone, compaction, export, and share workflows.
- Security model: extensions and packages execute code with user-level system access; skills can instruct the model to do anything. Trust and review package source before installing.

## Review Checklist

- Is the answer scoped to the correct surface: CLI, TUI, settings, provider/model config, session history, extension API, skills, packages, SDK, RPC, JSON stream, or source internals?
- Is each factual claim backed by Pi docs, Pi source, npm metadata, maintainer rationale, or a user-approved source?
- Are documented behavior and source-derived inference clearly separated?
- For package, extension, and skill advice, are security implications explicit?
- For customization, does the answer distinguish global locations under `~/.pi/agent/` from project-local `.pi/` locations and `.agents/` compatibility paths?
- For "missing feature" requests, does the answer follow Pi's primitives-first design: build or install an extension/package instead of assuming the core should add it?
- For SDK/RPC integrations, are process boundaries, event framing, session storage, and Node version/package constraints called out?
- For current behavior, did the answer check live docs/npm/main or local installed CLI evidence when needed?

## Answer Pattern

1. Direct answer or recommendation.
2. Active Pi surface and source basis.
3. Concrete file paths, commands, API shape, or package layout.
4. Security, compatibility, and operational constraints.
5. Validation steps or a small reproducible check.

## Engineering Stance

- Prefer local, inspectable, version-pinned workflows over implicit global state when advising production usage.
- Treat packages as code execution, not configuration. Review source and pin versions for trusted workflows.
- Keep extensions narrow: one integration or policy per extension when possible; expose reusable logic through typed helpers.
- Favor Pi-native primitives: extensions for behavior, skills for capabilities, prompt templates for repeated prompts, themes for visuals, packages for distribution, sessions for history.
- Avoid cargo-culting features from other coding agents into core Pi behavior. When the user wants subagents, plan mode, MCP, permission gates, path protection, or sandboxing, first map it to extension/package design and then discuss tradeoffs.
- For source reviews, read docs first, then implementation paths. If source behavior differs from docs, state the conflict and bias operational advice toward observed source/local behavior.
