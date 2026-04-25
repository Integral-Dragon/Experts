# Create A New Expert

Use this when a user says:

```text
Create a new expert for <domain>
```

Your job is to turn the request into a complete expert package that follows this repo's pattern.

## Creation Flow

1. Clarify only what is needed.
   - If the domain is broad, ask what scope matters most.
   - If it is a custom project or framework, ask for the official repo and docs path.
   - If official sources are unclear, propose likely official sources and ask for confirmation.

2. Define the expert contract.
   - Expert name: `<domain>-principal-engineer`
   - Knowledge domain: `<domain>`
   - Primary users: Codex, Claude, and other coding-agent harnesses
   - Source policy: official docs, official source repos, official specs, and user-provided authoritative project docs

3. Discover official sources.
   - Prefer official documentation roots and official GitHub/GitLab/source repos.
   - For standards or ecosystems, prefer standards bodies, canonical specs, and primary implementation repos.
   - For custom frameworks, treat the user-provided repo/docs as authoritative.
   - Do not use third-party tutorials, blogs, Stack Overflow, or mirrors as source of truth unless the user explicitly allows them. If used, label them as last-resort context.

4. Scaffold the package:

```bash
scripts/scaffold-expert.sh \
  --domain <domain> \
  --display-name "<Display Name> Principal Engineer" \
  --summary "Official-source <domain> expert for <short scope>." \
  --source <official-doc-or-repo-url>
```

Add `--source` more than once for multiple official roots.

5. Finish the generated files.
   - Replace generic topic placeholders in `knowledge/official-sources.md`.
   - Customize `knowledge/scripts/sync-<domain>-docs.sh` so `--hydrate` fetches the relevant official docs/source files without broad crawling.
   - Tighten `skill/SKILL.md`, `agents/codex/*.toml.template`, and `agents/claude/*.md` around the exact domain.
   - Update the README Expert Index.

6. Validate:

```bash
./install.sh --expert <expert-name> --dry-run
bash -n experts/<expert-name>/knowledge/scripts/sync-<domain>-docs.sh
```

When practical, test hydration into a temporary home:

```bash
./install.sh --expert <expert-name> --hydrate --home /tmp/experts-home-test
```

## Useful Questions

Ask the smallest useful question. Good prompts:

- "Should this expert cover the whole platform or only the app/API/framework surface?"
- "Which repo, docs site, or spec should be treated as authoritative?"
- "Should examples and recipes count as official source material, or only reference docs and source code?"
- "For this custom framework, which branch or release should the expert pin as its repeatable baseline?"

## Done Means

- The package installs with `install.sh`.
- Hydration fetches only official or user-approved authoritative sources.
- The skill uses progressive disclosure and does not embed a large documentation dump.
- The README index includes the new expert.
- Concrete claims in the expert instructions distinguish documented facts, source-derived inference, local observations, and uncertainty.
