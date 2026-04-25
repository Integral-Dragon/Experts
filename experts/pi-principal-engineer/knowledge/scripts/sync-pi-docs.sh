#!/usr/bin/env bash
set -euo pipefail

repo="${PI_REPO:-badlogic/pi-mono}"
ref="${PI_REF:-main}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="$(cd "${script_dir}/.." && pwd)"
out="${1:-${knowledge_dir}/upstream/pi}"
tmp="$(mktemp -d)"

cleanup() {
  rm -rf "${tmp}"
}
trap cleanup EXIT

safe_name() {
  printf '%s' "$1" | sed -E 's#https?://##; s#[^A-Za-z0-9._-]+#_#g; s#_+$##'
}

fetch_page() {
  local url="$1"
  local dest="$2"

  mkdir -p "$(dirname "${dest}")"
  curl -LfsS "${url}" -o "${dest}" || {
    echo "Warning: could not fetch ${url}" >&2
  }
}

copy_path() {
  local src_root="$1"
  local rel="$2"
  local dest_root="$3"

  if [[ -e "${src_root}/${rel}" ]]; then
    mkdir -p "${dest_root}/$(dirname "${rel}")"
    cp -R "${src_root}/${rel}" "${dest_root}/${rel}"
  fi
}

archive_url="https://github.com/${repo}/archive/${ref}.tar.gz"
archive="${tmp}/pi-mono.tar.gz"

curl -LfsS "${archive_url}" -o "${archive}"
tar -xzf "${archive}" -C "${tmp}"
src="$(find "${tmp}" -maxdepth 1 -type d -name 'pi-mono-*' | head -n 1)"

if [[ -z "${src}" ]]; then
  echo "Could not find extracted Pi source directory" >&2
  exit 1
fi

rm -rf "${out}"
mkdir -p "${out}/landing" "${out}/npm" "${out}/repo"

official_roots=(
  "https://pi.dev/"
  "https://pi.dev/packages"
  "https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent"
  "https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent/docs"
  "https://www.npmjs.com/package/@mariozechner/pi-coding-agent"
  "https://registry.npmjs.org/@mariozechner%2Fpi-coding-agent"
  "https://mariozechner.at/posts/2025-11-30-pi-coding-agent/"
  "https://mariozechner.at/posts/2025-11-02-what-if-you-dont-need-mcp/"
)

printf '%s\n' "${official_roots[@]}" > "${out}/official-roots.txt"

fetch_page "https://pi.dev/" "${out}/landing/pi.dev.html"
fetch_page "https://pi.dev/packages" "${out}/landing/pi.dev_packages.html"
fetch_page "https://mariozechner.at/posts/2025-11-30-pi-coding-agent/" "${out}/landing/maintainer-pi-coding-agent.html"
fetch_page "https://mariozechner.at/posts/2025-11-02-what-if-you-dont-need-mcp/" "${out}/landing/maintainer-no-mcp.html"
curl -LfsS "https://registry.npmjs.org/@mariozechner%2Fpi-coding-agent/latest" -o "${out}/npm/pi-coding-agent.latest.json"

curated_paths=(
  "README.md"
  "AGENTS.md"
  "CONTRIBUTING.md"
  "LICENSE"
  "package.json"
  "package-lock.json"
  "tsconfig.base.json"
  "tsconfig.json"
  "biome.json"
  ".pi/extensions"
  ".pi/prompts"
  "packages/coding-agent/README.md"
  "packages/coding-agent/CHANGELOG.md"
  "packages/coding-agent/package.json"
  "packages/coding-agent/docs"
  "packages/coding-agent/examples"
  "packages/coding-agent/src"
  "packages/coding-agent/test"
  "packages/coding-agent/tsconfig.build.json"
  "packages/coding-agent/tsconfig.examples.json"
  "packages/coding-agent/vitest.config.ts"
  "packages/agent/README.md"
  "packages/agent/CHANGELOG.md"
  "packages/agent/package.json"
  "packages/agent/src"
  "packages/agent/test"
  "packages/ai/README.md"
  "packages/ai/CHANGELOG.md"
  "packages/ai/package.json"
  "packages/ai/src"
  "packages/ai/test"
  "packages/tui/README.md"
  "packages/tui/CHANGELOG.md"
  "packages/tui/package.json"
  "packages/tui/src"
  "packages/tui/test"
)

for path in "${curated_paths[@]}"; do
  copy_path "${src}" "${path}" "${out}/repo"
done

sha="$(git ls-remote "https://github.com/${repo}.git" "${ref}" | awk '{print $1}' | head -n 1 || true)"
npm_version="$(node -e 'const fs=require("fs"); const p=JSON.parse(fs.readFileSync(process.argv[1],"utf8")); console.log(p.version || "unknown")' "${out}/npm/pi-coding-agent.latest.json" 2>/dev/null || true)"

{
  echo "expert=pi-principal-engineer"
  echo "domain=pi"
  echo "repo=${repo}"
  echo "ref=${ref}"
  echo "sha=${sha:-unknown}"
  echo "archive=${archive_url}"
  echo "npm_package=@mariozechner/pi-coding-agent"
  echo "npm_version=${npm_version:-unknown}"
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "${out}/SOURCE_REF"

echo "Hydrated official Pi docs into ${out}"
