import * as core from '@actions/core';
import { Command } from 'commander';
import * as path from 'path';

const program = new Command();

program
  .option('-m, --models-dir <path>', 'Path to the models directory', process.env.MODELS_DIR || 'amazon-sp-api-models')
  .option('-l, --language <lang>', 'Target language for code generation', process.env.DEFAULT_LANGUAGE || 'ruby')
  .option('-o, --output-dir <path>', 'Output directory for generated code', process.env.OUTPUT_DIR)
  .option('--dry-run', 'Run without making any changes', process.env.DRY_RUN === 'true')
  .option('--target-dir <path>', 'Target directory for the project root', process.env.TARGET_DIR)
  .parse(process.argv);

const options = program.opts();

function validateLanguage(lang: string): string {
  const supportedLanguages = ['ruby', 'java', 'python'];
  const normalizedLang = lang.toLowerCase();
  if (!supportedLanguages.includes(normalizedLang)) {
    throw new Error(`Unsupported language: ${lang}`);
  }
  return normalizedLang;
}

export const ENV = {
  language: validateLanguage(options.language),
  dryRun: options.dryRun,
  targetDir: options.targetDir ? path.resolve(options.targetDir) : getGitRootDir(),
  modelsDir: options.modelsDir ? path.resolve(options.targetDir || getGitRootDir(), options.modelsDir) : path.resolve(options.targetDir || getGitRootDir(), 'amazon-sp-api-models'),
  outputDir: options.outputDir ? path.resolve(options.targetDir || getGitRootDir(), options.outputDir) : path.resolve(options.targetDir || getGitRootDir(), 'lib'),
  configTemplate: path.resolve(options.targetDir || getGitRootDir(), 'config.json'),
  versionFilePath: path.resolve(options.targetDir || getGitRootDir(), 'sdk_version.json'),
  
  // Additional required ENV variables for configuration
  gemAuthor: process.env.GEMAUTHOR || '',
  gemAuthorEmail: process.env.GEMAUTHOREMAIL || '',
  gemHomepage: process.env.GEMHOMEPAGE || '',
  gemLicense: process.env.GEMLICENSE || '',
  modulePrefix: process.env.MODULE_PREFIX || 'AmzSpApi::'
};

// Validate essential configuration variables
['gemAuthor', 'gemAuthorEmail', 'gemHomepage', 'gemLicense'].forEach((key) => {
  if (!ENV[key as keyof typeof ENV]) {
    throw new Error(`Environment variable ${key.toUpperCase()} is required but not set.`);
  }
});

function getGitRootDir(): string {
  try {
    return require('child_process').execSync('git rev-parse --show-toplevel').toString().trim();
  } catch (error) {
    throw new Error('Could not find Git root directory. Ensure you are running this script in a Git repository.');
  }
}
