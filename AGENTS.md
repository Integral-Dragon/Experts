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

This also installs the reusable `$experts` helper by default. The helper remembers this repo URL, syncs a working checkout from it, and lets future sessions handle prompts like:

```text
$experts list
$experts install <expert-name-or-friendly-name>
$experts create a new expert for <domain>
$experts update
```

Do not hardcode the current expert index into helper behavior. For `$experts` workflows, sync from the remembered repo URL first, then discover available experts with:

```bash
./install.sh --list
```

4. If network access is unavailable, omit hydration:

```bash
./install.sh --expert <expert-name>
```

5. Tell the user to restart Codex, Claude, or the relevant harness if the expert or `$experts` helper does not appear immediately.

Skip the helper only when explicitly requested:

```bash
./install.sh --expert <expert-name> --no-experts-toolkit
```

Install only the helper when requested:

```bash
./install.sh --experts-toolkit-only
```

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
| `$experts` helper skill | `$HOME/.agents/skills/experts/` |
| `$experts` helper state | `$HOME/.agents/knowledge/experts/install-state.env` |
| `$experts` Codex agent | `$HOME/.codex/agents/experts.toml` |
| `$experts` Claude agent | `$HOME/.claude/agents/experts.md` |

Codex custom agents are rendered from templates so paths use the installing user's `$HOME`.

## Context Rule

Do not bulk-load hydrated upstream docs. Start with the expert's skill and `knowledge/official-sources.md`, then read only the specific official docs or source files needed.

## Add A New Expert

If a user says `Create a new expert for <domain>`, follow [templates/CREATE_EXPERT.md](templates/CREATE_EXPERT.md).

Expected flow:

1. Clarify scope only when needed.
2. Clarify delivery only when needed: local-only, private/internal, or PR back to this repo.
3. Identify or propose official docs, source repos, specs, or user-approved authoritative sources.
4. Scaffold with `scripts/scaffold-expert.sh`.
5. Fill the source manifest, consulting playbook, sync script, skill, and Codex/Claude agents.
6. Update the README Expert Index only for shared-repo or PR work.
7. Validate before installing, committing, or opening a PR.

Do not assume publishing. For local-only experts, install them and stop. Commit, push, or open a PR only when the user asks for that outcome.

For file-level requirements, follow [templates/EXPERT_BLUEPRINT.md](templates/EXPERT_BLUEPRINT.md).

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

Validate before installing, committing, or opening a PR:

```bash
./install.sh --expert <expert-name> --dry-run
bash -n experts/<expert-name>/knowledge/scripts/sync-<domain>-docs.sh
```
