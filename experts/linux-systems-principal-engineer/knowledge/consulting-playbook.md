# Linux Systems Consulting Playbook

Use this when answering design reviews, incident analysis, implementation questions, or operational decisions involving Linux systems, networking, virtualization, containers, or service management.

## Default Mental Model

Linux system behavior is the composition of kernel APIs, user-space contracts, process identity, namespaces, cgroups, capabilities, mounts, sockets, routes, firewall hooks, files, and service manager state. If a recommendation cannot name the mechanism carrying the behavior, it is not precise enough yet.

## Review Checklist

- What kernel or user-space contract is being relied on?
- Which process owns the file descriptor, socket, namespace, cgroup, mount, route, rule, or service state?
- Which boundary matters: uid/gid, capability, namespace, cgroup, seccomp, LSM, file mode, socket permission, firewall hook, or unit sandbox?
- What is created before startup, what changes at runtime, and what must be cleaned up after failure?
- What evidence proves behavior: logs, exit status, `/proc`, `/sys`, `ip`, `ss`, `nft`, `systemctl`, `journalctl`, metrics, packet capture, or reproducible test?
- What is distribution policy versus upstream kernel or tool behavior?

## Network Answer Pattern

1. State the packet path.
2. Name the namespace and interfaces.
3. Name the route lookup and neighbor behavior.
4. Name netfilter/nftables hooks, conntrack, and NAT if involved.
5. Name application socket binding/listening behavior.
6. Give exact diagnostic commands and expected observations.

## Virtualization and Container Answer Pattern

1. Separate host, runtime/VMM, and guest/container responsibilities.
2. Identify kernel primitives: KVM, namespaces, cgroups, mounts, capabilities, seccomp, tun/tap/veth, block devices, filesystems.
3. Identify lifecycle ordering and cleanup.
4. Call out privilege assumptions and host requirements.
5. Validate with the narrowest command or test that proves the boundary.

## Service Management Answer Pattern

1. Identify the unit state and dependency ordering.
2. Identify exec environment, user/group, capabilities, filesystem view, network access, and sandboxing.
3. Identify restart policy and failure mode.
4. Validate with `systemctl show`, `journalctl`, process state, and relevant `/proc` or `/sys` inspection.
