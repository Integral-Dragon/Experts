# Firecracker Official Sources

This skill is pinned to the official Firecracker repository and homepage. Created against `firecracker-microvm/firecracker` main commit `d9c543d6c8ae529f510f9a049b990923548f76fb` on 2026-04-22.

Use live `main` when the user wants the current state. Use the pinned commit when repeatability matters.

## Roots

- Repository: `https://github.com/firecracker-microvm/firecracker`
- Docs tree: `https://github.com/firecracker-microvm/firecracker/tree/main/docs`
- Raw live root: `https://raw.githubusercontent.com/firecracker-microvm/firecracker/main/`
- Raw pinned root: `https://raw.githubusercontent.com/firecracker-microvm/firecracker/d9c543d6c8ae529f510f9a049b990923548f76fb/`
- Official homepage: `https://firecracker-microvm.github.io/`
- Local cache root: `$HOME/.agents/knowledge/firecracker/upstream/firecracker/`

## Primary Reading Order

- Mission and overview: `README.md`, `CHARTER.md`, `docs/design.md`
- Public API contract: `src/firecracker/swagger/firecracker.yaml`, then `docs/api_requests/*.md`
- Host setup and boot: `docs/getting-started.md`, `docs/rootfs-and-kernel-setup.md`, `docs/dev-machine-setup.md`, `docs/prod-host-setup.md`
- Isolation and security: `docs/jailer.md`, `docs/seccomp.md`, `docs/seccompiler.md`, `docs/kernel-policy.md`
- Runtime devices and integrations: `docs/network-setup.md`, `docs/vsock.md`, `docs/mmds/*.md`, `docs/pmem.md`, `docs/ballooning.md`
- Persistence and cloning: `docs/snapshotting/*.md`
- Internals and source truth: `src/vmm/`, `src/firecracker/src/api_server/`, `src/jailer/`, `resources/seccomp/`

## Topic Map

| Topic | Official paths |
| --- | --- |
| Overview and charter | `README.md`, `CHARTER.md`, `docs/design.md` |
| Getting started | `docs/getting-started.md`, `docs/rootfs-and-kernel-setup.md`, `docs/dev-machine-setup.md` |
| Production host setup | `docs/prod-host-setup.md`, `docs/kernel-policy.md`, `docs/hugepages.md` |
| API schema | `src/firecracker/swagger/firecracker.yaml` |
| API request examples | `docs/api_requests/actions.md`, `docs/api_requests/patch-block.md`, `docs/api_requests/patch-network-interface.md`, `docs/api_requests/block-caching.md`, `docs/api_requests/block-io-engine.md`, `docs/api_requests/block-vhost-user.md` |
| API evolution | `docs/api-change-runbook.md`, `docs/RELEASE_POLICY.md` |
| Jailer | `docs/jailer.md`, `src/jailer/` |
| Seccomp | `docs/seccomp.md`, `docs/seccompiler.md`, `resources/seccomp/`, `src/firecracker/src/seccomp.rs`, `src/vmm/src/seccomp.rs` |
| Boot, kernel, initrd, PVH | `docs/rootfs-and-kernel-setup.md`, `docs/initrd.md`, `docs/pvh.md`, `docs/kernel-policy.md` |
| CPU templates | `docs/cpu_templates/cpu-templates.md`, `docs/cpu_templates/cpu-template-helper.md`, `docs/cpu_templates/boot-protocol.md`, `docs/cpu_templates/cpuid-normalization.md`, `docs/cpu_templates/schema.json`, `src/vmm/src/cpu_config/` |
| Network | `docs/network-setup.md`, `docs/network-performance.md`, `docs/api_requests/patch-network-interface.md`, `src/vmm/src/devices/virtio/net/`, `src/vmm/src/dumbo/` |
| Vsock | `docs/vsock.md`, `src/vmm/src/devices/virtio/vsock/`, `tests/integration_tests/functional/test_vsock.py` |
| MMDS | `docs/mmds/mmds-design.md`, `docs/mmds/mmds-user-guide.md`, `src/vmm/src/mmds/` |
| Block storage | `docs/api_requests/patch-block.md`, `docs/api_requests/block-caching.md`, `docs/api_requests/block-io-engine.md`, `docs/api_requests/block-vhost-user.md`, `src/vmm/src/devices/virtio/block/` |
| Pmem | `docs/pmem.md`, `src/vmm/src/devices/virtio/pmem/` |
| Entropy | `docs/entropy.md`, `src/vmm/src/devices/virtio/rng/` |
| Ballooning | `docs/ballooning.md`, `src/vmm/src/devices/virtio/balloon/` |
| Memory hotplug | `docs/memory-hotplug.md`, `src/vmm/src/devices/virtio/mem/`, `src/vmm/src/vmm_config/memory_hotplug.rs` |
| Snapshotting | `docs/snapshotting/snapshot-support.md`, `docs/snapshotting/snapshot-editor.md`, `docs/snapshotting/versioning.md`, `docs/snapshotting/handling-page-faults-on-snapshot-resume.md`, `docs/snapshotting/network-for-clones.md`, `docs/snapshotting/random-for-clones.md`, `src/vmm/src/snapshot/`, `src/snapshot-editor/` |
| Observability | `docs/logger.md`, `docs/metrics.md`, `docs/tracing.md`, `docs/gdb-debugging.md`, `src/vmm/src/logger/` |
| Device API | `docs/device-api.md`, `src/vmm/src/devices/`, `src/vmm/src/device_manager/` |
| Formal verification and fuzzing | `docs/formal-verification.md`, `docs/fuzzing.md` |

## Complete Docs Manifest

Official GitHub URLs use this pattern:

- Web: `https://github.com/firecracker-microvm/firecracker/blob/main/<path>`
- Raw live: `https://raw.githubusercontent.com/firecracker-microvm/firecracker/main/<path>`
- Raw pinned: `https://raw.githubusercontent.com/firecracker-microvm/firecracker/d9c543d6c8ae529f510f9a049b990923548f76fb/<path>`

Docs and top-level references:

- `README.md`
- `CHARTER.md`
- `docs/RELEASE_POLICY.md`
- `docs/api-change-runbook.md`
- `docs/api_requests/actions.md`
- `docs/api_requests/block-caching.md`
- `docs/api_requests/block-io-engine.md`
- `docs/api_requests/block-vhost-user.md`
- `docs/api_requests/patch-block.md`
- `docs/api_requests/patch-network-interface.md`
- `docs/ballooning.md`
- `docs/cpu_templates/boot-protocol.md`
- `docs/cpu_templates/cpu-template-helper.md`
- `docs/cpu_templates/cpu-templates.md`
- `docs/cpu_templates/cpuid-normalization.md`
- `docs/cpu_templates/schema.json`
- `docs/design.md`
- `docs/dev-machine-setup.md`
- `docs/device-api.md`
- `docs/entropy.md`
- `docs/formal-verification.md`
- `docs/fuzzing.md`
- `docs/gdb-debugging.md`
- `docs/getting-started.md`
- `docs/hugepages.md`
- `docs/initrd.md`
- `docs/jailer.md`
- `docs/kernel-policy.md`
- `docs/logger.md`
- `docs/memory-hotplug.md`
- `docs/metrics.md`
- `docs/mmds/mmds-design.md`
- `docs/mmds/mmds-user-guide.md`
- `docs/network-performance.md`
- `docs/network-setup.md`
- `docs/pmem.md`
- `docs/prod-host-setup.md`
- `docs/pvh.md`
- `docs/rootfs-and-kernel-setup.md`
- `docs/seccomp.md`
- `docs/seccompiler.md`
- `docs/snapshotting/handling-page-faults-on-snapshot-resume.md`
- `docs/snapshotting/network-for-clones.md`
- `docs/snapshotting/random-for-clones.md`
- `docs/snapshotting/snapshot-editor.md`
- `docs/snapshotting/snapshot-support.md`
- `docs/snapshotting/versioning.md`
- `docs/tracing.md`
- `docs/vsock.md`

Official source anchors for details not fully covered in docs:

- `src/firecracker/swagger/firecracker.yaml`
- `src/firecracker/src/api_server/`
- `src/firecracker/src/seccomp.rs`
- `src/jailer/`
- `src/seccompiler/`
- `src/snapshot-editor/`
- `src/vmm/src/arch/`
- `src/vmm/src/builder.rs`
- `src/vmm/src/cpu_config/`
- `src/vmm/src/device_manager/`
- `src/vmm/src/devices/`
- `src/vmm/src/dumbo/`
- `src/vmm/src/initrd.rs`
- `src/vmm/src/io_uring/`
- `src/vmm/src/logger/`
- `src/vmm/src/mmds/`
- `src/vmm/src/resources.rs`
- `src/vmm/src/rpc_interface.rs`
- `src/vmm/src/seccomp.rs`
- `src/vmm/src/snapshot/`
- `src/vmm/src/vmm_config/`
- `src/vmm/src/vstate/`
- `resources/seccomp/`
- `tests/integration_tests/functional/`
- `tests/integration_tests/performance/`
- `tests/integration_tests/security/`

## Last-Resort External Source Rule

Only use non-Firecracker sources after checking the relevant official docs and, when appropriate, official source paths above. When doing this, explicitly say:

1. which official paths were checked,
2. why they were insufficient,
3. what external source is being used,
4. whether the conclusion is documented fact or inference.
