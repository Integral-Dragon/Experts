#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
home_dir="${HOME}"
install_all=false
hydrate=false
dry_run=false
install_codex=true
install_claude=true
install_experts_toolkit=true
experts_toolkit_only=false
selected=()

usage() {
  cat <<'EOF'
Usage:
  ./install.sh --all [--hydrate]
  ./install.sh --expert <name> [--expert <name>] [--hydrate]
  ./install.sh --experts-toolkit-only

Options:
  --all            Install every expert in this repo.
  --expert NAME    Install one expert. May be repeated.
  --hydrate        Fetch official upstream docs after installing manifests/scripts.
  --with-experts-toolkit
                   Install the reusable $experts helper skill and agents. This is the default.
  --no-experts-toolkit
                   Skip the reusable $experts helper skill and agents.
  --experts-toolkit-only
                   Install only the reusable $experts helper skill and agents.
  --list           List available experts.
  --home DIR       Install into DIR instead of $HOME. Useful for tests.
  --no-codex       Skip Codex custom-agent installation.
  --no-claude      Skip Claude agent installation.
  --dry-run        Print actions without writing files.
  -h, --help       Show this help.
EOF
}

available_experts() {
  find "${repo_root}/experts" -mindepth 3 -maxdepth 3 -type f -path '*/skill/SKILL.md' \
    | sed -E "s#${repo_root}/experts/([^/]+)/skill/SKILL.md#\1#" \
    | sort
}

log() {
  printf '%s\n' "$*"
}

run() {
  if "${dry_run}"; then
    printf '[dry-run] %q' "$1"
    shift || true
    for arg in "$@"; do
      printf ' %q' "$arg"
    done
    printf '\n'
  else
    "$@"
  fi
}

copy_tree_contents() {
  local src="$1"
  local dest="$2"
  if [[ ! -d "${src}" ]]; then
    log "Missing source directory: ${src}" >&2
    exit 1
  fi
  log "Copy ${src} -> ${dest}"
  if "${dry_run}"; then
    log "[dry-run] mkdir -p ${dest}"
    log "[dry-run] cp -R ${src}/. ${dest}/"
  else
    mkdir -p "${dest}"
    cp -R "${src}/." "${dest}/"
  fi
}

render_template() {
  local src="$1"
  local dest="$2"
  local escaped_home
  escaped_home="$(printf '%s' "${home_dir}" | sed 's/[&|]/\\&/g')"
  log "Render ${src} -> ${dest}"
  if "${dry_run}"; then
    log "[dry-run] mkdir -p $(dirname "${dest}")"
    log "[dry-run] replace {{HOME}} with ${home_dir}"
  else
    mkdir -p "$(dirname "${dest}")"
    sed "s|{{HOME}}|${escaped_home}|g" "${src}" > "${dest}"
  fi
}

write_experts_toolkit_state() {
  local dest="${home_dir}/.agents/knowledge/experts/install-state.env"
  local repo_url="${EXPERTS_REPO_URL:-https://github.com/Integral-Dragon/Experts}"

  log "Write Experts toolkit state -> ${dest}"
  if "${dry_run}"; then
    log "[dry-run] mkdir -p $(dirname "${dest}")"
    log "[dry-run] write repo_root=${repo_root}, repo_url=${repo_url}"
  else
    mkdir -p "$(dirname "${dest}")"
    {
      printf 'EXPERTS_REPO_ROOT=%q\n' "${repo_root}"
      printf 'EXPERTS_REPO_URL=%q\n' "${repo_url}"
      printf 'EXPERTS_REPO_CACHE=%q\n' "${home_dir}/.agents/repos/Experts"
    } > "${dest}"
  fi
}

install_experts_helper() {
  local src="${repo_root}/toolkits/experts"

  if [[ ! -f "${src}/skill/SKILL.md" ]]; then
    log "Missing Experts toolkit package: ${src}" >&2
    exit 1
  fi

  copy_tree_contents "${src}/skill" "${home_dir}/.agents/skills/experts"
  copy_tree_contents "${src}/knowledge" "${home_dir}/.agents/knowledge/experts"
  write_experts_toolkit_state

  if "${install_codex}"; then
    local template="${src}/agents/codex/experts.toml.template"
    if [[ -f "${template}" ]]; then
      render_template "${template}" "${home_dir}/.codex/agents/experts.toml"
    else
      log "No Codex template for Experts toolkit; skipping"
    fi
  fi

  if "${install_claude}"; then
    local claude_agent="${src}/agents/claude/experts.md"
    if [[ -f "${claude_agent}" ]]; then
      copy_tree_contents "$(dirname "${claude_agent}")" "${home_dir}/.claude/agents"
    else
      log "No Claude agent for Experts toolkit; skipping"
    fi
  fi
}

install_expert() {
  local expert="$1"
  local src="${repo_root}/experts/${expert}"

  if [[ ! -f "${src}/skill/SKILL.md" ]]; then
    log "Unknown expert: ${expert}" >&2
    log "Available experts:" >&2
    available_experts >&2
    exit 1
  fi

  local domain="${expert%-principal-engineer}"
  copy_tree_contents "${src}/skill" "${home_dir}/.agents/skills/${expert}"
  copy_tree_contents "${src}/knowledge" "${home_dir}/.agents/knowledge/${domain}"

  if "${install_codex}"; then
    local template="${src}/agents/codex/${expert}.toml.template"
    if [[ -f "${template}" ]]; then
      render_template "${template}" "${home_dir}/.codex/agents/${expert}.toml"
    else
      log "No Codex template for ${expert}; skipping"
    fi
  fi

  if "${install_claude}"; then
    local claude_agent="${src}/agents/claude/${expert}.md"
    if [[ -f "${claude_agent}" ]]; then
      copy_tree_contents "$(dirname "${claude_agent}")" "${home_dir}/.claude/agents"
    else
      log "No Claude agent for ${expert}; skipping"
    fi
  fi

  if "${hydrate}"; then
    local scripts_dir="${home_dir}/.agents/knowledge/${domain}/scripts"
    local sync_script
    sync_script="$(find "${scripts_dir}" -maxdepth 1 -type f -name 'sync-*.sh' | sort | head -n 1 || true)"
    if [[ -z "${sync_script}" ]]; then
      log "No sync script found for ${expert}; skipping hydration"
    elif "${dry_run}"; then
      log "[dry-run] ${sync_script}"
    else
      chmod +x "${sync_script}"
      "${sync_script}"
    fi
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all)
      install_all=true
      shift
      ;;
    --expert)
      if [[ $# -lt 2 ]]; then
        log "--expert requires a name" >&2
        exit 1
      fi
      selected+=("$2")
      shift 2
      ;;
    --hydrate)
      hydrate=true
      shift
      ;;
    --with-experts-toolkit)
      install_experts_toolkit=true
      shift
      ;;
    --no-experts-toolkit)
      install_experts_toolkit=false
      shift
      ;;
    --experts-toolkit-only)
      experts_toolkit_only=true
      install_experts_toolkit=true
      shift
      ;;
    --list)
      available_experts
      exit 0
      ;;
    --home)
      if [[ $# -lt 2 ]]; then
        log "--home requires a directory" >&2
        exit 1
      fi
      home_dir="$2"
      shift 2
      ;;
    --no-codex)
      install_codex=false
      shift
      ;;
    --no-claude)
      install_claude=false
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

if "${install_all}"; then
  mapfile -t selected < <(available_experts)
fi

if [[ ${#selected[@]} -eq 0 && "${experts_toolkit_only}" != true ]]; then
  log "No expert selected. Use --all or --expert <name>." >&2
  usage >&2
  exit 1
fi

if [[ "${experts_toolkit_only}" != true ]]; then
  for expert in "${selected[@]}"; do
    install_expert "${expert}"
  done
fi

if "${install_experts_toolkit}"; then
  install_experts_helper
fi

log 'Installation complete. Restart Codex or Claude if a running session does not show new experts or the $experts helper.'
