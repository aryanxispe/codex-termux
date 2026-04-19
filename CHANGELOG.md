# [0.121.0-termux] - 2026-04-16

### Upstream
- OpenAI Codex `rust-v0.121.0` release: https://github.com/openai/codex/releases/tag/rust-v0.121.0
- Fork line rebased on upstream `0.121.0` from the public stable branch `origin/main`.

### Termux Patches
- Kept Android browser login via `termux-open-url`.
- Kept the fork update channel and `-termux` version parsing for self-update UX.
- Kept Termux npm package/update commands targeting `@mmmbuto/codex-cli-termux`.
- Kept launcher hardening via wrapped entrypoints and `CODEX_SELF_EXE`.
- Kept Android ELF `RUNPATH=$ORIGIN` hardening so direct native invocation still resolves bundled `libc++_shared.so`.
- Kept the Android no-voice policy for the published Termux package.
- Kept the Android `openpty` shim for PTY compatibility on Bionic.
- Carried forward the Android `installation_id` lock tolerance for unsupported file locks on Termux.

### Build and Release
- Added a maintainer-oriented `BUILDING.md` for native Termux and Linux-host Android builds.
- Added fork-owned `rusty_v8` Android artifact manifest and fetch helpers.
- Added a dispatchable GitHub Actions workflow to cross-build and pack the Termux npm package with prebuilt Android `rusty_v8`.

### Version
- npm package target: `@mmmbuto/codex-cli-termux@0.121.0-termux`
- Upstream base: `rust-v0.121.0`

### Verification
- `bash verify-patches.sh`
- local native Termux build and npm wrapper smoke remain the final gate on this branch

# [0.120.0-termux] - 2026-04-11

### Upstream
- OpenAI Codex `rust-v0.120.0` release: https://github.com/openai/codex/releases/tag/rust-v0.120.0
- Fork line rebuilt cleanly from upstream stable instead of extending the old public fork history.

### Termux Patches
- Kept Android browser login via `termux-open-url`.
- Kept the fork update channel and `-termux` version parsing for self-update UX.
- Kept Termux npm package/update commands targeting `@mmmbuto/codex-cli-termux`.
- Kept launcher hardening via wrapped entrypoints and `CODEX_SELF_EXE`.
- Included the Android ELF `RUNPATH=$ORIGIN` hardening from fork PR #1 so direct native invocation still resolves bundled `libc++_shared.so`.
- Kept the Android no-voice policy for the published Termux package.
- Kept the Android `openpty` shim for PTY compatibility on Bionic.
- Dropped the old Android `network-proxy` stub because upstream now compiles directly on Android through the Unix-family path.
- Fixed Android session bootstrap after the upstream `installation_id` locking change by tolerating unsupported file locks on Termux.

### Version
- npm package target: `@mmmbuto/codex-cli-termux@0.120.0-termux`
- Upstream base: `rust-v0.120.0`

### Verification
- `bash verify-patches.sh`
- Release packaging smoke for `codex`, `codex-exec`, and wrapper routing
- Native Termux validation remains a post-release manual gate
