#!/usr/bin/env bash
# Experts marketplace bootstrap.
#
# Registers this repo as a Claude Code plugin marketplace. After that, manage
# experts with native Claude Code commands:
#
#   claude plugin list
#   claude plugin install <name>@experts
#   claude plugin enable  <name>@experts
#   claude plugin disable <name>@experts
#   claude plugin uninstall <name>@experts
#
# Plugins install disabled by default. Turn on what you want, when you want.
#
# Usage:
#   ./install.sh                  Register the marketplace.
#   ./install.sh --install-all    Register, then install every expert (disabled).
#   ./install.sh --list           List available experts in this marketplace.
#   ./install.sh -h | --help      Show this help.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
marketplace_name="experts"
private_root="${repo_root}/plugins-private"
private_marketplace_name="experts-private"

action="register"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-all) action="install-all"; shift ;;
    --list)        action="list";        shift ;;
    -h|--help)
      sed -n '2,17p' "${BASH_SOURCE[0]}" | sed 's/^# \?//'
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

if ! command -v claude >/dev/null 2>&1; then
  echo "claude CLI not found in PATH." >&2
  exit 1
fi

list_marketplace() {
  local manifest="$1"
  python3 -c "
import json
m = json.load(open('${manifest}'))
for p in m['plugins']:
    print(p['name'])
"
}

list_experts() {
  list_marketplace "${repo_root}/.claude-plugin/marketplace.json"
  if [[ -f "${private_root}/.claude-plugin/marketplace.json" ]]; then
    list_marketplace "${private_root}/.claude-plugin/marketplace.json"
  fi
}

if [[ "${action}" == "list" ]]; then
  list_experts
  exit 0
fi

register_marketplace() {
  local name="$1" path="$2"
  if claude plugin marketplace list 2>/dev/null | grep -q "^${name}\b"; then
    echo "Marketplace '${name}' already registered. Updating from source."
    claude plugin marketplace update "${name}"
  else
    claude plugin marketplace add "${path}"
  fi
}

register_marketplace "${marketplace_name}" "${repo_root}"

# If a sibling plugins-private/ marketplace exists, register it too. This is
# the local-only side for plugins that reference private repos and should not
# be pushed to the public Experts repo.
if [[ -f "${private_root}/.claude-plugin/marketplace.json" ]]; then
  echo
  register_marketplace "${private_marketplace_name}" "${private_root}"
fi

if [[ "${action}" == "install-all" ]]; then
  echo
  echo "Installing all experts (disabled by default)."

  install_one() {
    local name="$1" mp="$2"
    claude plugin install "${name}@${mp}" || true
    # claude plugin install enables by default; flip them off so the default
    # experience is "installed and ready, but off until you turn one on".
    claude plugin disable "${name}@${mp}" >/dev/null 2>&1 || true
  }

  while IFS= read -r name; do
    echo
    install_one "${name}" "${marketplace_name}"
  done < <(list_marketplace "${repo_root}/.claude-plugin/marketplace.json")

  if [[ -f "${private_root}/.claude-plugin/marketplace.json" ]]; then
    while IFS= read -r name; do
      echo
      install_one "${name}" "${private_marketplace_name}"
    done < <(list_marketplace "${private_root}/.claude-plugin/marketplace.json")
  fi
fi

cat <<EOF

Done.

Manage experts with native Claude Code commands:

  claude plugin list
  claude plugin install <name>@${marketplace_name}
  claude plugin enable  <name>@${marketplace_name}
  claude plugin disable <name>@${marketplace_name}

Plugins are disabled by default after install. Restart Claude Code (or open a
new session) for enable/disable changes to take effect.
EOF
