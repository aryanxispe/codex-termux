# CODEX TEST REPORT v0.121.0-termux

- Date: 2026-04-16 19:30 CET
- Device: Termux Android device
- Repo: codex-termux workspace
- Global package under test: `@mmmbuto/codex-cli-termux@0.121.0-termux`
- Suite reference: `test-reports/latest/CLI_RUNTIME_REPORT.md`

## Version Snapshot

- `codex --version` -> `codex-cli 0.121.0-termux`
- `codex-exec --version` -> `codex-exec 0.121.0-termux`

## Checks

- `PASS` package installed globally
- `PASS` global command path resolves to the installed Termux bin directory
- `PASS` `codex --help`
- `PASS` `codex exec --help`
- `PASS` `codex-exec --help`
- `PASS` `codex login status`
- `PASS` `codex mcp list`
- `PASS` `codex features list`
- `PASS` `node .../bin/codex.js --help`
- `PASS` `node .../bin/codex.js fork --help`
- `PASS` `codex exec --ephemeral "Reply with exactly: OK"`

## Notes

- Runtime-only validation.
- No recompilation was performed.
- The tested command surface completed without crash.

## Result

`PASS`
