# Experts

Domain expert packs for AI coding agents, packaged as a Claude Code plugin marketplace.

Each expert is a plugin with a focused skill plus a matching subagent grounded in official sources. Plugins install disabled — turn on what you want, when you want, with native `claude plugin` commands.

## Available Experts

| Expert | Focus |
|---|---|
| `claude-code-principal-engineer` | Claude Code CLI/IDE/Desktop/Web, settings, CLAUDE.md, permissions, sandboxing, hooks, skills, subagents, plugins, MCP, Agent SDK. |
| `codex-principal-engineer` | OpenAI Codex CLI, sandboxing, approvals, AGENTS.md, rules, skills, plugins, MCP, subagents, custom agents, non-interactive exec. |
| `firecracker-principal-engineer` | Firecracker microVM architecture, API, jailer, KVM/VMM internals, networking, storage, snapshots, MMDS, seccomp. |
| `hermes-agent-principal-engineer` | Hermes Agent: architecture, runtime, integrations, UI/UX/DX/TUI, product behavior, memory, skills, gateway, security. |
| `linux-systems-principal-engineer` | Linux systems, KVM, virtualization, containers, namespaces, cgroups, networking, routing, nftables, iproute2, systemd, Debian admin. |
| `pi-principal-engineer` | Pi coding agent: CLI/TUI, providers, settings, sessions, skills, extensions, packages, SDK/RPC, terminal setup. |

## Install

```bash
git clone https://github.com/Integral-Dragon/Experts.git
cd Experts
./install.sh
```

That registers this repo as a Claude Code marketplace named `experts`. From then on, manage everything natively:

```bash
claude plugin list
claude plugin install <name>@experts          # adds to installed set, disabled
claude plugin enable  <name>@experts          # turn on
claude plugin disable <name>@experts          # turn off
claude plugin uninstall <name>@experts
```

To install every expert at once (still disabled):

```bash
./install.sh --install-all
```

To list available experts:

```bash
./install.sh --list
```

Restart Claude Code (or run `/reload-plugins`) for enable/disable changes to take effect.

## Adding A New Expert

Create `plugins/<name>/` with:

```
plugins/<name>/
  .claude-plugin/plugin.json     # name, description, version, author
  skills/<name>/SKILL.md         # the skill (frontmatter: name, description)
  agents/<name>.md               # the subagent (frontmatter: name, description)
```

Then add an entry to `.claude-plugin/marketplace.json` under `plugins[]`:

```json
{
  "name": "<name>",
  "description": "...",
  "source": "./plugins/<name>",
  "category": "..."
}
```

Validate:

```bash
claude plugin validate .
claude plugin validate plugins/<name>
```
