# Codex Termux

> Native Codex CLI for **Termux / Android ARM64**.
> Built from upstream OpenAI Codex `rust-v0.121.0`.
> Maintained by **Aryan Gupta (Aryanispe Host)** — [aryanispehost.in](https://aryanispehost.in/)

[![npm](https://img.shields.io/npm/v/@aryanxispe/codex-termux?style=flat-square&logo=npm)](https://www.npmjs.com/package/@aryanxispe/codex-termux)
[![latest release](https://img.shields.io/github/v/release/aryanxispe/codex-termux?style=flat-square)](https://github.com/aryanxispe/codex-termux/releases/latest)

<p align="center">
  <img src="./.github/termux-robot.png" alt="Termux robot" width="80%" />
</p>

## Quick Summary

- **Package** → `@aryanxispe/codex-termux`
- **Upstream base** → `rust-v0.121.0`
- **Current release target** → `v0.121.0-termux`
- **Current limitation** → voice and realtime audio stay disabled in the Termux latest package

## Installation

```bash
# If you see "dpkg was interrupted" error, run this first:
# dpkg --configure -a

pkg update && pkg upgrade -y
pkg install nodejs-lts -y

# Grant storage permission
termux-setup-storage

# Install (Works on both Phone and BlueStacks)
npm install -g @aryanxispe/codex-termux@latest

# Verify
codex --version
codex login
```

| Package | Architecture | Devices |
|---------|-------------|----------|
| `@aryanxispe/codex-termux` | **Universal** (ARM64 / x86_64) | Phones & BlueStacks / Emulators |

Requirements:

- Android 7+ / API 24+
- Node.js >= 18

## Troubleshooting

### `E: dpkg was interrupted`

If you see this error during `pkg update` or `pkg upgrade`, run:

```bash
dpkg --configure -a
```

Then re-run the install steps.

### `codex: command not found`

After installation, if `codex` is not found, restart Termux or run:

```bash
source ~/.bashrc
```

If it still doesn't work, check npm's global bin is on your PATH:

```bash
npm config get prefix
export PATH="$(npm config get prefix)/bin:$PATH"
```

### Storage permission denied

Make sure you ran `termux-setup-storage` and tapped **Allow** when the Android permission dialog appeared. If you missed it, run it again:

```bash
termux-setup-storage
```

---

## Release Lines

### Latest (Termux-only)

- Native ARM64 Android build for Termux
- Tracks upstream OpenAI Codex closely
- Minimal compatibility delta only
- Fork update checks and release links point to `aryanxispe/codex-termux`

## What This Fork Does

- Uses the official OpenAI Codex source as upstream
- Builds native Android ARM64 binaries for Termux
- Applies only compatibility patches that upstream does not carry
- Publishes release artifacts on GitHub and npm for Termux users

## What This Fork Does Not Do

- Maintain a broad feature fork
- Replace upstream Codex
- Carry unrelated product behavior changes

## Termux Compatibility Notes

Current Termux-specific carry patches include:

- browser login via `termux-open-url`
- launcher hardening for helper re-exec
- `RUNPATH=$ORIGIN` on Android ELF binaries
- fork-specific update channel and release links

Current published limitation:

- voice and realtime audio remain disabled in the Termux latest package

This keeps the packaged binaries free of Android audio linker dependencies while preserving the rest of the upstream CLI flow.

## Releases and Updates

- Latest published GitHub release: [releases/latest](https://github.com/aryanxispe/codex-termux/releases/latest)
- Upstream release base: [rust-v0.121.0](https://github.com/openai/codex/releases/tag/rust-v0.121.0)
- npm package: [`@aryanxispe/codex-termux`](https://www.npmjs.com/package/@aryanxispe/codex-termux)

Maintainer release flow:

- trigger `.github/workflows/termux-npm-build-publish.yml` on `main`
- run once with `create_release=true` to publish GitHub release assets
- run again with `publish_npm=true` when the release artifacts are validated

## Documentation

- [Changelog](./CHANGELOG.md)
- [Patch inventory](./patches/README.md)
- [Runtime validation report](./test-reports/latest/CLI_RUNTIME_REPORT.md)
- [Building from source](./BUILDING.md)
- [GitHub Actions maintainer build](./.github/workflows/termux-npm-build-publish.yml)
- [Install and build docs](./docs/install.md)
- [Authentication](./docs/authentication.md)
- [Configuration](./docs/config.md)

## License

This project remains under the Apache 2.0 license inherited from OpenAI Codex.

- Original work: OpenAI
- Termux port and Android ARM64 packaging: Aryan Gupta (Aryanispe Host)

See [LICENSE](./LICENSE).
