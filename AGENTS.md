# Agent Instructions

This repo contains portable expert packages. If a user asks you to install or use an expert from this repo, follow these instructions.

## Install Existing Experts

Use the installer from the repo root.

Install all experts:

```bash
./install.sh --all --hydrate
```

Install one expert:

```bash
./install.sh --expert codex-principal-engineer --hydrate
```

Use `--hydrate` when network access is available. If network access is unavailable, omit `--hydrate`; the expert still installs with source manifests and can hydrate later using its sync script.

Before installing, you may inspect available experts:

```bash
./install.sh --list
```

Use a dry run to show what would be written:

```bash
./install.sh --expert codex-principal-engineer --dry-run
```

## Install Locations

The installer writes to the active user's home directory:

- `$HOME/.agents/skills/<expert>/`
- `$HOME/.agents/knowledge/<domain>/`
- `$HOME/.codex/agents/<expert>.toml`
- `$HOME/.claude/agents/<expert>.md`

The installed Codex agent files are rendered from templates so paths use the user's own `$HOME`, not the path from the authoring machine.

## Expert Package Contract

Each expert package must use this structure:

```text
experts/<expert-name>/
  skill/
    SKILL.md
    agents/openai.yaml
  knowledge/
    official-sources.md
    consulting-playbook.md
    scripts/sync-*.sh
  agents/
    codex/<expert-name>.toml.template
    claude/<expert-name>.md
```

The installer discovers experts by scanning `experts/*/skill/SKILL.md`.

## Context Discipline

Do not bulk-load hydrated upstream docs. Use the skill and `knowledge/official-sources.md` as an index. Load only the specific official docs or source files needed for the user's question.

## Adding A New Expert

Use `templates/EXPERT_BLUEPRINT.md`. Preserve the same source discipline:

- official/public sources first,
- local hydrated cache when present,
- sync script for hydration,
- explicit source manifest,
- progressive disclosure through topic maps,
- clear separation of documented facts, source-code inference, local facts, and uncertain information.

After adding an expert, validate with:

```bash
./install.sh --expert <expert-name> --dry-run
```

If Codex's skill validator is available, also validate the skill:

```bash
uv run --with pyyaml python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py experts/<expert-name>/skill
```
