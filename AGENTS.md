# Agent Instructions

This repo is a Claude Code plugin marketplace. Each expert is a plugin under `plugins/<name>/`.

If a user asks to install Experts or any specific expert from this repo, do it directly with the native Claude Code plugin commands.

## Install Flow

1. Register the marketplace (idempotent):

   ```bash
   ./install.sh
   ```

   This runs `claude plugin marketplace add <repo>` (or `update` if already registered).

2. Install a specific expert:

   ```bash
   claude plugin install <expert-name>@experts
   ```

   The plugin installs disabled.

3. Enable / disable:

   ```bash
   claude plugin enable  <expert-name>@experts
   claude plugin disable <expert-name>@experts
   ```

   Restart Claude Code (or open a new session) for the change to take effect.

4. Install every expert (still disabled):

   ```bash
   ./install.sh --install-all
   ```

5. List available experts in this marketplace:

   ```bash
   ./install.sh --list
   ```

## Layout

```
.claude-plugin/marketplace.json   marketplace manifest (lists all plugins)
plugins/<name>/.claude-plugin/plugin.json
plugins/<name>/skills/<name>/SKILL.md
plugins/<name>/agents/<name>.md
install.sh                        thin marketplace bootstrap
```

No file-copy install paths to `~/.claude/agents/` or `~/.claude/skills/`. Plugins live under `~/.claude/plugins/cache/experts/` after install. Toggling them is a native operation.

## Adding a New Expert

1. `mkdir -p plugins/<name>/{.claude-plugin,skills/<name>,agents}`
2. Author `plugins/<name>/.claude-plugin/plugin.json`, `plugins/<name>/skills/<name>/SKILL.md`, and `plugins/<name>/agents/<name>.md`.
3. Add an entry to `plugins[]` in `.claude-plugin/marketplace.json`.
4. Validate:

   ```bash
   claude plugin validate .
   claude plugin validate plugins/<name>
   ```

5. Optionally publish via `git commit && git push`. For local-only experts, leave them uncommitted; the marketplace still serves them from the working tree.

## Source Discipline

Skills and subagents reference official sources for their domain. Hydrated upstream docs typically live at `$HOME/.agents/knowledge/<domain>/` (managed separately). Skills and agents in this repo should cite official paths and live URLs rather than embedding upstream content.
