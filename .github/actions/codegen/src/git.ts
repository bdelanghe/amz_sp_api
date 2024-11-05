// git.ts

import { runCommand } from './utils';
import * as core from '@actions/core';
import * as github from '@actions/github';
import * as fs from 'fs-extra';
import * as path from 'path';

export function updateSubmodule(submodulePath: string): void {
  core.info('Initializing and updating submodule...');
  runCommand('git', ['submodule', 'update', '--init', '--recursive'], { errorMessage: 'Failed to initialize and update submodule.' });
  core.info('Submodule updated successfully.');

  // Check if the submodule directory exists
  if (!fs.existsSync(submodulePath)) {
    core.setFailed(`Submodule directory not found at ${submodulePath}. Please ensure the submodule path is correct.`);
    throw new Error(`Submodule directory not found at ${submodulePath}`);
  }

  core.info(`Submodule initialized and updated at path: ${submodulePath}`);
}

export function hasModelsChanged(modelsDir: string): boolean {
  try {
    const diffOutput = runCommand('git', ['diff', '--name-only', 'HEAD~1', 'HEAD', '--', modelsDir], { errorMessage: 'Failed to check for model changes' });

    if (!diffOutput) {
      core.info('No changes in models.');
      return false;
    }
    core.info('Models have changed.');
    return true;
  } catch (error) {
    core.setFailed(`Failed to check for model changes: ${error}`);
    throw error;
  }
}

export function commitChanges(branchName: string, changedApis: string[]): void {
  core.info('Committing changes...');
  try {
    runCommand('git', ['config', 'user.name', 'github-actions[bot]']);
    runCommand('git', ['config', 'user.email', 'github-actions[bot]@users.noreply.github.com']);

    runCommand('git', ['fetch']);

    try {
      runCommand('git', ['push', 'origin', '--delete', branchName]);
      core.info(`Deleted existing remote branch ${branchName}.`);
    } catch {
      core.info(`No existing remote branch ${branchName} to delete.`);
    }

    runCommand('git', ['checkout', '-B', branchName]);
    runCommand('git', ['add', '.']);
    runCommand('git', ['commit', '-m', `Update SDKs for APIs: ${changedApis.join(', ')}`]);
    runCommand('git', ['push', 'origin', branchName]);
    core.info(`Changes pushed to branch ${branchName}.`);
  } catch (error: any) {
    core.setFailed(`Failed to commit and push changes: ${error.message}`);
    throw error;
  }
}

export async function createPullRequest(branchName: string): Promise<void> {
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
    core.setFailed(`Failed to create pull request: ${error.message}`);
    throw error;
  }
}
