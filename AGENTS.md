# Agent Instructions

If a user asks you to install an expert from this repo, do it directly.

The intended user prompt is this simple:

```text
Install the codex-principal-engineer expert from https://github.com/Integral-Dragon/Experts
```

## Install Flow

1. Clone or open this repo.
2. From the repo root, list experts if needed:

```bash
./install.sh --list
```

3. Install the requested expert:

```bash
./install.sh --expert <expert-name> --hydrate
```

4. If network access is unavailable, omit hydration:

```bash
./install.sh --expert <expert-name>
```

5. Tell the user to restart Codex, Claude, or the relevant harness if the expert does not appear immediately.

Install all experts only when the user asks:

```bash
./install.sh --all --hydrate
```

Use dry-run for inspection:

```bash
./install.sh --expert <expert-name> --dry-run
```

## Installed Locations

The installer writes to the active user's home directory:

| Artifact | Destination |
| --- | --- |
| Skills | `$HOME/.agents/skills/<expert>/` |
| Knowledge manifests and sync scripts | `$HOME/.agents/knowledge/<domain>/` |
| Codex custom agents | `$HOME/.codex/agents/<expert>.toml` |
| Claude agents | `$HOME/.claude/agents/<expert>.md` |

Codex custom agents are rendered from templates so paths use the installing user's `$HOME`.

## Context Rule

Do not bulk-load hydrated upstream docs. Start with the expert's skill and `knowledge/official-sources.md`, then read only the specific official docs or source files needed.

## Add A New Expert

Follow [templates/EXPERT_BLUEPRINT.md](templates/EXPERT_BLUEPRINT.md).

Each expert package must have:

```text
experts/<expert-name>/
  skill/SKILL.md
  skill/agents/openai.yaml
  knowledge/official-sources.md
  knowledge/consulting-playbook.md
  knowledge/scripts/sync-*.sh
  agents/codex/<expert-name>.toml.template
  agents/claude/<expert-name>.md
```

Validate before committing:

```bash
./install.sh --expert <expert-name> --dry-run
```
