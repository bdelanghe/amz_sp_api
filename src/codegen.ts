#!/usr/bin/env node

import * as core from '@actions/core';
import { execSync, ExecSyncOptions } from 'child_process';
import * as fs from 'fs-extra';
import * as path from 'path';

interface RunCommandOptions extends ExecSyncOptions {
  errorMessage?: string;
}

// Helper function to execute shell commands
function runCommand(command: string, options: RunCommandOptions = {}): string | void {
  try {
    return execSync(command, { stdio: 'inherit', ...options }).toString().trim();
  } catch (error: any) {
    const errorMessage = options.errorMessage ? `${options.errorMessage}: ${error.message}` : `Error executing command '${command}': ${error.message}`;
    core.setFailed(errorMessage);
    throw error;
  }
}

// Function to update the submodule
function updateSubmodule(): void {
  core.info('Updating submodule...');
  runCommand('git submodule update --remote --merge', {
    errorMessage: 'Failed to update submodule.',
  });
  core.info('Submodule updated successfully.');
}

// Function to check for changes in the models submodule
function hasModelsChanged(modelsDir: string): boolean {
  try {
    const diffOutput = execSync(`git diff HEAD@{1} HEAD || true`, { cwd: modelsDir }).toString().trim();
    if (!diffOutput) {
      core.info('No changes in models.');
      return false;
    }
    core.info('Models have changed.');
    return true;
  } catch (error) {
    core.setFailed(`Failed to check for model changes: ${error.message}`);
    throw error;
  }
}

// Rest of your functions with core.info/core.error as appropriate

// Main function to orchestrate all tasks
async function main(): Promise<void> {
  try {
    const MODELS_DIR = 'models';

    updateSubmodule();

    if (!hasModelsChanged(MODELS_DIR)) {
      return;
    }

    const modelsPath = path.join(MODELS_DIR, 'models');
    const apiFolders = await fs.readdir(modelsPath);

    for (const apiFolder of apiFolders) {
      const apiFolderPath = path.join(modelsPath, apiFolder);
      const isDirectory = (await fs.stat(apiFolderPath)).isDirectory();

      if (!isDirectory) {
        continue;
      }

      const jsonFiles = (await fs.readdir(apiFolderPath)).filter((file) => file.endsWith('.json'));
      for (const jsonFile of jsonFiles) {
        const filePath = path.join(apiFolderPath, jsonFile);
        const outputDir = path.join('lib', apiFolder);
        const configFile = await prepareConfig(apiFolder, outputDir);

        generateSdk(apiFolder, filePath, configFile, outputDir);
        await organizeGeneratedFiles(apiFolder, outputDir);
      }
    }

    commitChanges();
  } catch (error) {
    core.setFailed(`Action failed with error: ${error}`);
  }
}

// Execute the main function
main();
