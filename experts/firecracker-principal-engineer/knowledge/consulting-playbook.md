# Firecracker Consulting Playbook

Use this when answering design reviews, implementation questions, or integration work.

## Default Mental Model

Firecracker is a minimal VMM around KVM. Its core value is a narrow guest-visible device model, fast microVM lifecycle, and operational predictability for multi-tenant container/function workloads. Most integration complexity belongs on the host side, not hidden in the guest.

## Review Checklist

- What is the Firecracker API state being changed: pre-boot configuration, runtime operation, snapshot/restore, or teardown?
- What host primitive is required: KVM, tap, routing/NAT, file ownership, cgroup, namespace, chroot, seccomp, socket path, kernel/rootfs/initrd?
- What is guest-visible: virtio-net, block, vsock, MMDS, entropy, balloon/mem, serial, boot args?
- What must be created before `InstanceStart`, and what can be patched afterward?
- What privilege boundary is assumed before and after jailer/seccomp setup?
- What cleanup must happen if Firecracker starts, fails halfway, or exits unexpectedly?
- What metrics/logs/errors prove the behavior?

## Answer Pattern

1. Recommendation.
2. Official source basis: docs/code paths checked.
3. Constraints and failure modes.
4. Concrete command/API/file shape where useful.
5. Local validation plan.
