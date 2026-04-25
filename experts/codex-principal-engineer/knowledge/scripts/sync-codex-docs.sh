#!/usr/bin/env bash
set -euo pipefail

repo="${CODEX_REPO:-openai/codex}"
ref="${CODEX_REF:-main}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="$(cd "${script_dir}/.." && pwd)"
out="${1:-${knowledge_dir}/upstream/codex}"
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

copy_selected_tree() {
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
        \( -name '*.md' -o -name '*.rs' -o -name '*.toml' -o -name '*.json' -o -name '*.yaml' -o -name '*.yml' -o -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.py' \) \
        -not -path '*/target/*' \
        -not -path '*/node_modules/*' \
        -print
    ) | while IFS= read -r path; do
      mkdir -p "${dest_root}/$(dirname "${path}")"
      cp "${src_root}/${path}" "${dest_root}/${path}"
    done
  fi
}

archive_url="https://github.com/${repo}/archive/${ref}.tar.gz"
archive="${tmp}/codex.tar.gz"

rm -rf "${out}"
mkdir -p "${out}/github/openai-codex" "${out}/developers.openai.com"

fetch "${archive_url}" "${archive}"
tar -xzf "${archive}" -C "${tmp}"
src="$(find "${tmp}" -maxdepth 1 -type d -name 'codex-*' | head -n 1)"

if [[ -z "${src}" ]]; then
  echo "Could not find extracted Codex source directory" >&2
  exit 1
fi

repo_out="${out}/github/openai-codex"
for path in \
  README.md \
  CHANGELOG.md \
  SECURITY.md \
  AGENTS.md \
  package.json \
  docs \
  .codex/skills \
  codex-rs/README.md \
  codex-rs/config.md \
  codex-rs/docs \
  codex-rs/agent-identity \
  codex-rs/chatgpt \
  codex-rs/cli \
  codex-rs/codex-mcp \
  codex-rs/collaboration-mode-templates \
  codex-rs/config \
  codex-rs/core \
  codex-rs/core-plugins \
  codex-rs/core-skills \
  codex-rs/device-key \
  codex-rs/execpolicy \
  codex-rs/execpolicy-legacy \
  codex-rs/hooks \
  codex-rs/linux-sandbox \
  codex-rs/login \
  codex-rs/mcp-server \
  codex-rs/model-provider-info \
  codex-rs/model-provider \
  codex-rs/models-manager \
  codex-rs/plugin \
  codex-rs/process-hardening \
  codex-rs/protocol \
  codex-rs/rmcp-client \
  codex-rs/sandboxing \
  codex-rs/shell-command \
  codex-rs/shell-escalation \
  codex-rs/skills \
  codex-rs/state \
  codex-rs/thread-store \
  codex-rs/tools \
  codex-rs/tui \
  codex-rs/windows-sandbox-rs \
  sdk
do
  copy_selected_tree "${src}" "${path}" "${repo_out}"
done

pages=(
  codex
  codex/quickstart
  codex/cli
  codex/cli/features
  codex/cli/reference
  codex/cli/slash-commands
  codex/auth
  codex/models
  codex/pricing
  codex/agent-approvals-security
  codex/concepts/customization
  codex/concepts/sandboxing
  codex/concepts/subagents
  codex/config-basic
  codex/config-advanced
  codex/config-reference
  codex/config-sample
  codex/guides/agents-md
  codex/guides/agents-sdk
  codex/mcp
  codex/rules
  codex/skills
  codex/plugins
  codex/plugins/build
  codex/subagents
  codex/noninteractive
  codex/hooks
  codex/memories
  codex/memories/chronicle
  codex/prompting
  codex/workflows
  codex/speed
  codex/security
  codex/security/setup
  codex/security/faq
  codex/security/threat-model
  codex/ide
  codex/ide/features
  codex/ide/settings
  codex/ide/commands
  codex/ide/slash-commands
  codex/app
  codex/app/features
  codex/app/settings
  codex/app/commands
  codex/app/local-environments
  codex/app/worktrees
  codex/cloud
  codex/cloud/environments
  codex/cloud/internet-access
  codex/github-action
  codex/sdk
  codex/open-source
  codex/feature-maturity
  cookbook/examples/gpt-5/codex_prompting_guide
)

docs_out="${out}/developers.openai.com"
for page in "${pages[@]}"; do
  url="https://developers.openai.com/${page}.md"
  dest="${docs_out}/${page}.md"
  if ! fetch "${url}" "${dest}"; then
    echo "Warning: failed to fetch ${url}" >&2
    rm -f "${dest}"
  fi
done

sha="$(git ls-remote "https://github.com/${repo}.git" "${ref}" 2>/dev/null | awk '{print $1}' | head -n 1 || true)"
{
  echo "repo=${repo}"
  echo "ref=${ref}"
  echo "sha=${sha:-unknown}"
  echo "archive=${archive_url}"
  echo "developer_docs_root=https://developers.openai.com/codex"
  printf 'developer_docs_pages='
  printf '%s ' "${pages[@]}"
  printf '\n'
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "${out}/SOURCE_REF"

echo "Hydrated official Codex docs into ${out}"
