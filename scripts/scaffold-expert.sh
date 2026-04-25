#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target_root="${repo_root}"
expert=""
domain=""
display_name=""
summary=""
brand_color="#2563EB"
dry_run=false
force=false
sources=()

usage() {
  cat <<'EOF'
Usage:
  scripts/scaffold-expert.sh --domain <name> --display-name <name> --summary <text> [--source URL ...]

Options:
  --domain NAME          Domain slug or plain-language name. Example: shopify, vscode-developers.
  --expert NAME          Full expert name. Defaults to <domain>-principal-engineer.
  --display-name NAME    Human display name. Example: Shopify Principal Engineer.
  --summary TEXT         One-sentence expert summary for agent manifests.
  --source URL           Official docs, repo, spec, or authoritative source root. May repeat.
  --brand-color HEX      UI color for OpenAI skill metadata. Default: #2563EB.
  --root DIR             Scaffold under DIR instead of this repo root. Useful for tests.
  --force                Overwrite existing scaffold files.
  --dry-run              Print actions without writing files.
  -h, --help             Show this help.
EOF
}

log() {
  printf '%s\n' "$*"
}

require_value() {
  local option="$1"
  if [[ $# -lt 2 || -z "${2:-}" ]]; then
    log "${option} requires a value" >&2
    exit 1
  fi
}

slugify() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g'
}

titleize_slug() {
  printf '%s' "$1" \
    | sed -E 's/-/ /g' \
    | awk '{ for (i = 1; i <= NF; i++) { $i = toupper(substr($i,1,1)) substr($i,2) } print }'
}

write_file() {
  local path="$1"
  if "${dry_run}"; then
    log "[dry-run] write ${path}"
    cat > /dev/null
  else
    mkdir -p "$(dirname "${path}")"
    cat > "${path}"
  fi
}

shell_quote_array() {
  local source
  for source in "${sources[@]}"; do
    printf '  %q\n' "${source}"
  done
}

markdown_sources() {
  local source
  if [[ ${#sources[@]} -eq 0 ]]; then
    printf '%s\n' "- Add official docs, source repos, specs, or authoritative project docs before publishing."
  else
    for source in "${sources[@]}"; do
      printf '%s\n' "- ${source}"
    done
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --domain)
      require_value "$@"
      domain="$(slugify "$2")"
      shift 2
      ;;
    --expert)
      require_value "$@"
      expert="$(slugify "$2")"
      shift 2
      ;;
    --display-name)
      require_value "$@"
      display_name="$2"
      shift 2
      ;;
    --summary)
      require_value "$@"
      summary="$2"
      shift 2
      ;;
    --source)
      require_value "$@"
      sources+=("$2")
      shift 2
      ;;
    --brand-color)
      require_value "$@"
      brand_color="$2"
      shift 2
      ;;
    --root)
      require_value "$@"
      target_root="$2"
      shift 2
      ;;
    --force)
      force=true
      shift
      ;;
    --dry-run)
      dry_run=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      log "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "${domain}" && -n "${expert}" ]]; then
  domain="${expert%-principal-engineer}"
fi

if [[ -z "${domain}" ]]; then
  log "--domain is required unless --expert is provided" >&2
  usage >&2
  exit 1
fi

if [[ -z "${expert}" ]]; then
  expert="${domain}-principal-engineer"
fi

if [[ -z "${display_name}" ]]; then
  display_name="$(titleize_slug "${domain}") Principal Engineer"
fi

if [[ -z "${summary}" ]]; then
  summary="Official-source ${display_name} expert."
fi

subject_name="${display_name% Principal Engineer}"
expert_dir="${target_root}/experts/${expert}"
script_name="sync-${domain}-docs.sh"
sources_md="$(markdown_sources)"
sources_sh="$(shell_quote_array)"

if [[ -e "${expert_dir}" && "${force}" != true ]]; then
  log "Expert already exists: ${expert_dir}" >&2
  log "Use --force only when you intentionally want to overwrite scaffold files." >&2
  exit 1
fi

log "Scaffolding ${expert} under ${expert_dir}"

write_file "${expert_dir}/skill/SKILL.md" <<EOF
---
name: ${expert}
description: Use when analyzing, designing, debugging, reviewing, operating, or teaching ${subject_name} topics from official or user-approved authoritative sources.
---

# ${display_name}

## Role

Act with the judgment, precision, and product depth of a principal engineer for ${subject_name}. Deliver expert guidance without claiming private employment history, personal authorship, or non-public knowledge.

## Source Discipline

Use official or user-approved authoritative sources first:

1. Local hydrated docs if present: \`\$HOME/.agents/knowledge/${domain}/upstream/${domain}/\`.
2. Official source manifest: \`\$HOME/.agents/knowledge/${domain}/official-sources.md\`.
3. Official roots selected for this expert:

${sources_md}

If those sources do not answer the question, say what you checked and clearly label any external or inferred information.

## Workflow

1. Identify the active surface area and user goal.
2. Read the source manifest for relevant official paths.
3. Prefer cached hydrated docs; hydrate or fetch official sources only when needed.
4. Separate documented behavior, source-derived inference, local observations, recommendations, and uncertainty.
5. Cite official paths or URLs for concrete claims.

## Engineering Stance

- Keep advice traceable to official docs, source code, specifications, or user-approved project material.
- Be conservative with security, compatibility, migration, and production-operation claims.
- Prefer small reproducible checks and minimal examples over broad assertions.
- When reviewing code, map recommendations back to the domain's documented contracts and invariants.

## Response Style

Lead with the answer or recommendation. Then give the source basis, constraints, risks, and validation steps. Be direct, technical, and opinionated when the sources support it.
EOF

write_file "${expert_dir}/skill/agents/openai.yaml" <<EOF
interface:
  display_name: "${display_name}"
  short_description: "${summary}"
  default_prompt: "Use \$${expert} for ${subject_name} questions from official or user-approved authoritative sources."
  brand_color: "${brand_color}"

policy:
  allow_implicit_invocation: true
EOF

write_file "${expert_dir}/knowledge/official-sources.md" <<EOF
# ${display_name} Official Sources

Complete this manifest before publishing the expert. Use live sources for current questions and pin a repeatable commit, version, or release when repeatability matters.

## Roots

${sources_md}
- Local cache root: \`\$HOME/.agents/knowledge/${domain}/upstream/${domain}/\`

## Primary Reading Order

- Overview and concepts: add official getting-started, overview, architecture, or README paths.
- Public contracts: add API references, schemas, CLI docs, protocol specs, or configuration references.
- Operations and production use: add deployment, security, migration, performance, and troubleshooting docs.
- Source truth: add official source paths for implementation details that docs do not fully cover.

## Topic Map

| Topic | Official paths |
| --- | --- |
| Overview | Add official overview paths |
| Public API or user-facing contract | Add official reference paths |
| Configuration and runtime behavior | Add official config/runtime paths |
| Security and production operations | Add official security/ops paths |
| Source-derived internals | Add official source paths |

## Complete Manifest

List the exact official docs, source files, specs, schemas, and examples the expert should consult. Keep this as an index; do not paste large upstream docs here.

## Last-Resort External Source Rule

Only use non-official or non-authoritative sources after checking the relevant official paths. When doing this, explicitly state what was checked, why it was insufficient, what external source is being used, and whether the conclusion is documented fact or inference.
EOF

write_file "${expert_dir}/knowledge/consulting-playbook.md" <<EOF
# ${display_name} Consulting Playbook

## Default Mental Model

- Start from the user's concrete surface area and goal.
- Ground claims in official docs, official source, official specs, or user-approved authoritative material.
- Keep cached upstream docs as a reference library, not as initial prompt bulk.

## Review Checklist

- Are source claims backed by official paths?
- Are version-sensitive claims tied to a live source, pinned source, or local observation?
- Are documented behavior and implementation inference clearly separated?
- Are operational risks, compatibility boundaries, and validation steps explicit?

## Answer Pattern

1. Recommendation or direct answer.
2. Source basis.
3. Constraints and failure modes.
4. Concrete validation or next steps.
EOF

write_file "${expert_dir}/knowledge/scripts/${script_name}" <<EOF
#!/usr/bin/env bash
set -euo pipefail

script_dir="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="\$(cd "\${script_dir}/.." && pwd)"
out="\${1:-\${knowledge_dir}/upstream/${domain}}"
tmp="\$(mktemp -d)"

cleanup() {
  rm -rf "\${tmp}"
}
trap cleanup EXIT

# Curate this list while creating the expert. Avoid broad web crawling.
official_roots=(
${sources_sh}
)

# For GitHub repos, copy only useful docs/source-reference paths from archives.
github_doc_paths=(
  README.md
  README.rst
  docs
  doc
  website
)

safe_name() {
  printf '%s' "\$1" | sed -E 's#https?://##; s#[^A-Za-z0-9._-]+#_#g; s#_+\$##'
}

hydrate_github_repo() {
  local repo="\$1"
  local ref="\${2:-main}"
  local archive="\${tmp}/\$(safe_name "\${repo}")-\${ref}.tar.gz"
  local archive_url="https://github.com/\${repo}/archive/\${ref}.tar.gz"
  local src
  local path

  curl -LfsS "\${archive_url}" -o "\${archive}"
  tar -xzf "\${archive}" -C "\${tmp}"
  src="\$(find "\${tmp}" -maxdepth 1 -type d -name "\$(basename "\${repo}")-*" | head -n 1)"

  if [[ -z "\${src}" ]]; then
    echo "Could not find extracted source directory for \${repo}" >&2
    return 1
  fi

  mkdir -p "\${out}/repos/\${repo}"
  for path in "\${github_doc_paths[@]}"; do
    if [[ -e "\${src}/\${path}" ]]; then
      mkdir -p "\${out}/repos/\${repo}/\$(dirname "\${path}")"
      cp -R "\${src}/\${path}" "\${out}/repos/\${repo}/\${path}"
    fi
  done

  git ls-remote "https://github.com/\${repo}.git" "\${ref}" | awk '{print \$1}' > "\${out}/repos/\${repo}/SOURCE_SHA" || true
}

rm -rf "\${out}"
mkdir -p "\${out}/pages"

printf '%s\n' "\${official_roots[@]}" > "\${out}/official-roots.txt"

for root in "\${official_roots[@]}"; do
  if [[ "\${root}" =~ ^https://github\\.com/([^/]+/[^/#?]+)(/)?([#?].*)?\$ ]]; then
    repo="\${BASH_REMATCH[1]%.git}"
    hydrate_github_repo "\${repo}" "\${EXPERT_REF:-main}"
  elif [[ "\${root}" =~ ^https?:// ]]; then
    curl -LfsS "\${root}" -o "\${out}/pages/\$(safe_name "\${root}").html" || {
      echo "Warning: could not fetch \${root}" >&2
    }
  fi
done

{
  echo "expert=${expert}"
  echo "domain=${domain}"
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "\${out}/SOURCE_REF"

echo "Hydrated official ${subject_name} references into \${out}"
EOF

write_file "${expert_dir}/agents/codex/${expert}.toml.template" <<EOF
name = "${expert}"
description = "${summary}"
model = "gpt-5.5"
model_reasoning_effort = "high"
sandbox_mode = "read-only"
developer_instructions = """
You are ${display_name}: a specialist persona with the technical judgment, precision, and design ownership expected from a principal engineer for ${subject_name}.

Deliver the expertise and directness of that role, but do not falsely claim private employment history, personal authorship, or non-public knowledge. Ground factual claims in official public sources or user-approved authoritative project material.

Start with:
1. \$HOME/.agents/knowledge/${domain}/official-sources.md
2. \$HOME/.agents/knowledge/${domain}/upstream/${domain}/

For every answer:
1. Classify the topic and user goal.
2. Load only the relevant official docs/source paths.
3. Prefer documented behavior; label source-derived inference.
4. Cite official file paths or URLs for concrete claims.
5. Separate documented facts, local observations, recommendations, and uncertainty.

Be direct, technical, and opinionated when the sources support it.
"""

[[skills.config]]
path = "{{HOME}}/.agents/skills/${expert}/SKILL.md"
enabled = true
EOF

write_file "${expert_dir}/agents/claude/${expert}.md" <<EOF
---
name: ${expert}
description: MUST BE USED for ${subject_name} questions, reviews, debugging, architecture, operations, and source-grounded guidance.
---

You are ${display_name}: a specialist persona with the technical judgment, precision, and design ownership expected from a principal engineer for ${subject_name}.

Deliver the expertise and directness of that role, but do not falsely claim private employment history, personal authorship, or non-public knowledge. Ground factual claims in official public sources or user-approved authoritative project material.

## Source of Truth

Start with:

1. If present, read \`\$HOME/.agents/knowledge/${domain}/official-sources.md\`.
2. If present, prefer hydrated official docs under \`\$HOME/.agents/knowledge/${domain}/upstream/${domain}/\`.
3. Use only official or user-approved authoritative sources listed in the manifest unless explicitly labeling last-resort context.

## Operating Procedure

1. Classify the topic and user goal.
2. Load only the relevant official docs/source paths.
3. Prefer documented behavior; label source-derived inference.
4. Cite official file paths or URLs for concrete claims.
5. Separate documented facts, local observations, recommendations, and uncertainty.

## Response Shape

Lead with the answer or recommendation. Then give the source basis, constraints, failure modes, and validation steps. Be direct, technical, and opinionated when the sources support it.
EOF

if "${dry_run}"; then
  log "[dry-run] chmod +x ${expert_dir}/knowledge/scripts/${script_name}"
else
  chmod +x "${expert_dir}/knowledge/scripts/${script_name}"
fi

log "Next:"
log "1. Edit ${expert_dir}/knowledge/official-sources.md with curated topic paths."
log "2. Customize ${expert_dir}/knowledge/scripts/${script_name} for the official docs corpus."
log "3. Run ./install.sh --expert ${expert} --dry-run"
