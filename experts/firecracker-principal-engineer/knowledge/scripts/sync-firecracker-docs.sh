#!/usr/bin/env bash
set -euo pipefail

repo="${FIRECRACKER_REPO:-firecracker-microvm/firecracker}"
ref="${FIRECRACKER_REF:-main}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="$(cd "${script_dir}/.." && pwd)"
out="${1:-${knowledge_dir}/upstream/firecracker}"
tmp="$(mktemp -d)"

cleanup() {
  rm -rf "${tmp}"
}
trap cleanup EXIT

archive_url="https://github.com/${repo}/archive/${ref}.tar.gz"
archive="${tmp}/firecracker.tar.gz"

curl -LfsS "${archive_url}" -o "${archive}"
tar -xzf "${archive}" -C "${tmp}"
src="$(find "${tmp}" -maxdepth 1 -type d -name 'firecracker-*' | head -n 1)"

if [[ -z "${src}" ]]; then
  echo "Could not find extracted Firecracker source directory" >&2
  exit 1
fi

rm -rf "${out}"
mkdir -p "${out}"

(
  cd "${src}"
  find README.md CHARTER.md docs src/firecracker/swagger resources/seccomp \
    -type f \( -name '*.md' -o -name '*.json' -o -name '*.yaml' -o -name '*.yml' -o -name '*.drawio' \) \
    -print
) | while IFS= read -r path; do
  mkdir -p "${out}/$(dirname "${path}")"
  cp "${src}/${path}" "${out}/${path}"
done

sha="$(git ls-remote "https://github.com/${repo}.git" "${ref}" | awk '{print $1}' | head -n 1 || true)"
{
  echo "repo=${repo}"
  echo "ref=${ref}"
  echo "sha=${sha:-unknown}"
  echo "archive=${archive_url}"
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "${out}/SOURCE_REF"

echo "Hydrated official Firecracker docs into ${out}"
