---
name: experts
description: Use when a user wants to list, install, update, create, scaffold, validate, or manage reusable experts from the Integral-Dragon/Experts project without re-supplying the repository URL.
---

# Experts Helper

Use this skill when the user invokes `$experts` or asks to manage reusable expert packages from the Experts project.

## Purpose

Provide a persistent, repo-aware interface for the Experts project after the user has installed it once. The user should be able to say things like:

- `$experts list`
- `$experts install <name>`
- `$experts install <expert-name>`
- `$experts create a new expert for Shopify`
- `$experts update`

Do not require the user to remember or paste the GitHub URL again. The installed state records the URL, and the helper should use that URL to sync a fresh local cache before listing or installing experts.

## Remembered State

Start with:

1. `$HOME/.agents/knowledge/experts/install-state.env`
2. `$HOME/.agents/knowledge/experts/official-sources.md`
3. `EXPERTS_REPO_URL` as the source of truth.
4. `EXPERTS_REPO_CACHE` as the working checkout for current repo contents.
5. `EXPERTS_REPO_ROOT` only as a last-resort local development checkout when syncing the URL is unavailable.

## Core Workflow

1. Sync the Experts repo from its URL.
   - Treat `EXPERTS_REPO_URL` as canonical.
   - Use `EXPERTS_REPO_CACHE` as the normal working checkout.
   - If the cache exists, fetch from `EXPERTS_REPO_URL` and update the checked-out branch before listing, installing, or creating experts.
   - If the cache does not exist, clone `EXPERTS_REPO_URL` into `EXPERTS_REPO_CACHE`.
   - Use `EXPERTS_REPO_ROOT` only when the URL cannot be reached and the user accepts stale local contents.

2. Discover dynamically.
   - Use `./install.sh --list` for available experts.
   - Do not hardcode expert names in answers, routing, or installation logic.
   - Accept friendly names by matching against the dynamic list when there is exactly one clear match.

3. Install experts directly when requested.
   - Run `./install.sh --expert <expert-name> --hydrate` by default.
   - If hydration fails because network access is unavailable, rerun without `--hydrate`.
   - Use `--all --hydrate` only when the user explicitly asks for every expert.
   - Tell the user to restart Codex, Claude, or the relevant harness if new skills or agents do not appear immediately.

4. Create experts through this repo.
   - Follow `templates/CREATE_EXPERT.md`.
   - Scaffold with `scripts/scaffold-expert.sh`.
   - Validate with `./install.sh --expert <expert-name> --dry-run`.
   - Validate the generated sync script with `bash -n`.
   - Do not assume publishing. Install locally unless the user asks for private/internal packaging, a commit, or a PR.

5. Update the local Experts checkout when requested.
   - Fetch or clone from `EXPERTS_REPO_URL` into `EXPERTS_REPO_CACHE`.
   - After updating, list experts dynamically if the user asks what changed or what is available.

## Command Semantics

Treat `$experts` as the user's shorthand for this helper skill, not as a shell command that must literally exist.

Suggested interpretations:

| User wording | Action |
| --- | --- |
| `$experts list` | Sync from `EXPERTS_REPO_URL`, then run `./install.sh --list`. |
| `$experts install <name>` | Resolve `<name>` from the dynamic list and install that expert. |
| `$experts install all` | Confirm the user means all experts, then run `./install.sh --all --hydrate`. |
| `$experts create a new expert for <domain>` | Follow the repo's create-expert template. |
| `$experts update` | Update the remembered checkout, then report the current dynamic expert list if useful. |
| `$experts where` | Show the remembered repo root, cache path, and source URL. |

## Source Discipline

For project mechanics, use the synced checkout from `EXPERTS_REPO_URL` as the source of truth:

- `AGENTS.md`
- `README.md`
- `install.sh`
- `templates/CREATE_EXPERT.md`
- `templates/EXPERT_BLUEPRINT.md`
- `scripts/scaffold-expert.sh`

If synced repo files disagree with this helper skill, follow the synced repo files and mention the mismatch.

## Response Style

Be direct and operational. Prefer doing the requested repo action over explaining the project. Summarize the exact expert names installed or created, whether hydration ran, and whether the user needs to restart their agent harness.
