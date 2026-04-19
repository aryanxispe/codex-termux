# Building Codex CLI (Termux fork)

This repository packages the upstream OpenAI Codex CLI for Android Termux
(ARM64) with a small compatibility delta.

Most users should install the published package:

```bash
npm install -g @mmmbuto/codex-cli-termux@latest
```

## Native Termux build

On an ARM64 Termux device:

```bash
pkg update && pkg upgrade -y
pkg install git clang lld rust pkg-config openssl openssl-tool nodejs-lts -y

git clone https://github.com/DioNanos/codex-termux.git
cd codex-termux/codex-rs
cargo build --release -p codex-cli -p codex-exec
```

Expected outputs:

```bash
codex-rs/target/release/codex
codex-rs/target/release/codex-exec
```

## Linux-host Android cross-build

On a Linux maintainer host with Android NDK installed:

```bash
export ANDROID_NDK_HOME="$HOME/android-sdk/android-ndk-r26d"
export ANDROID_NDK_ROOT="$ANDROID_NDK_HOME"
export PATH="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"

python3 scripts/fetch_rusty_v8_android.py
eval "$(python3 scripts/fetch_rusty_v8_android.py | grep '^export ' | sed 's/^export //')"

cd codex-rs
cargo build --target aarch64-linux-android --release -p codex-cli -p codex-exec
```

Expected outputs:

```bash
codex-rs/target/aarch64-linux-android/release/codex
codex-rs/target/aarch64-linux-android/release/codex-exec
```

## Package layout smoke test

To test the npm wrapper layout locally:

```bash
cd npm-package
cp ../codex-rs/target/release/codex bin/codex.bin
cp ../codex-rs/target/release/codex-exec bin/codex-exec.bin
chmod +x bin/codex bin/codex-exec bin/codex.bin bin/codex-exec.bin
node ./bin/codex.js --version
```

For Linux-host Android cross-builds, also copy the NDK runtime:

```bash
cp "$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/libc++_shared.so" npm-package/bin/libc++_shared.so
```

## Maintainer release notes

- Workspace version lives in `codex-rs/Cargo.toml`.
- Published npm version lives in `npm-package/package.json`.
- Termux patch verification lives in `verify-patches.sh`.
- The maintainer GitHub Actions workflow is `.github/workflows/termux-npm-build-publish.yml`.
- Fork-owned Android `rusty_v8` assets are described in `third_party/v8/android-artifacts.toml`.
- The canonical publish path is GitHub Actions on `main`, not a local Termux build on `asusrp3`.
- Recommended order: run once with `create_release=true`, validate artifacts, then run again with `publish_npm=true`.

If the Android `rusty_v8` pair for the resolved crate version does not exist
yet, bootstrap a source checkout with:

```bash
python3 scripts/prepare_rusty_v8_android_source.py
```
