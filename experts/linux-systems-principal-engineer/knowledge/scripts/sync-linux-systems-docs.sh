#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
knowledge_dir="$(cd "${script_dir}/.." && pwd)"
out="${1:-${knowledge_dir}/upstream/linux-systems}"

fetch() {
  local url="$1"
  local dest="$2"
  mkdir -p "$(dirname "${out}/${dest}")"
  curl -LfsS --retry 5 --retry-all-errors --retry-delay 2 "${url}" -o "${out}/${dest}"
}

ref_for() {
  local label="$1"
  local repo="$2"
  local ref="${3:-HEAD}"
  local sha
  sha="$(git ls-remote "${repo}" "${ref}" 2>/dev/null | awk '{print $1}' | head -n 1 || true)"
  echo "${label}=${sha:-unknown} ${repo} ${ref}"
}

rm -rf "${out}"
mkdir -p "${out}"

while IFS='|' read -r url dest; do
  [[ -z "${url}" || "${url}" == \#* ]] && continue
  fetch "${url}" "${dest}"
done <<'EOF'
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/README.rst|kernel/Documentation/admin-guide/README.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/kernel-parameters.rst|kernel/Documentation/admin-guide/kernel-parameters.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/cgroup-v2.rst|kernel/Documentation/admin-guide/cgroup-v2.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/sysctl/net.rst|kernel/Documentation/admin-guide/sysctl/net.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/networking/tuntap.rst|kernel/Documentation/networking/tuntap.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/networking/netdevices.rst|kernel/Documentation/networking/netdevices.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/networking/ip-sysctl.rst|kernel/Documentation/networking/ip-sysctl.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/networking/bridge.rst|kernel/Documentation/networking/bridge.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/virt/kvm/api.rst|kernel/Documentation/virt/kvm/api.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/virt/kvm/devices/vm.rst|kernel/Documentation/virt/kvm/devices/vm.rst
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man2/clone.2|man-pages/man2/clone.2
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man2/unshare.2|man-pages/man2/unshare.2
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man2/setns.2|man-pages/man2/setns.2
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/namespaces.7|man-pages/man7/namespaces.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/network_namespaces.7|man-pages/man7/network_namespaces.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/user_namespaces.7|man-pages/man7/user_namespaces.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/mount_namespaces.7|man-pages/man7/mount_namespaces.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/pid_namespaces.7|man-pages/man7/pid_namespaces.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/cgroups.7|man-pages/man7/cgroups.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/capabilities.7|man-pages/man7/capabilities.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/socket.7|man-pages/man7/socket.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/unix.7|man-pages/man7/unix.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/packet.7|man-pages/man7/packet.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/netlink.7|man-pages/man7/netlink.7
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/plain/man/man7/rtnetlink.7|man-pages/man7/rtnetlink.7
https://www.debian.org/doc/manuals/debian-reference/|debian/debian-reference-index.html
https://www.debian.org/doc/manuals/debian-reference/ch01.en.html|debian/debian-reference-ch01.html
https://www.debian.org/doc/manuals/debian-reference/ch02.en.html|debian/debian-reference-ch02.html
https://www.debian.org/doc/manuals/debian-reference/ch03.en.html|debian/debian-reference-ch03.html
https://www.debian.org/doc/manuals/debian-reference/ch05.en.html|debian/debian-reference-ch05.html
https://www.debian.org/doc/manuals/debian-reference/ch06.en.html|debian/debian-reference-ch06.html
https://www.debian.org/doc/debian-policy/|debian/debian-policy-index.html
https://raw.githubusercontent.com/systemd/systemd/main/man/systemd.unit.xml|systemd/man/systemd.unit.xml
https://raw.githubusercontent.com/systemd/systemd/main/man/systemd.service.xml|systemd/man/systemd.service.xml
https://raw.githubusercontent.com/systemd/systemd/main/man/systemd.exec.xml|systemd/man/systemd.exec.xml
https://raw.githubusercontent.com/systemd/systemd/main/man/systemctl.xml|systemd/man/systemctl.xml
https://raw.githubusercontent.com/systemd/systemd/main/man/systemd.network.xml|systemd/man/systemd.network.xml
https://raw.githubusercontent.com/systemd/systemd/main/man/systemd.netdev.xml|systemd/man/systemd.netdev.xml
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/man/man8/ip.8|iproute2/man/man8/ip.8
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/man/man8/ip-link.8.in|iproute2/man/man8/ip-link.8.in
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/man/man8/ip-netns.8.in|iproute2/man/man8/ip-netns.8.in
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/man/man8/ip-route.8.in|iproute2/man/man8/ip-route.8.in
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/man/man8/bridge.8|iproute2/man/man8/bridge.8
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/man/man8/tc.8|iproute2/man/man8/tc.8
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/man/man8/ss.8|iproute2/man/man8/ss.8
https://git.netfilter.org/nftables/plain/doc/nft.txt|nftables/doc/nft.txt
https://git.netfilter.org/nftables/plain/doc/statements.txt|nftables/doc/statements.txt
https://git.netfilter.org/nftables/plain/doc/libnftables-json.adoc|nftables/doc/libnftables-json.adoc
https://www.qemu.org/docs/master/system/invocation.html|qemu/system/invocation.html
https://www.qemu.org/docs/master/system/devices/net.html|qemu/system/devices/net.html
https://www.qemu.org/docs/master/system/target-i386.html|qemu/system/target-i386.html
https://raw.githubusercontent.com/opencontainers/runtime-spec/main/config.md|oci-runtime-spec/config.md
https://raw.githubusercontent.com/opencontainers/runtime-spec/main/config-linux.md|oci-runtime-spec/config-linux.md
https://raw.githubusercontent.com/opencontainers/runtime-spec/main/runtime.md|oci-runtime-spec/runtime.md
EOF

{
  ref_for "linux_kernel_head" "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
  ref_for "man_pages_head" "https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git"
  ref_for "iproute2_head" "https://git.kernel.org/pub/scm/network/iproute2/iproute2.git"
  ref_for "nftables_head" "https://git.netfilter.org/nftables"
  ref_for "systemd_main" "https://github.com/systemd/systemd.git" "refs/heads/main"
  ref_for "qemu_master" "https://gitlab.com/qemu-project/qemu.git" "refs/heads/master"
  ref_for "oci_runtime_spec_main" "https://github.com/opencontainers/runtime-spec.git" "refs/heads/main"
  echo "debian_docs=https://www.debian.org/doc/"
  date -u '+synced_at=%Y-%m-%dT%H:%M:%SZ'
} > "${out}/SOURCE_REF"

echo "Hydrated official Linux systems docs into ${out}"
