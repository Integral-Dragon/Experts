#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="$(cd "${script_dir}/.." && pwd)"
out="${1:-${knowledge_dir}/upstream/hermes-agent}"
tmp="$(mktemp -d)"

cleanup() {
  rm -rf "${tmp}"
}
trap cleanup EXIT

repo="NousResearch/hermes-agent"
ref="${EXPERT_REF:-main}"
archive="${tmp}/hermes-agent-${ref}.tar.gz"
src=""

official_roots=(
  "https://hermes-agent.nousresearch.com/"
  "https://hermes-agent.nousresearch.com/docs"
  "https://github.com/NousResearch/hermes-agent"
)

page_urls=(
  "https://hermes-agent.nousresearch.com/"
  "https://hermes-agent.nousresearch.com/docs"
)

repo_paths=(
  README.md
  AGENTS.md
  CONTRIBUTING.md
  SECURITY.md
  LICENSE
  .env.example
  cli-config.yaml.example
  pyproject.toml
  hermes
  cli.py
  hermes_constants.py
  hermes_state.py
  model_tools.py
  website/docs
  website/src
  website/static
  website/docusaurus.config.ts
  website/sidebars.ts
  hermes_cli
  agent
  gateway
  tui_gateway
  ui-tui/README.md
  ui-tui/src
  ui-tui/package.json
  ui-tui/vitest.config.ts
  web
  tools
  plugins
  skills
  optional-skills
  cron
  environments
  acp_adapter
  acp_registry
  tests
)

safe_name() {
  printf '%s' "$1" | sed -E 's#https?://##; s#[^A-Za-z0-9._-]+#_#g; s#_+$##'
}

copy_path() {
  local rel="$1"
  local source="${src}/${rel}"
  local dest="${out}/repos/${repo}/${rel}"

  if [[ -e "${source}" ]]; then
    mkdir -p "$(dirname "${dest}")"
    cp -R "${source}" "${dest}"
  fi
}

rm -rf "${out}"
mkdir -p "${out}/pages" "${out}/repos/${repo}"

printf '%s\n' "${official_roots[@]}" > "${out}/official-roots.txt"

for url in "${page_urls[@]}"; do
  curl -LfsS "${url}" -o "${out}/pages/$(safe_name "${url}").html" || {
    echo "Warning: could not fetch ${url}" >&2
  }
done

curl -LfsS "https://github.com/${repo}/archive/${ref}.tar.gz" -o "${archive}"
tar -xzf "${archive}" -C "${tmp}"
src="$(find "${tmp}" -maxdepth 1 -type d -name "hermes-agent-*" | head -n 1)"

if [[ -z "${src}" ]]; then
  echo "Could not find extracted source directory for ${repo}" >&2
  exit 1
fi

for path in "${repo_paths[@]}"; do
  copy_path "${path}"
done

find "${src}" -maxdepth 1 -type f -name 'RELEASE_v*.md' -print | while read -r release_file; do
  copy_path "$(basename "${release_file}")"
done

git ls-remote "https://github.com/${repo}.git" "${ref}" | awk '{print $1}' > "${out}/repos/${repo}/SOURCE_SHA" || true

{
  echo "expert=hermes-agent-principal-engineer"
  echo "domain=hermes-agent"
  echo "repo=${repo}"
  echo "ref=${ref}"
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "${out}/SOURCE_REF"

echo "Hydrated official Hermes Agent references into ${out}"
