#!/usr/bin/env node

import {
  updateSubmodule,
  hasModelsChanged,
  commitChanges,
  createPullRequest,
  getGitRootDir,
  getSubmodulePath
} from './git';
import { prepareConfig, generateSdk, organizeGeneratedFiles, shouldRegenerateSdk } from './codegen';
import { Command } from 'commander';
import * as core from '@actions/core';
import { pathExists, readdir, stat } from 'fs-extra';
import * as path from 'path';
import chalk from 'chalk';
import ora from 'ora';

const CONFIG_TEMPLATE = 'config.json';
const DEFAULT_OUTPUT_DIR = 'lib';

const program = new Command();

program
  .option('-m, --models-dir <path>', 'Path to the models directory', 'amazon-sp-api-models')
  .option(
    '-l, --language <lang>',
    'Target language for code generation',
    process.env.DEFAULT_LANGUAGE || 'ruby'
  )
  .option('-o, --output-dir <path>', 'Output directory for generated code', DEFAULT_OUTPUT_DIR)
  .option('--dry-run', 'Run without making any changes')
  .option('--target-dir <path>', 'Target directory for the project root', getGitRootDir())
  .parse(process.argv);

function validateLanguage(lang: string): string {
  const supportedLanguages = ['ruby', 'java', 'python']; // Add all supported languages
  const normalizedLang = lang.toLowerCase();
  if (!supportedLanguages.includes(normalizedLang)) {
    throw new Error(`Unsupported language: ${lang}`);
  }
  return normalizedLang;
}

const options = program.opts();
const MODELS_DIR = path.resolve(options.targetDir, options.modelsDir);
const OUTPUT_DIR = path.resolve(options.targetDir, options.outputDir);
const LANGUAGE = validateLanguage(options.language);
const DRY_RUN = options.dryRun || false;
const TARGET_DIR = path.resolve(options.targetDir);
const submodulePath = getSubmodulePath(TARGET_DIR);
const versionFilePath = path.join(TARGET_DIR, 'sdk_version.json'); // Adjust this path as needed

/**
 * Main function that orchestrates the SDK generation process.
 */
async function main(): Promise<void> {
  if (DRY_RUN) {
    core.info(chalk.yellow('Dry run mode is enabled. No changes will be made.'));
  }

  core.info(`Using models directory: ${MODELS_DIR}`);
  core.info(`Generating SDKs in: ${OUTPUT_DIR}`);
  core.info(`Running in target directory: ${TARGET_DIR}`);

  if (!(await pathExists(submodulePath))) {
    throw new Error(`Submodule directory not found at ${submodulePath}. Please ensure the submodule path is correct.`);
  }

  await updateSubmodule(submodulePath);

  // Check for changes using folder hash
  if (!(await shouldRegenerateSdk(submodulePath, versionFilePath))) {
    core.info('Exiting as there are no changes to regenerate.');
    return;
  }

  try {
    // Update submodule
    await updateSubmodule(submodulePath);

    // Check if models have changed
    if (!(await hasModelsChanged(MODELS_DIR))) {
      core.info('No changes detected in models. Exiting.');
      return;
    }
  } catch (error: any) {
    core.setFailed(`Initialization failed: ${error.message}`);
    return;
  }

  const spinner = ora('Generating SDKs...').start();

  try {
    const modelsPath = path.join(MODELS_DIR, 'models');
    const apiFolders = await readdir(modelsPath);
    const changedApis: string[] = [];

    for (const apiFolder of apiFolders) {
      const apiFolderPath = path.join(modelsPath, apiFolder);
      const isDirectory = (await stat(apiFolderPath)).isDirectory();

      if (!isDirectory) {
        continue;
      }

      const jsonFiles = (await readdir(apiFolderPath)).filter((file) => file.endsWith('.json'));
      for (const jsonFile of jsonFiles) {
        const filePath = path.join(apiFolderPath, jsonFile);
        const outputDir = path.join(OUTPUT_DIR, apiFolder);
        const configFile = await prepareConfig(apiFolder, outputDir, CONFIG_TEMPLATE);

        await generateSdk(apiFolder, filePath, configFile, outputDir, LANGUAGE);
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

    if (!DRY_RUN) {
      await commitChanges('automated/sdk-update', changedApis, submodulePath, versionFilePath);;
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
