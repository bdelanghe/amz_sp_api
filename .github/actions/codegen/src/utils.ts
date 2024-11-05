import { spawn } from 'child_process';
import * as crypto from 'crypto';
import * as semver from 'semver';
import * as path from 'path';
import { readFile, writeFile, readdir, stat, pathExists } from 'fs-extra';

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

/**
 * Reads and increments the SDK version following Semantic Versioning (SemVer).
 * Creates a new version file if none exists.
 * 
 * @param versionFilePath - Path to the version file
 * @param level - Which level of the version to increment: 'patch', 'minor', or 'major'
 * @returns The new version string
 */
export async function updateSdkVersion(versionFilePath: string, level: 'patch' | 'minor' | 'major'): Promise<string> {
  let currentVersion = '0.1.0'; // Default initial version

  if (await pathExists(versionFilePath)) {
    const versionData = await readFile(versionFilePath, 'utf8');
    if (semver.valid(versionData.trim())) {
      currentVersion = versionData.trim();
    } else {
      throw new Error(`Invalid version format in ${versionFilePath}`);
    }
  }

  // Increment the version
  const newVersion = semver.inc(currentVersion, level);
  if (!newVersion) throw new Error(`Failed to increment version from ${currentVersion}`);

  await writeFile(versionFilePath, newVersion); // Write the new version back to file
  return newVersion;
}

/**
 * Generates a SHA-256 hash for all files in a given directory.
 * This creates a unique hash based on file contents, independent of Git history.
 * 
 * @param dirPath - The directory path to hash
 * @returns A SHA-256 hash representing the content of the directory
 */
export async function getDirectoryContentHash(dirPath: string): Promise<string> {
  const hash = crypto.createHash('sha256');

  async function processDirectory(directory: string): Promise<void> {
    const files = await readdir(directory);

    // Sort files to ensure consistent ordering for the hash
    files.sort();
    
    for (const file of files) {
      const filePath = path.join(directory, file);
      const fileStat = await stat(filePath);

      if (fileStat.isDirectory()) {
        await processDirectory(filePath); // Recurse into subdirectories
      } else if (fileStat.isFile()) {
        const fileContent = await readFile(filePath);
        hash.update(fileContent); // Update hash with file content
      }
    }
  }

  await processDirectory(dirPath);
  return hash.digest('hex'); // Return the final hex hash
}
