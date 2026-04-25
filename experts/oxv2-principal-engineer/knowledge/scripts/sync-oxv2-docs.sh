#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="$(cd "${script_dir}/.." && pwd)"
out="${1:-${knowledge_dir}/upstream/oxv2}"
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

safe_name() {
  printf '%s' "$1" | sed -E 's#https?://##; s#[^A-Za-z0-9._-]+#_#g; s#_+$##'
}

repo_sha() {
  local repo="$1"
  local ref="$2"

  git ls-remote "https://github.com/${repo}.git" "${ref}" 2>/dev/null | awk '{print $1}' | head -n 1 || true
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
        \( -name '*.md' -o -name '*.txt' -o -name '*.toml' -o -name '*.lock' -o -name '*.json' -o -name '*.jsonl' -o -name '*.yaml' -o -name '*.yml' -o -name '*.rs' -o -name '*.sh' -o -name '*.html' -o -name '*.css' -o -name 'Makefile' \) \
        -not -path '*/target/*' \
        -not -path '*/.git/*' \
        -not -path '*/node_modules/*' \
        -not -path '*/dist/*' \
        -not -path '*/build/*' \
        -print
    ) | while IFS= read -r path; do
      mkdir -p "${dest_root}/$(dirname "${path}")"
      cp "${src_root}/${path}" "${dest_root}/${path}"
    done
  fi
}

hydrate_repo() {
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

oxv2_repo="${OXV2_REPO:-Integral-Dragon/oxv2}"
oxv2_ref="${OXV2_REF:-main}"
seguro_repo="${SEGURO_REPO:-dragon-panic/seguro}"
seguro_ref="${SEGURO_REF:-main}"
complex_repo="${COMPLEX_REPO:-dragon-panic/complex}"
complex_ref="${COMPLEX_REF:-main}"

rm -rf "${out}"
mkdir -p "${out}/repos"

official_roots=(
  "https://github.com/${oxv2_repo}"
  "https://github.com/${seguro_repo}"
  "https://github.com/${complex_repo}"
)
printf '%s\n' "${official_roots[@]}" > "${out}/official-roots.txt"

hydrate_repo "${oxv2_repo}" "${oxv2_ref}" \
  README.md \
  CONTRIBUTING.md \
  Cargo.toml \
  Cargo.lock \
  Makefile \
  docs \
  defaults \
  site \
  ox-core \
  ox-server \
  ox-herder \
  ox-runner \
  ox-ctl \
  ox-cx-watcher \
  ox-rt

hydrate_repo "${seguro_repo}" "${seguro_ref}" \
  README.md \
  CLAUDE.md \
  Cargo.toml \
  docs \
  scripts \
  demo \
  src \
  tests

hydrate_repo "${complex_repo}" "${complex_ref}" \
  README.md \
  AGENT.md \
  CLAUDE.md \
  CONTRIBUTING.md \
  Cargo.toml \
  Cargo.lock \
  LICENSE \
  docs \
  src \
  tests

{
  echo "expert=oxv2-principal-engineer"
  echo "domain=oxv2"
  echo "oxv2_repo=${oxv2_repo}"
  echo "oxv2_ref=${oxv2_ref}"
  echo "oxv2_sha=$(repo_sha "${oxv2_repo}" "${oxv2_ref}")"
  echo "seguro_repo=${seguro_repo}"
  echo "seguro_ref=${seguro_ref}"
  echo "seguro_sha=$(repo_sha "${seguro_repo}" "${seguro_ref}")"
  echo "complex_repo=${complex_repo}"
  echo "complex_ref=${complex_ref}"
  echo "complex_sha=$(repo_sha "${complex_repo}" "${complex_ref}")"
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "${out}/SOURCE_REF"

echo "Hydrated oxv2, seguro, and complex sources into ${out}"
