#!/usr/bin/env node

import {
  updateSubmodule,
  commitChanges,
  createPullRequest,
  getSubmodulePath
} from './git';
import { generateSdk, organizeGeneratedFiles, shouldRegenerateSdk } from './codegen';
import * as core from '@actions/core';
import * as path from 'path';
import chalk from 'chalk';
import ora from 'ora';
import { pathExists, readdir, stat } from 'fs-extra';
import { ENV } from './env';
import { prepareConfig } from './config';

async function main(): Promise<void> {
  if (ENV.dryRun) {
    core.info(chalk.yellow('Dry run mode is enabled. No changes will be made.'));
  }

  core.info(`Using models directory: ${ENV.modelsDir}`);
  core.info(`Generating SDKs in: ${ENV.outputDir}`);
  core.info(`Running in target directory: ${ENV.targetDir}`);

  try {
    const submodulePath = getSubmodulePath(ENV.targetDir);

    if (!(await pathExists(submodulePath))) {
      throw new Error(`Submodule directory not found at ${submodulePath}. Please ensure the submodule path is correct.`);
    }

    // Update submodule
    await updateSubmodule(submodulePath);

    // Check for changes using folder hash
    if (!(await shouldRegenerateSdk(submodulePath, ENV.versionFilePath))) {
      core.info('Exiting as there are no changes to regenerate.');
      return;
    }
  } catch (error: any) {
    core.setFailed(`Initialization failed: ${error.message}`);
    return;
  }

  const spinner = ora('Generating SDKs...').start();

  try {
    const modelsPath = path.join(ENV.modelsDir, 'models');
    const apiFolders = await readdir(modelsPath);
    const changedApis: string[] = [];

    for (const apiFolder of apiFolders) {
      const apiFolderPath = path.join(modelsPath, apiFolder);
      const isDirectory = (await stat(apiFolderPath)).isDirectory();

      if (!isDirectory) continue;

      const jsonFiles = (await readdir(apiFolderPath)).filter((file) => file.endsWith('.json'));
      for (const jsonFile of jsonFiles) {
        const filePath = path.join(apiFolderPath, jsonFile);
        const outputDir = path.join(ENV.outputDir, apiFolder);
        const configFile = await prepareConfig(apiFolder, outputDir);

        await generateSdk(apiFolder, filePath, configFile, outputDir, ENV.language, ENV.versionFilePath);
        await organizeGeneratedFiles(apiFolder, outputDir);
        changedApis.push(apiFolder);
      }
    }

    spinner.succeed('SDK generation completed.');

    if (changedApis.length > 0) {
      core.info(`APIs updated: ${changedApis.join(', ')}`);
    } else {
      core.info('No APIs were updated.');
    }

    if (!ENV.dryRun) {
      await commitChanges('automated/sdk-update', changedApis, ENV.modelsDir, ENV.versionFilePath);
      await createPullRequest('automated/sdk-update');
    } else {
      core.info('Dry run mode enabled. Skipping commit and pull request creation.');
    }
  } catch (error: any) {
    spinner.fail('SDK generation failed.');
    core.setFailed(`Action failed with error: ${error.message}`);
  }
}

main().catch((error) => {
  core.setFailed(`Unhandled error: ${error.message}`);
});
