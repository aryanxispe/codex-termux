# Codex CLI for Termux

> Android Termux package built from upstream OpenAI Codex `rust-v0.121.0`.

This package publishes the latest Termux-focused line as `@mmmbuto/codex-cli-termux`.

## Install

```bash
pkg update && pkg upgrade -y
pkg install nodejs-lts -y
npm install -g @mmmbuto/codex-cli-termux@latest
codex --version
codex login
```

## Notes

- Android Termux ARM64 only
- Built from upstream `rust-v0.121.0`
- Carries only the Termux compatibility delta needed for packaging and runtime
- Voice and realtime audio stay disabled in the published Termux line
- Packaged launchers preserve bundled `libc++_shared.so` visibility
- Android ELFs are hardened with `RUNPATH=$ORIGIN`
- Fork-owned Android `rusty_v8` prebuilds are used for maintainer cross-builds
- Maintainer publish path is the repository GitHub Actions workflow on `main`

See the main repository for release notes and patch inventory:

- https://github.com/DioNanos/codex-termux
- https://github.com/DioNanos/codex-termux/blob/main/patches/README.md
