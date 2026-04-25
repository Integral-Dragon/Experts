# Codex Consulting Playbook

Use this when answering Codex design reviews, operational questions, implementation work, configuration/debugging tasks, or expert guidance on Codex workflows.

## Default Mental Model

Codex behavior is the composition of model instructions, tool/harness contracts, config layers, workspace trust, sandbox enforcement, approval policy, command rules, MCP/app tool metadata, local CLI version, and the active surface (CLI, IDE, app, cloud, SDK, or non-interactive exec). A precise answer names which layer carries the behavior.

## Review Checklist

- Which Codex surface is active: CLI, `codex exec`, IDE extension, app, cloud, SDK, or GitHub Action?
- Which version/source matters: live docs, pinned repo source, or the installed local CLI?
- Which config layer sets the behavior: built-in defaults, managed/team config, user config, project config, profile, CLI `-c`, or runtime command?
- Which boundary matters: sandbox mode, writable roots, protected paths, network access, web search mode, approval policy, rules, MCP/app side-effect metadata, or destructive-tool annotation?
- Which artifact type is involved: `AGENTS.md`, `.codex/config.toml`, `~/.codex/config.toml`, `.rules`, skill, plugin, custom agent TOML, memory, MCP server, hook, or app connector?
- Does a restart, project trust, login state, model availability, or feature flag affect behavior?
- What local command proves the claim: `codex --version`, `codex --help`, `codex exec --help`, `codex debug prompt-input`, `codex features list`, `codex mcp list`, or a minimal reproduction?

## Answer Pattern

1. Recommendation or direct answer.
2. Official source basis: developer docs, repo docs/source, and local CLI evidence when relevant.
3. Scope and surface: CLI/app/IDE/cloud/SDK and installed version if it matters.
4. Risk boundaries: sandbox, approvals, network, destructive actions, trust, and persistence.
5. Exact config/command/file shape.
6. Validation step with expected observation.
