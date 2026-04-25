# Experts Harness Adapter Contract

Use this file to integrate the Experts helper with any AI coding-agent harness.

The project is intentionally harness-neutral. Codex and Claude adapters are included because they have known local agent formats, but the core interface is the installed skill, knowledge state, and this manifest. The Experts helper is a shared user-scoped toolkit; individual experts do not get separate helper instances.

## Invocation

Route these user requests to the Experts helper:

- `Experts: ...`
- `use the Experts helper to ...`
- `ask Experts to ...`
- `experts ...`
- `install <name> expert`
- `list available experts`
- `create a new expert for <domain>`
- `update experts`

Harness-specific aliases such as `$experts`, `@experts`, or slash commands are optional. Do not assume they exist. The portable interface is natural language that names the Experts helper.

## Required Context

Load these files:

1. `$HOME/.agents/skills/experts/SKILL.md`
2. `$HOME/.agents/knowledge/experts/install-state.env`
3. `$HOME/.agents/knowledge/experts/official-sources.md`
4. `$HOME/.agents/toolkits/experts/manifest.json`

## Repository Rule

`EXPERTS_REPO_URL` is canonical. Use `EXPERTS_REPO_CACHE` as the working checkout.

Before list, install, update, or create operations:

1. Clone `EXPERTS_REPO_URL` into `EXPERTS_REPO_CACHE` if the cache does not exist.
2. Otherwise fetch from `EXPERTS_REPO_URL` and update the checked-out branch.
3. Run project commands from the synced checkout.

Use `EXPERTS_REPO_ROOT` only as a stale fallback when the URL cannot be reached and the user accepts that limitation.

## Dynamic Discovery

Discover experts with:

```bash
./install.sh --list
```

Never hardcode expert names in the harness adapter.

## Operations

Install one expert:

```bash
./install.sh --expert <expert-name> --hydrate
```

If hydration cannot run because network access is unavailable:

```bash
./install.sh --expert <expert-name>
```

Create a new expert by following:

- `templates/CREATE_EXPERT.md`
- `templates/EXPERT_BLUEPRINT.md`

Validate new experts with:

```bash
./install.sh --expert <expert-name> --dry-run
bash -n experts/<expert-name>/knowledge/scripts/sync-<domain>-docs.sh
```

## Adapter Requirements

A harness adapter should:

- Load the skill and manifest above.
- Preserve the source-of-truth rule: sync from `EXPERTS_REPO_URL` first.
- Treat installed artifacts as user-scoped agent resources.
- Report what command ran and whether the user should restart or reload the harness.
- Avoid publishing, committing, pushing, or opening PRs unless the user asks.
