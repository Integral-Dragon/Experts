# Linux Systems Official Sources

This skill uses official upstream and vendor documentation for Linux systems, KVM, networking, containers, Debian administration, and host operations. Created on 2026-04-22.

Use live upstream sources when the user wants the current state. Use the local hydrated cache when repeatability or offline lookup matters.

## Roots

- Linux kernel docs/source: `https://docs.kernel.org/`, `https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/`
- Linux man-pages project: `https://www.kernel.org/doc/man-pages/`, `https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/`
- Debian documentation: `https://www.debian.org/doc/`
- systemd upstream docs/source: `https://www.freedesktop.org/software/systemd/man/`, `https://github.com/systemd/systemd`
- iproute2 upstream source: `https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/`
- nftables upstream docs/source: `https://git.netfilter.org/nftables/`, `https://wiki.nftables.org/`
- QEMU docs/source: `https://www.qemu.org/docs/master/`, `https://gitlab.com/qemu-project/qemu`
- Open Container Initiative runtime spec: `https://github.com/opencontainers/runtime-spec`
- Local cache root: `$HOME/.agents/knowledge/linux-systems/upstream/linux-systems/`

## Primary Reading Order

- Kernel and KVM contracts: Linux kernel `Documentation/`, especially KVM, networking, cgroup, sysctl, and admin-guide files.
- Syscall and user-space ABI semantics: Linux man-pages project.
- Distribution operation: Debian Reference and Debian Policy.
- Service management and sandboxing: systemd manual pages and upstream man XML.
- Network operations: iproute2 manual pages, kernel networking docs, nftables docs.
- Virtualization: kernel KVM docs plus QEMU docs for user-space VMM/device behavior.
- Containers: kernel namespace/cgroup/capability docs plus OCI runtime spec for runtime configuration semantics.

## Topic Map

| Topic | Official paths |
| --- | --- |
| KVM userspace API | Linux kernel `Documentation/virt/kvm/api.rst`, `Documentation/virt/kvm/devices/vm.rst` |
| Kernel administration | Linux kernel `Documentation/admin-guide/README.rst`, `Documentation/admin-guide/kernel-parameters.rst`, `Documentation/admin-guide/sysctl/` |
| Cgroups | Linux kernel `Documentation/admin-guide/cgroup-v2.rst`, man-pages `cgroups(7)` |
| Namespaces | man-pages `namespaces(7)`, `network_namespaces(7)`, `user_namespaces(7)`, `mount_namespaces(7)`, `pid_namespaces(7)`, `clone(2)`, `unshare(2)`, `setns(2)` |
| Capabilities and privilege | man-pages `capabilities(7)`, systemd `systemd.exec`, kernel admin docs |
| Sockets and netlink | man-pages `socket(7)`, `unix(7)`, `packet(7)`, `netlink(7)`, `rtnetlink(7)` |
| Network devices and tun/tap | Linux kernel `Documentation/networking/tuntap.rst`, `netdevices.rst`, `bridge.rst` |
| Routing and sysctls | Linux kernel `Documentation/networking/ip-sysctl.rst`, `Documentation/admin-guide/sysctl/net.rst`, iproute2 `ip-route.8.in` |
| iproute2 operations | iproute2 `ip.8`, `ip-link.8.in`, `ip-netns.8.in`, `ip-route.8.in`, `bridge.8`, `tc.8`, `ss.8` |
| nftables/netfilter | nftables `doc/nft.txt`, `doc/statements.txt`, `doc/libnftables-json.adoc` |
| systemd units and services | systemd `systemd.unit`, `systemd.service`, `systemd.exec`, `systemctl`, `systemd.network`, `systemd.netdev` |
| Debian administration | Debian Reference, Debian Policy, Debian installation/admin docs from `debian.org/doc` |
| QEMU/KVM operation | QEMU system manual, invocation, targets, device and networking docs |
| OCI containers | OCI runtime spec `config.md`, `config-linux.md`, `runtime.md` |

## Hydrated Cache Layout

The sync script stores official files under:

- `references/upstream/linux-systems/kernel/`
- `references/upstream/linux-systems/man-pages/`
- `references/upstream/linux-systems/debian/`
- `references/upstream/linux-systems/systemd/`
- `references/upstream/linux-systems/iproute2/`
- `references/upstream/linux-systems/nftables/`
- `references/upstream/linux-systems/qemu/`
- `references/upstream/linux-systems/oci-runtime-spec/`

Each hydrated cache includes `SOURCE_REF` with upstream refs and sync time.

## Last-Resort External Source Rule

Only use non-official sources after checking the relevant official docs and, when appropriate, official source paths above. When doing this, explicitly say:

1. which official paths were checked,
2. why they were insufficient,
3. what external source is being used,
4. whether the conclusion is documented fact or inference.
