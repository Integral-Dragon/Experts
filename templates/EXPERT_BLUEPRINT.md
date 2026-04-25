# Expert Blueprint

Use this when adding a new expert to the repo. For the end-to-end guided flow, start with [CREATE_EXPERT.md](CREATE_EXPERT.md).

## Naming

- Expert folder: `experts/<domain>-principal-engineer`
- Skill name: `<domain>-principal-engineer`
- Codex custom agent: `<domain>-principal-engineer.toml.template`
- Claude agent: `<domain>-principal-engineer.md`
- Knowledge domain: remove the `-principal-engineer` suffix.

## Required Structure

```text
experts/<expert-name>/
  skill/
    SKILL.md
    agents/openai.yaml
  knowledge/
    official-sources.md
    consulting-playbook.md
    scripts/sync-<domain>-docs.sh
  agents/
    codex/<expert-name>.toml.template
    claude/<expert-name>.md
```

## Skill Requirements

`skill/SKILL.md` should be concise and should not embed long docs. It should include:

- role and persona,
- source discipline,
- workflow,
- engineering stance,
- response style.

The skill should point to:

- `$HOME/.agents/knowledge/<domain>/official-sources.md`
- `$HOME/.agents/knowledge/<domain>/upstream/<domain>/`
- official upstream URLs,
- sync script path.

## Knowledge Requirements

`knowledge/official-sources.md` should be the index. Include:

- official roots,
- primary reading order,
- topic map,
- docs/source manifest,
- last-resort source rule.

`knowledge/consulting-playbook.md` should include:

- default mental model,
- review checklist,
- answer pattern.

`knowledge/scripts/sync-<domain>-docs.sh` should hydrate only official sources. Avoid broad web crawling. Store hydrated docs under:

```text
$HOME/.agents/knowledge/<domain>/upstream/<domain>/
```

Hydrated docs should not be committed to this repo.

## Codex Agent Template

Use `{{HOME}}` anywhere the installed file needs the user's home directory.

Required fields:

```toml
name = "<expert-name>"
description = "Official-source <domain> expert..."
model = "gpt-5.5"
model_reasoning_effort = "high"
sandbox_mode = "read-only"
developer_instructions = """
...
"""

[[skills.config]]
path = "{{HOME}}/.agents/skills/<expert-name>/SKILL.md"
enabled = true
```

Only pin model/settings when the expert genuinely needs them. Leave settings unset when they should inherit from the spawning session.

## Claude Agent

Use Claude's Markdown agent format:

```md
---
name: <expert-name>
description: MUST BE USED for ...
---

You are ...
```

Point to the same `$HOME/.agents/knowledge/<domain>/...` paths.

## Validation

Run:

```bash
./install.sh --expert <expert-name> --dry-run
```

If available:

```bash
uv run --with pyyaml python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py experts/<expert-name>/skill
python -c 'import pathlib,tomllib; tomllib.loads(pathlib.Path("experts/<expert-name>/agents/codex/<expert-name>.toml.template").read_text().replace("{{HOME}}", "/tmp/home"))'
```
