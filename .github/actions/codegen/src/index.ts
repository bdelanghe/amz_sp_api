#!/usr/bin/env node

import { Command } from 'commander';
import * as core from '@actions/core';
import * as fs from 'fs-extra';
import * as path from 'path';
import chalk from 'chalk';
import ora from 'ora';
import { runCommand } from './utils';
import { updateSubmodule, hasModelsChanged, commitChanges, createPullRequest } from './git';
import { prepareConfig, generateSdk, organizeGeneratedFiles } from './codegen';

const program = new Command();

program
  .option('-m, --models-dir <path>', 'Path to the models directory', 'amazon-sp-api-models')
  .option('-l, --language <lang>', 'Target language for code generation', 'ruby')
  .option('-o, --output-dir <path>', 'Output directory for generated code', 'lib')
  .option('--dry-run', 'Run without making any changes')
  .parse(process.argv);

const options = program.opts();
const MODELS_DIR = path.resolve(options.modelsDir);
const LANGUAGE = options.language;
const OUTPUT_DIR = path.resolve(options.outputDir);
const DRY_RUN = options.dryRun || false;

async function main(): Promise<void> {
  if (DRY_RUN) {
    core.info(chalk.yellow('Dry run mode is enabled. No changes will be made.'));
  }

  core.info(chalk.blue(`Using models directory: ${MODELS_DIR}`));
  core.info(chalk.blue(`Generating SDKs in: ${OUTPUT_DIR}`));

  updateSubmodule(MODELS_DIR);

  if (!hasModelsChanged(MODELS_DIR)) {
    core.info('No changes detected in models. Exiting.');
    return;
  }

  const spinner = ora('Generating SDKs...').start();

  try {
    const modelsPath = path.join(MODELS_DIR, 'models');
    const apiFolders = await fs.readdir(modelsPath);
    const changedApis: string[] = [];

    for (const apiFolder of apiFolders) {
      const apiFolderPath = path.join(modelsPath, apiFolder);
      const isDirectory = (await fs.stat(apiFolderPath)).isDirectory();

      if (!isDirectory) {
        continue;
      }

      const jsonFiles = (await fs.readdir(apiFolderPath)).filter((file) => file.endsWith('.json'));
      for (const jsonFile of jsonFiles) {
        const filePath = path.join(apiFolderPath, jsonFile);
        const outputDir = path.join(OUTPUT_DIR, apiFolder);
        const configFile = await prepareConfig(apiFolder, outputDir);

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
      commitChanges('automated/sdk-update', changedApis);
      await createPullRequest('automated/sdk-update');
    } else {
      core.info('Dry run mode enabled. Skipping commit and pull request creation.');
    }
  } catch (error) {
    spinner.fail('SDK generation failed.');
    core.setFailed(`Action failed with error: ${error}`);
  }
}

main();
