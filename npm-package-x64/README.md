# Codex CLI for Termux (x86_64 / Bluestacks)

> Android Termux package built from upstream OpenAI Codex `rust-v0.121.0`.
> Maintained by **Aryan Gupta (Aryanispe Host)** — [aryanispehost.in](https://aryanispehost.in/)

**For Bluestacks, Android Studio emulator, and other x86_64 Android environments.**
For real ARM64 phones, use [`@aryanxispe/codex-termux`](https://www.npmjs.com/package/@aryanxispe/codex-termux) instead.

## Install

```bash
pkg update && pkg upgrade -y
pkg install nodejs-lts -y

# Grant storage permission
termux-setup-storage

# Install (x86_64 / Bluestacks)
npm install -g @aryanxispe/codex-termux-x64@latest

# Verify
codex --version
codex login
```

## Notes

- Android Termux x86_64 only (Bluestacks, Android Studio emulator)
- Built from upstream `rust-v0.121.0`
- Carries only the Termux compatibility delta needed for packaging and runtime
- Voice and realtime audio stay disabled in the published Termux line
- Packaged launchers preserve bundled `libc++_shared.so` visibility
- Android ELFs are hardened with `RUNPATH=$ORIGIN`

See the main repository for release notes and patch inventory:

- https://github.com/aryanxispe/codex-termux
- https://github.com/aryanxispe/codex-termux/blob/main/patches/README.md
