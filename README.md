# Experts

Portable expert packages for agent harnesses.

This repo packages domain experts as reusable agent artifacts. Each expert includes:

- a Codex/OpenAI-style skill with progressive-disclosure instructions,
- official-source manifests and sync scripts,
- Codex custom-agent templates,
- Claude agent wrappers,
- installation instructions for agent harnesses.

The initial experts are:

- `codex-principal-engineer`
- `firecracker-principal-engineer`
- `linux-systems-principal-engineer`

## Quick Install

Clone the repo, then install every expert:

```bash
./install.sh --all --hydrate
```

Install one expert:

```bash
./install.sh --expert codex-principal-engineer --hydrate
```

Install without fetching upstream docs:

```bash
./install.sh --all
```

The installer writes to the current user's agent locations:

- skills: `$HOME/.agents/skills/<expert>/`
- knowledge manifests and sync scripts: `$HOME/.agents/knowledge/<domain>/`
- Codex custom agents: `$HOME/.codex/agents/<expert>.toml`
- Claude agents: `$HOME/.claude/agents/<expert>.md`

Restart Codex or Claude after installation if a running session does not show the new expert.

## Agent Harness Usage

Give a coding agent this repo and say:

```text
Install the expert I need from this repository. Read AGENTS.md first, then run the installer for the requested expert.
```

For example:

```text
Install codex-principal-engineer from https://github.com/Integral-Dragon/Experts.
```

The agent should:

1. Clone or open this repo.
2. Read `AGENTS.md`.
3. Run `./install.sh --expert <expert-name> --hydrate` when network access is allowed.
4. Run `./install.sh --expert <expert-name>` when offline, then hydrate later using the expert's sync script.

## Progressive Disclosure

The installed skills are intentionally small. They do not load the hydrated documentation corpus into the initial prompt. Instead, each skill:

1. identifies the topic,
2. reads the relevant `official-sources.md` manifest,
3. selects the specific docs/source paths needed,
4. loads only those files from `$HOME/.agents/knowledge/<domain>/upstream/...`,
5. separates documented behavior, source-derived inference, local environment facts, and uncertain information.

Hydrated upstream docs are generated locally and ignored by this repo.

## Adding Experts

Use `templates/EXPERT_BLUEPRINT.md` as the pattern. A new expert should live at:

```text
experts/<expert-name>/
  skill/
  knowledge/
  agents/codex/
  agents/claude/
```

The installer discovers experts by directory name, so new experts do not need installer code changes if they follow the structure.

## Upstream Docs

This repo stores official-source manifests and sync scripts, not vendored upstream documentation. Hydrated docs are fetched into the user's home directory by the sync scripts. Upstream documentation remains governed by upstream licenses and terms.
