# CLI Runtime Report

**Goal**: practical no-crash validation on the installed Termux package

## Status

- `PASS` package/version check for `@mmmbuto/codex-cli-termux@0.121.0-termux`
- `PASS` top-level help
- `PASS` non-interactive help routing
- `PASS` wrapper-based subcommand routing
- `PASS` login status
- `PASS` MCP listing
- `PASS` features listing
- `PASS` completion generation help
- `PASS` app-server schema generation help
- `PASS` runtime patch inventory
- `PASS` real non-interactive execution
- `PASS` workspace file write/read in repo context
- `PASS` network smoke
- `PASS` installed binary linkage guard
- `PASS` no runtime crash in the tested command surface

## Practical Checks

- `codex --version`
- `codex-exec --version`
- `codex --help`
- `codex exec --help`
- `codex review --help`
- `codex login --help`
- `codex logout --help`
- `codex resume --help`
- `codex fork --help`
- `codex mcp --help`
- `codex sandbox --help`
- `codex app-server --help`
- `codex completion --help`
- `codex login status`
- `codex mcp list`
- `codex features list`
- `codex debug prompt-input --help`
- `codex app-server generate-json-schema --help`
- `codex app-server generate-json-schema --out <dir>`
- `codex completion bash`
- `codex exec --ephemeral "Reply with exactly: OK"`
- `codex-exec --sandbox workspace-write --skip-git-repo-check --json "print current directory and list files"`
- `codex-exec --sandbox workspace-write --skip-git-repo-check --json "create hello.txt with content 'hello' and then read it back"`
- `codex-exec --sandbox workspace-write --skip-git-repo-check --json "run one network check with curl -I https://www.google.com and report the first HTTP status line only"`
- `node .../codex.js --help`
- `node .../codex.js fork --help`
- `node .../codex.js debug --help`
- `node .../codex.js review --help`
- `node .../codex.js exec --help`
- `node .../codex.js login --help`
- `node .../codex.js logout --help`
- `node .../codex.js resume --help`
- `readelf -d .../bin/codex.bin`
- `readelf -d .../bin/codex-exec.bin`

## Result

The installed CLI responds correctly on the main user-facing entry points and completed real non-interactive execution, network, schema generation, and workspace write/read checks without a crash.

## Notes

- No recompilation was performed.
- This report is intentionally runtime-only.
- The checks target the installed CLI, not source-tree build validation.
- Test workspace used: repository root workspace
- Current installed package: `@mmmbuto/codex-cli-termux@0.121.0-termux`
- The first `codex-exec` write attempt hit a path-policy rejection before succeeding via a relative workspace path; the final write/read outcome passed.

## Screenshot Block

```text
CLI RUNTIME REPORT

STATUS: PASS

What was checked:
- version checks
- help routing
- login status
- MCP listing
- features listing
- completion help
- app-server schema generation help
- workspace file write/read
- network smoke
- wrapper subcommand routing
- binary linkage

Outcome:
- Installed CLI responds correctly
- No crash on the tested command surface
- Runtime-only validation, no compile step
```
