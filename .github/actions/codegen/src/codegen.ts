#!/usr/bin/env node

import { execSync, ExecSyncOptions } from 'child_process';
import * as core from '@actions/core';
import * as fs from 'fs-extra';
import * as github from '@actions/github';
import * as path from 'path';
import spawn from 'cross-spawn';

interface RunCommandOptions {
  errorMessage?: string;
}

// Helper function to execute shell commands cross-platform
function runCommand(command: string, options: RunCommandOptions = {}): string {
  const result = spawn.sync(command, [], { stdio: 'pipe', shell: true });

  if (result.error) {
    const errorMessage = options.errorMessage ? `${options.errorMessage}: ${result.error.message}` : `Error executing command '${command}': ${result.error.message}`;
    core.setFailed(errorMessage);
    throw result.error;
  }

  return result.stdout ? result.stdout.toString().trim() : '';
}

// Function to update the submodule
function updateSubmodule(): void {
  core.info('Initializing and updating submodule...');
  runCommand('git submodule init', {
    errorMessage: 'Failed to initialize submodule.',
  });
  runCommand('git submodule update --remote --merge', {
    errorMessage: 'Failed to update submodule.',
  });
  core.info('Submodule updated successfully.');
}

// Function to check for changes in the models submodule
function hasModelsChanged(modelsDir: string): boolean {
  try {
    // Use cross-spawn to execute the command in a cross-platform way
    const result = spawn.sync('git', ['diff', 'HEAD@{1}', 'HEAD'], { cwd: modelsDir, stdio: 'pipe', shell: true });
    
    if (result.error) {
      core.setFailed(`Failed to check for model changes: ${result.error.message}`);
      throw result.error;
    }
    
    const diffOutput = result.stdout ? result.stdout.toString().trim() : '';
    if (!diffOutput) {
      core.info('No changes in models.');
      return false;
    }
    core.info('Models have changed.');
    return true;
  } catch (error) {
    if (error instanceof Error) {
      core.setFailed(`Failed to check for model changes: ${error.message}`);
    } else {
      core.setFailed('Failed to check for model changes: Unknown error');
    }
    throw error;
  }
}

// Function to prepare configuration file for code generation
async function prepareConfig(apiName: string, outputDir: string): Promise<string> {
  const configFilePath = path.join(outputDir, 'config.json');
  await fs.ensureDir(outputDir);
  await fs.copyFile('config.json', configFilePath);

  let configData = await fs.readFile(configFilePath, 'utf8');
  const moduleName = apiName.replace(/(^|-)(\w)/g, (_: string, __: string, letter: string) => letter.toUpperCase());
  configData = configData.replace(/GEMNAME/g, apiName).replace(/MODULENAME/g, moduleName);

  await fs.writeFile(configFilePath, configData);
  return configFilePath;
}

// Function to generate code for each API
function generateSdk(apiName: string, filePath: string, configFile: string, outputDir: string): void {
  core.info(`Generating SDK for ${apiName}...`);
  const command = `swagger-codegen generate -i "${filePath}" -l ruby -c "${configFile}" -o "${outputDir}"`;
  runCommand(command, { errorMessage: `Failed to generate SDK for ${apiName}` });
  core.info(`SDK generated for ${apiName}.`);
}

// Function to organize generated SDK files
async function organizeGeneratedFiles(apiName: string, outputDir: string): Promise<void> {
  core.info(`Organizing generated files for ${apiName}...`);
  const srcFile = path.join(outputDir, 'lib', `${apiName}.rb`);
  const destFile = path.join('lib', `${apiName}.rb`);

  await fs.move(srcFile, destFile, { overwrite: true });
  const apiFiles = await fs.readdir(path.join(outputDir, 'lib', apiName));

  for (const file of apiFiles) {
    const srcPath = path.join(outputDir, 'lib', apiName, file);
    const destPath = path.join(outputDir, file);
    await fs.move(srcPath, destPath, { overwrite: true });
  }

  await fs.remove(path.join(outputDir, 'lib'));
  await removeGemspecFiles(outputDir);
  core.info(`Files organized for ${apiName}.`);
}

// Function to remove unnecessary gemspec files
async function removeGemspecFiles(dir: string): Promise<void> {
  const filesInDir = await fs.readdir(dir);
  const gemspecFiles = filesInDir.filter((file) => file.endsWith('.gemspec'));

  for (const file of gemspecFiles) {
    await fs.remove(path.join(dir, file));
  }
}

// Function to commit updated files to git
function commitChanges(branchName: string): void {
  core.info('Committing changes...');
  try {
    // Configure git user
    runCommand('git config user.name "github-actions[bot]"');
    runCommand('git config user.email "github-actions[bot]@users.noreply.github.com"');

    // Fetch all branches
    runCommand('git fetch');

    // Delete remote branch if it exists
    try {
      runCommand(`git push origin --delete ${branchName}`);
      core.info(`Deleted existing remote branch ${branchName}.`);
    } catch {
      core.info(`No existing remote branch ${branchName} to delete.`);
    }

    // Create a new branch or reset it
    runCommand(`git checkout -B ${branchName}`);

    // Stage changes
    runCommand('git add models');
    runCommand('git add lib');

    // Commit changes
    runCommand('git commit -m "Update SDKs based on latest models"');

    // Push the new branch
    runCommand(`git push origin ${branchName}`);
    core.info(`Changes pushed to branch ${branchName}.`);
  } catch (error: any) {
    core.setFailed(`Failed to commit and push changes: ${error.message}`);
    throw error;
  }
}

// Function to create a pull request
async function createPullRequest(branchName: string): Promise<void> {
  try {
    const githubToken = process.env.GITHUB_TOKEN;

    if (!githubToken) {
      core.setFailed('GITHUB_TOKEN is not available. Please make sure it is provided as an environment variable.');
      return;
    }

    const octokit = github.getOctokit(githubToken);
    const { owner, repo } = github.context.repo;

    const title = 'Automated SDK Update';
    const body = 'This PR was created automatically by the codegen action.';
    const base = 'main';
    const head = branchName;

    core.info(`Creating a pull request from ${head} to ${base}.`);

    // Check if a PR from this branch already exists
    const { data: existingPRs } = await octokit.rest.pulls.list({
      owner,
      repo,
      head: `${owner}:${head}`,
      state: 'open',
    });

    if (existingPRs.length > 0) {
      core.info(`Pull request already exists: #${existingPRs[0].number}`);
      return;
    }

    // Create a new pull request
    const { data: pullRequest } = await octokit.rest.pulls.create({
      owner,
      repo,
      title,
      head,
      base,
      body,
    });

    core.info(`Pull request created: #${pullRequest.number}`);
  } catch (error: any) {
    core.setFailed(`Failed to create pull request: ${error.message}`);
    throw error;
  }
}

// Main function to orchestrate all tasks
async function main(): Promise<void> {
  try {
    const MODELS_DIR = 'models';
    const BRANCH_NAME = 'automated/sdk-update';

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

    // Commit changes to the new branch
    commitChanges(BRANCH_NAME);

    // Create a pull request
    await createPullRequest(BRANCH_NAME);
  } catch (error) {
    core.setFailed(`Action failed with error: ${error}`);
  }
}

// Execute the main function
main();
