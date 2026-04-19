#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

pass() { echo "✅ PRESENT"; }
fail() { echo "❌ MISSING!"; exit 1; }

READELF_BIN="${READELF_BIN:-$(command -v readelf || command -v llvm-readelf || true)}"

printf "Patch #1 (Browser Login): "
if grep -q "termux-open-url" codex-rs/login/src/server.rs; then
  pass
else
  fail
fi

printf "Patch #2 (Release Profile): "
if grep -q "lto = false" codex-rs/Cargo.toml && grep -q "codegen-units = 16" codex-rs/Cargo.toml; then
  pass
else
  fail
fi

printf "Patch #4/#5 (Fork Update Channel + Version Parser): "
if grep -q "aryanxispe/codex-termux" codex-rs/tui/src/updates.rs \
  && grep -q "split('-')" codex-rs/tui/src/updates.rs; then
  pass
else
  fail
fi

printf "Patch #6 (Termux npm Package Name): "
if grep -q "@aryanxispe/codex-termux@latest" codex-rs/tui/src/update_action.rs; then
  pass
else
  fail
fi

printf "Patch #10 (Launcher Hardening): "
if grep -q 'exec "\$SCRIPT_DIR/codex.bin"' npm-package/bin/codex \
  && grep -q 'exec "\$SCRIPT_DIR/codex-exec.bin"' npm-package/bin/codex-exec \
  && grep -q 'CODEX_SELF_EXE' npm-package/bin/codex.js \
  && grep -q '"bin/codex.bin"' npm-package/package.json; then
  pass
else
  fail
fi

printf "Patch #10b (Android ELF Runpath): "
if grep -q 'link-arg=-Wl,-rpath,$ORIGIN' codex-rs/.cargo/config.toml; then
  if [ -x npm-package/bin/codex.bin ] && [ -x npm-package/bin/codex-exec.bin ] && [ -n "$READELF_BIN" ]; then
    if "$READELF_BIN" -d npm-package/bin/codex.bin | grep -Eq '(RUNPATH|RPATH).*\$ORIGIN' \
      && "$READELF_BIN" -d npm-package/bin/codex-exec.bin | grep -Eq '(RUNPATH|RPATH).*\$ORIGIN'; then
      pass
    else
      fail
    fi
  else
    echo "✅ PRESENT (source configured; binary validation deferred until packaged Android ELFs are staged)"
  fi
else
  fail
fi

printf "Patch #11 (Android No-Voice Policy): "
if grep -q 'target_os = "android"' codex-rs/tui/src/lib.rs \
  && grep -q 'voice input is unavailable in this build' codex-rs/tui/src/lib.rs \
  && grep -Fq "[target.'cfg(not(target_os = \"linux\"))'.dependencies]" codex-rs/tui/Cargo.toml \
  && grep -q 'codex-tui = { workspace = true }' codex-rs/cli/Cargo.toml \
  && grep -q 'codex-tui = { workspace = true }' codex-rs/cloud-tasks/Cargo.toml; then
  pass
else
  fail
fi

printf "Patch #12 (Dynamic Subcommand Routing): "
if grep -q 'detectSubcommands' npm-package/bin/codex.js \
  && grep -q 'spawnSync(binaryPath' npm-package/bin/codex.js; then
  pass
else
  fail
fi

printf "Bazel patch inventory present: "
if [ -f patches/windows-link.patch ] && [ -f patches/aws-lc-sys_memcmp_check.patch ]; then
  pass
else
  fail
fi
