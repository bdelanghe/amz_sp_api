// git.ts

import { runCommand, updateSdkVersion, getDirectoryContentHash } from './utils';
import { execSync } from 'child_process';
import * as core from '@actions/core';
import * as github from '@actions/github';
import { pathExists } from 'fs-extra';
import * as semver from 'semver';
import * as path from 'path';

const GIT_USER_NAME = 'github-actions[bot]';
const GIT_USER_EMAIL = 'github-actions[bot]@users.noreply.github.com';
const DEFAULT_BRANCH = 'main';

/**
 * Automatically gets the path of the first submodule from .gitmodules
 * @param rootDir - The root directory of the Git repository
 * @returns The absolute path to the submodule
 */
export function getSubmodulePath(rootDir: string): string {
  try {
    const submoduleRelativePath = execSync(
      `git config --file .gitmodules --name-only --get-regexp path | head -n 1 | xargs git config --file .gitmodules --get`,
      { cwd: rootDir, encoding: 'utf-8' }
    ).trim();

    if (!submoduleRelativePath) {
      throw new Error('No submodule path found. Ensure a submodule is defined in .gitmodules.');
    }

    return path.join(rootDir, submoduleRelativePath);
  } catch (error) {
    throw new Error(`Failed to retrieve the path for the submodule. Ensure a submodule exists and is initialized.`);
  }
}

/**
 * Gets the root directory of the Git repository
 * @returns The absolute path to the Git root directory
 */
export function getGitRootDir(): string {
  try {
    return execSync('git rev-parse --show-toplevel').toString().trim();
  } catch (error) {
    throw new Error('Could not find Git root directory. Ensure you are running this script in a Git repository.');
  }
}

/**
 * Initializes and updates the Git submodule
 * @param submodulePath - The path to the submodule
 */
export async function updateSubmodule(submodulePath: string): Promise<void> {
  core.info('Initializing and updating submodule...');
  try {
    await runCommand('git', ['submodule', 'update', '--init', '--recursive'], {
      errorMessage: 'Failed to initialize and update submodule.',
    });

    core.info('Submodule updated successfully.');

    // Check if the submodule directory exists asynchronously
    if (!(await pathExists(submodulePath))) {
      throw new Error(`Submodule directory not found at ${submodulePath}. Please ensure the submodule path is correct.`);
    }

    core.info(`Submodule initialized and updated at path: ${submodulePath}`);
  } catch (error: any) {
    throw new Error(`Failed to update submodule: ${error.message}`);
  }
}

/**
 * Retrieves the commit hash of the submodule
 * @param submodulePath - The path to the submodule
 */
export async function getSubmoduleCommitHash(submodulePath: string): Promise<string> {
  try {
    const hash = execSync('git rev-parse HEAD', { cwd: submodulePath }).toString().trim();
    return hash;
  } catch (error) {
    throw new Error(`Failed to retrieve commit hash for submodule at ${submodulePath}: ${error}`);
  }
}

/**
 * Checks if the models have changed
 * @param modelsDir - The directory containing the models
 * @returns True if models have changed, false otherwise
 */
export async function hasModelsChanged(modelsDir: string): Promise<boolean> {
  try {
    const diffOutput = await runCommand('git', ['diff', '--name-only', '--relative', '--', modelsDir], {
      errorMessage: 'Failed to check for model changes',
    });

    if (!diffOutput) {
      core.info('No changes in models.');
      return false;
    }

    core.info('Detected changes in models.');
    return true;
  } catch (error: any) {
    throw new Error(`Failed to check for model changes: ${error.message}`);
  }
}

/**
 * Validates the branch name to ensure it is safe
 * @param branchName - The branch name to validate
 */
function validateBranchName(branchName: string): void {
  if (!/^[\w.-]+$/.test(branchName)) {
    throw new Error(`Invalid branch name: ${branchName}`);
  }
}

/**
 * Commits changes, adds version bump, and pushes to a new branch.
 * @param branchName - The branch name to create
 * @param changedApis - List of changed APIs
 * @param submodulePath - Path to the submodule for hash generation
 * @param versionFilePath - Path to the version file
 */
export async function commitChanges(branchName: string, changedApis: string[], submodulePath: string, versionFilePath: string): Promise<void> {
  core.info('Committing changes...');
  validateBranchName(branchName);

  try {
    await runCommand('git', ['config', 'user.name', GIT_USER_NAME]);
    await runCommand('git', ['config', 'user.email', GIT_USER_EMAIL]);

    const contentHash = await getDirectoryContentHash(submodulePath);
    const newVersion = await updateSdkVersion(versionFilePath, 'patch'); // Use 'patch' or any version strategy

    await runCommand('git', ['fetch']);

    try {
      await runCommand('git', ['push', 'origin', '--delete', branchName]);
      core.info(`Deleted existing remote branch ${branchName}.`);
    } catch {
      core.info(`No existing remote branch ${branchName} to delete.`);
    }

    await runCommand('git', ['checkout', '-B', branchName]);
    await runCommand('git', ['add', '.']);
    await runCommand('git', ['commit', '-m', `Update SDKs for APIs: ${changedApis.join(', ')}\n\nVersion: ${newVersion}\nHash: ${contentHash}`]);
    await runCommand('git', ['push', 'origin', branchName]);

    core.info(`Changes pushed to branch ${branchName} with version ${newVersion} and hash ${contentHash}.`);
  } catch (error: any) {
    throw new Error(`Failed to commit and push changes: ${error.message}`);
  }
}

/**
 * Creates a pull request from the specified branch to the main branch
 * @param branchName - The name of the branch from which to create the PR
 */
export async function createPullRequest(branchName: string): Promise<void> {
  try {
    const githubToken = process.env.GITHUB_TOKEN;

    if (!githubToken) {
      throw new Error('GITHUB_TOKEN is not available. Please make sure it is provided as an environment variable.');
    }

    const octokit = github.getOctokit(githubToken);
    const { owner, repo } = github.context.repo;

    const title = 'Automated SDK Update';
    const body = 'This PR was created automatically by the codegen action.';
    const base = DEFAULT_BRANCH;
    const head = branchName;

    core.info(`Creating a pull request from ${head} to ${base}.`);

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
    throw new Error(`Failed to create pull request: ${error.message}`);
  }
}
