#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="$(cd "${script_dir}/.." && pwd)"
out="${1:-${knowledge_dir}/upstream/claude-code}"
tmp="$(mktemp -d)"

cleanup() {
  rm -rf "${tmp}"
}
trap cleanup EXIT

fetch() {
  local url="$1"
  local dest="$2"
  mkdir -p "$(dirname "${dest}")"
  curl -LfsS --retry 5 --retry-all-errors --retry-delay 2 "${url}" -o "${dest}"
}

fetch_optional() {
  local url="$1"
  local dest="$2"

  if ! fetch "${url}" "${dest}"; then
    echo "Warning: failed to fetch ${url}" >&2
    rm -f "${dest}"
  fi
}

safe_name() {
  printf '%s' "$1" | sed -E 's#https?://##; s#[^A-Za-z0-9._-]+#_#g; s#_+$##'
}

copy_selected_path() {
  local src_root="$1"
  local rel="$2"
  local dest_root="$3"

  if [[ -f "${src_root}/${rel}" ]]; then
    mkdir -p "${dest_root}/$(dirname "${rel}")"
    cp "${src_root}/${rel}" "${dest_root}/${rel}"
    return
  fi

  if [[ -d "${src_root}/${rel}" ]]; then
    (
      cd "${src_root}"
      find "${rel}" -type f \
        \( -name '*.md' -o -name '*.mdx' -o -name '*.txt' -o -name '*.json' -o -name '*.jsonc' -o -name '*.yaml' -o -name '*.yml' -o -name '*.toml' -o -name '*.js' -o -name '*.jsx' -o -name '*.ts' -o -name '*.tsx' -o -name '*.py' -o -name '*.sh' -o -name '*.ps1' -o -name '*.cmd' -o -name '*.html' \) \
        -not -path '*/node_modules/*' \
        -not -path '*/dist/*' \
        -not -path '*/build/*' \
        -not -path '*/.git/*' \
        -print
    ) | while IFS= read -r path; do
      mkdir -p "${dest_root}/$(dirname "${path}")"
      cp "${src_root}/${path}" "${dest_root}/${path}"
    done
  fi
}

repo_sha() {
  local repo="$1"
  local ref="$2"

  git ls-remote "https://github.com/${repo}.git" "${ref}" 2>/dev/null | awk '{print $1}' | head -n 1 || true
}

hydrate_github_repo() {
  local repo="$1"
  local ref="$2"
  shift 2

  local archive="${tmp}/$(safe_name "${repo}")-${ref}.tar.gz"
  local archive_url="https://github.com/${repo}/archive/${ref}.tar.gz"
  local src
  local path
  local repo_out="${out}/repos/${repo}"
  local sha

  fetch "${archive_url}" "${archive}"
  tar -xzf "${archive}" -C "${tmp}"
  src="$(find "${tmp}" -maxdepth 1 -type d -name "$(basename "${repo}")-*" | head -n 1)"

  if [[ -z "${src}" ]]; then
    echo "Could not find extracted source directory for ${repo}" >&2
    exit 1
  fi

  rm -rf "${repo_out}"
  mkdir -p "${repo_out}"
  for path in "$@"; do
    copy_selected_path "${src}" "${path}" "${repo_out}"
  done

  sha="$(repo_sha "${repo}" "${ref}")"
  {
    echo "repo=${repo}"
    echo "ref=${ref}"
    echo "sha=${sha:-unknown}"
    echo "archive=${archive_url}"
  } > "${repo_out}/SOURCE_REF"
}

official_roots=(
  "https://code.claude.com/docs/en/"
  "https://code.claude.com/llms.txt"
  "https://github.com/anthropics/claude-code"
  "https://github.com/anthropics/claude-code-action"
  "https://github.com/anthropics/claude-code-base-action"
  "https://github.com/anthropics/claude-plugins-official"
  "https://github.com/anthropics/skills"
)

docs_pages=(
  overview
  quickstart
  setup
  changelog
  cli-reference
  interactive-mode
  commands
  common-workflows
  best-practices
  how-claude-code-works
  tools-reference
  terminal-config
  keybindings
  statusline
  fullscreen
  memory
  claude-directory
  context-window
  settings
  env-vars
  model-config
  debug-your-config
  troubleshooting
  errors
  permission-modes
  permissions
  sandboxing
  security
  data-usage
  legal-and-compliance
  zero-data-retention
  network-config
  devcontainer
  authentication
  admin-setup
  server-managed-settings
  auto-mode-config
  features-overview
  skills
  sub-agents
  hooks
  hooks-guide
  mcp
  output-styles
  plugins
  plugins-reference
  plugin-marketplaces
  plugin-dependencies
  discover-plugins
  headless
  agent-sdk/overview
  agent-sdk/quickstart
  agent-sdk/typescript
  agent-sdk/typescript-v2-preview
  agent-sdk/python
  agent-sdk/sessions
  agent-sdk/permissions
  agent-sdk/hooks
  agent-sdk/mcp
  agent-sdk/subagents
  agent-sdk/skills
  agent-sdk/slash-commands
  agent-sdk/claude-code-features
  agent-sdk/custom-tools
  agent-sdk/user-input
  agent-sdk/structured-outputs
  agent-sdk/streaming-output
  agent-sdk/streaming-vs-single-mode
  agent-sdk/cost-tracking
  agent-sdk/observability
  agent-sdk/secure-deployment
  agent-sdk/hosting
  agent-sdk/file-checkpointing
  agent-sdk/modifying-system-prompts
  agent-sdk/plugins
  agent-sdk/tool-search
  agent-sdk/todo-tracking
  agent-sdk/migration-guide
  agent-sdk/agent-loop
  platforms
  vs-code
  jetbrains
  desktop
  desktop-quickstart
  desktop-scheduled-tasks
  claude-code-on-the-web
  web-quickstart
  remote-control
  chrome
  computer-use
  voice-dictation
  ultraplan
  ultrareview
  github-actions
  gitlab-ci-cd
  code-review
  slack
  channels
  channels-reference
  routines
  scheduled-tasks
  agent-teams
  analytics
  monitoring-usage
  costs
  amazon-bedrock
  google-vertex-ai
  microsoft-foundry
  llm-gateway
  third-party-integrations
  whats-new/index
  whats-new/2026-w13
  whats-new/2026-w14
  whats-new/2026-w15
)

rm -rf "${out}"
mkdir -p "${out}/docs" "${out}/repos"

printf '%s\n' "${official_roots[@]}" > "${out}/official-roots.txt"
fetch "https://code.claude.com/llms.txt" "${out}/llms.txt"

for page in "${docs_pages[@]}"; do
  fetch_optional "https://code.claude.com/docs/en/${page}.md" "${out}/docs/${page}.md"
done

hydrate_github_repo "anthropics/claude-code" "${CLAUDE_CODE_REF:-main}" \
  README.md \
  CHANGELOG.md \
  SECURITY.md \
  LICENSE.md \
  LICENSE \
  package.json \
  .claude \
  .claude-plugin \
  examples \
  plugins \
  scripts \
  Script \
  src

hydrate_github_repo "anthropics/claude-code-action" "${CLAUDE_CODE_ACTION_REF:-main}" \
  README.md \
  action.yml \
  package.json \
  src \
  scripts \
  examples \
  docs

hydrate_github_repo "anthropics/claude-code-base-action" "${CLAUDE_CODE_BASE_ACTION_REF:-main}" \
  README.md \
  action.yml \
  package.json \
  src \
  scripts \
  examples \
  docs

hydrate_github_repo "anthropics/claude-plugins-official" "${CLAUDE_PLUGINS_REF:-main}" \
  README.md \
  .claude-plugin \
  plugins \
  external_plugins

hydrate_github_repo "anthropics/skills" "${ANTHROPIC_SKILLS_REF:-main}" \
  README.md \
  skills \
  examples

{
  echo "expert=claude-code-principal-engineer"
  echo "domain=claude-code"
  echo "docs_root=https://code.claude.com/docs/en/"
  echo "docs_index=https://code.claude.com/llms.txt"
  echo "claude_code_repo=anthropics/claude-code"
  echo "claude_code_ref=${CLAUDE_CODE_REF:-main}"
  echo "claude_code_sha=$(repo_sha "anthropics/claude-code" "${CLAUDE_CODE_REF:-main}")"
  echo "claude_code_action_repo=anthropics/claude-code-action"
  echo "claude_code_action_ref=${CLAUDE_CODE_ACTION_REF:-main}"
  echo "claude_code_action_sha=$(repo_sha "anthropics/claude-code-action" "${CLAUDE_CODE_ACTION_REF:-main}")"
  echo "claude_code_base_action_repo=anthropics/claude-code-base-action"
  echo "claude_code_base_action_ref=${CLAUDE_CODE_BASE_ACTION_REF:-main}"
  echo "claude_code_base_action_sha=$(repo_sha "anthropics/claude-code-base-action" "${CLAUDE_CODE_BASE_ACTION_REF:-main}")"
  echo "claude_plugins_repo=anthropics/claude-plugins-official"
  echo "claude_plugins_ref=${CLAUDE_PLUGINS_REF:-main}"
  echo "claude_plugins_sha=$(repo_sha "anthropics/claude-plugins-official" "${CLAUDE_PLUGINS_REF:-main}")"
  echo "anthropic_skills_repo=anthropics/skills"
  echo "anthropic_skills_ref=${ANTHROPIC_SKILLS_REF:-main}"
  echo "anthropic_skills_sha=$(repo_sha "anthropics/skills" "${ANTHROPIC_SKILLS_REF:-main}")"
  printf 'docs_pages='
  printf '%s ' "${docs_pages[@]}"
  printf '\n'
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "${out}/SOURCE_REF"

echo "Hydrated official Claude Code docs into ${out}"
