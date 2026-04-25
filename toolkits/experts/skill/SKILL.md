---
name: experts
description: Use when a user wants to list, install, update, create, scaffold, validate, or manage reusable experts from the Integral-Dragon/Experts project without re-supplying the repository URL.
---

# Experts Helper

Use this skill when the user names the Experts helper or asks to manage reusable expert packages from the Experts project. This is a harness-neutral helper; Codex, Claude, Pi, OpenCode, Hermes, and other coding-agent harnesses should all be able to adapt it.

## Purpose

Provide a persistent, repo-aware interface for the Experts project after the user has installed the shared helper once. The user should be able to say things like:

- `Experts: list available experts`
- `Experts: install <name>`
- `Use the Experts helper to install <expert-name>`
- `Experts: create a new expert for Shopify`
- `Ask Experts to update from the repo`

Harness-specific aliases such as `$experts`, `@experts`, or slash commands are optional adapter conveniences. Do not assume they work in every harness.

Do not require the user to remember or paste the GitHub URL again. The installed state records the URL, and the helper should use that URL to sync a fresh local cache before listing or installing experts. This is one shared helper per user environment, not a helper copied or specialized per expert.

## Remembered State

Start with:

1. `$HOME/.agents/knowledge/experts/install-state.env`
2. `$HOME/.agents/knowledge/experts/official-sources.md`
3. `$HOME/.agents/toolkits/experts/manifest.json`
4. `$HOME/.agents/toolkits/experts/adapter.md`
5. `EXPERTS_REPO_URL` as the source of truth.
6. `EXPERTS_REPO_CACHE` as the working checkout for current repo contents.
7. `EXPERTS_REPO_ROOT` only as a last-resort local development checkout when syncing the URL is unavailable.

## Core Workflow

1. Sync the Experts repo from its URL.
   - Treat `EXPERTS_REPO_URL` as canonical.
   - Use `EXPERTS_REPO_CACHE` as the normal working checkout.
   - If the cache exists, fetch from `EXPERTS_REPO_URL` and update the checked-out branch before listing, installing, or creating experts.
   - If the cache does not exist, clone `EXPERTS_REPO_URL` into `EXPERTS_REPO_CACHE`.
   - Use `EXPERTS_REPO_ROOT` only when the URL cannot be reached and the user accepts stale local contents.

2. Discover dynamically.
   - Use `./install.sh --list` for available experts.
   - Use the current synced repo contents as the source of truth.

3. Install experts directly when requested.
   - Run `./install.sh --expert <expert-name> --hydrate` by default, using the package name from the current repo.
   - If hydration fails because network access is unavailable, rerun without `--hydrate`.
   - Use `--all --hydrate` only when the user explicitly asks for every expert.
   - Tell the user to restart or reload the relevant agent harness if new skills or agents do not appear immediately.

4. Create experts through this repo.
   - Follow `templates/CREATE_EXPERT.md`.
   - Scaffold with `scripts/scaffold-expert.sh`.
   - Validate with `./install.sh --expert <expert-name> --dry-run`.
   - Validate the generated sync script with `bash -n`.
   - Do not assume publishing. Install locally unless the user asks for private/internal packaging, a commit, or a PR.

5. Update the local Experts checkout when requested.
   - Fetch or clone from `EXPERTS_REPO_URL` into `EXPERTS_REPO_CACHE`.
   - After updating, list experts if the user asks what changed or what is available.

## Command Semantics

Treat `Experts:` and similar natural-language phrases as the portable interface. Treat `$experts`, `@experts`, slash commands, or other routing tokens as harness-specific aliases, not as shell commands and not as universal syntax.

Suggested interpretations:

| User wording | Action |
| --- | --- |
| `Experts: list available experts` | Sync from `EXPERTS_REPO_URL`, then run `./install.sh --list`. |
| `Experts: install <name>` | Install the requested expert from the synced repo. |
| `Experts: install all` | Confirm the user means all experts, then run `./install.sh --all --hydrate`. |
| `Experts: create a new expert for <domain>` | Follow the repo's create-expert template. |
| `Experts: update from the repo` | Update the remembered checkout, then report the available experts if useful. |
| `Experts: where is the repo?` | Show the remembered repo root, cache path, and source URL. |

## Source Discipline

For project mechanics, use the synced checkout from `EXPERTS_REPO_URL` as the source of truth:

- `AGENTS.md`
- `README.md`
- `install.sh`
- `templates/CREATE_EXPERT.md`
- `templates/EXPERT_BLUEPRINT.md`
- `scripts/scaffold-expert.sh`
- `$HOME/.agents/toolkits/experts/manifest.json`
- `$HOME/.agents/toolkits/experts/adapter.md`

If synced repo files disagree with this helper skill, follow the synced repo files and mention the conflict.

## Response Style

Be direct and operational. Prefer doing the requested repo action over explaining the project. Summarize the exact expert names installed or created, whether hydration ran, and whether the user needs to restart their agent harness.
