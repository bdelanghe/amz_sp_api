// utils.ts

import spawn from 'cross-spawn';
import * as core from '@actions/core';

interface RunCommandOptions {
  errorMessage?: string;
  cwd?: string;
}

export function runCommand(command: string, args: string[], options: RunCommandOptions = {}): string {
  const result = spawn.sync(command, args, { stdio: 'pipe', shell: true, cwd: options.cwd });

  if (result.error) {
    const errorMessage = options.errorMessage
      ? `${options.errorMessage}: ${result.error.message}`
      : `Error executing command '${command}': ${result.error.message}`;
    core.setFailed(errorMessage);
    throw result.error;
  }

  if (result.status !== 0) {
    const stderr = result.stderr ? result.stderr.toString() : '';
    const errorMessage = options.errorMessage
      ? `${options.errorMessage}: ${stderr}`
      : `Command '${command}' exited with code ${result.status}: ${stderr}`;
    core.setFailed(errorMessage);
    throw new Error(errorMessage);
  }

  return result.stdout ? result.stdout.toString().trim() : '';
}
