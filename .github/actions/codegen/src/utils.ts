import { spawn } from 'child_process';

interface RunCommandOptions {
  errorMessage?: string;
  cwd?: string;
}

/**
 * Executes a command asynchronously
 * @param command - The command to execute
 * @param args - The list of string arguments
 * @param options - Options including errorMessage and cwd
 * @returns The stdout output of the command
 */
export async function runCommand(command: string, args: string[], options: RunCommandOptions = {}): Promise<string> {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, { shell: true, cwd: options.cwd });
    let stdout = '';
    let stderr = '';

    child.stdout.on('data', (data) => {
      stdout += data.toString();
    });

    child.stderr.on('data', (data) => {
      stderr += data.toString();
    });

    child.on('close', (code) => {
      if (code === 0) {
        resolve(stdout.trim());
      } else {
        const errorMessage = options.errorMessage
          ? `${options.errorMessage}: ${stderr}`
          : `Command '${command}' exited with code ${code}: ${stderr}`;
        reject(new Error(errorMessage));
      }
    });

    child.on('error', (error) => {
      const errorMessage = options.errorMessage
        ? `${options.errorMessage}: ${error.message}`
        : `Error executing command '${command}': ${error.message}`;
      reject(new Error(errorMessage));
    });
  });
}
