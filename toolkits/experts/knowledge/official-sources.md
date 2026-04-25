# Experts Helper Sources

This helper exists to remember and operate the Experts project after it has been installed once.

## Official Project

- Repository URL: `https://github.com/Integral-Dragon/Experts`
- Installed state: `$HOME/.agents/knowledge/experts/install-state.env`
- Source of truth: value of `EXPERTS_REPO_URL`
- Working checkout: value of `EXPERTS_REPO_CACHE`
- Last-resort development checkout: value of `EXPERTS_REPO_ROOT`

## Local Source Of Truth

Use these files from the synced checkout:

- `AGENTS.md`
- `README.md`
- `install.sh`
- `templates/CREATE_EXPERT.md`
- `templates/EXPERT_BLUEPRINT.md`
- `scripts/scaffold-expert.sh`

## Dynamic Expert Discovery

Available experts are discovered by running:

```bash
./install.sh --list
```

Expert packages are expected to change over time.

Before listing, installing, or creating experts, sync the working checkout from `EXPERTS_REPO_URL`. The cache is only an execution location, not the authority.
