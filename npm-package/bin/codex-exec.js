#!/usr/bin/env node

import { spawn } from 'child_process';
import { existsSync, lstatSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const execBinaryPath = join(__dirname, 'codex-exec');
const codexBinaryPath = join(__dirname, 'codex');

const hasDedicatedExecBinary =
  existsSync(execBinaryPath) && !lstatSync(execBinaryPath).isSymbolicLink();

const binaryPath = hasDedicatedExecBinary ? execBinaryPath : codexBinaryPath;
const args = hasDedicatedExecBinary
  ? process.argv.slice(2)
  : ['exec', ...process.argv.slice(2)];

const TERMUX_PREFIX = process.env.PREFIX || '/data/data/com.termux/files/usr';

function sanitizeLdLibraryPath(binDir) {
  const blocked = new Set([
    `${TERMUX_PREFIX}/lib`,
    `${TERMUX_PREFIX}/libexec`,
    '/data/data/com.termux/files/usr/lib',
    '/data/data/com.termux/files/usr/libexec'
  ]);

  const extraPaths = (process.env.LD_LIBRARY_PATH || '')
    .split(':')
    .filter((entry) => entry && !blocked.has(entry));

  return [binDir, ...extraPaths].join(':');
}

const env = { ...process.env, CODEX_MANAGED_BY_NPM: '1' };
const binDir = __dirname;
env.CODEX_SELF_EXE = binaryPath;
env.LD_LIBRARY_PATH = sanitizeLdLibraryPath(binDir);

const child = spawn(binaryPath, args, {
  stdio: 'inherit',
  env
});

child.on('exit', (code) => {
  process.exit(code);
});
