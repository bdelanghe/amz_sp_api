import * as core from '@actions/core';
import { ensureDir, copyFile, readFile, writeFile, move, readdir, remove, pathExists } from 'fs-extra';
import * as path from 'path';
import { runCommand, getDirectoryContentHash, getStoredHash, storeHash } from './utils';

const CONFIG_TEMPLATE = 'config.json';
const LIB_DIR = 'lib';

/**
 * Determines if the SDK should be regenerated by comparing the current model directory's
 * hash with the stored hash.
 * @param submodulePath - The path to the models submodule directory.
 * @param versionFilePath - Path to the version file where the hash is stored.
 * @returns Boolean indicating if regeneration is needed.
 */
export async function shouldRegenerateSdk(submodulePath: string, versionFilePath: string): Promise<boolean> {
  const currentHash = await getDirectoryContentHash(submodulePath);
  const previousHash = await getStoredHash(versionFilePath);

  if (currentHash === previousHash) {
    core.info('No changes in models based on folder hash.');
    return false;
  }
  return true;
}

/**
 * Stores the current SDK version hash if it differs from the stored hash.
 * @param submodulePath - The path to the models submodule directory.
 * @param versionFilePath - Path to the version file where the hash should be stored.
 */
async function storeNewSdkVersion(submodulePath: string, versionFilePath: string): Promise<void> {
  const currentHash = await getDirectoryContentHash(submodulePath);
  await storeHash(versionFilePath, currentHash);
}

/**
 * Generates the SDK for a given API, records stats, and updates the version file.
 * @param apiName - The name of the API.
 * @param filePath - The path to the API definition file.
 * @param configFile - The path to the configuration file.
 * @param outputDir - The directory for generated SDK output.
 * @param language - The target language for code generation.
 * @returns Number of generated files.
 */
export async function generateSdk(
  apiName: string,
  filePath: string,
  configFile: string,
  outputDir: string,
  language: string,
  versionFilePath: string
): Promise<number> {
  core.info(`Generating SDK for ${apiName}...`);
  
  const startTime = Date.now();
  await runCommand('swagger-codegen', ['generate', '-i', filePath, '-l', language, '-c', configFile, '-o', outputDir], {
    errorMessage: `Failed to generate SDK for ${apiName}`,
  });
  const duration = (Date.now() - startTime) / 1000;
  
  // Count generated files and calculate new hash for generated content
  const files = await readdir(outputDir);
  const fileCount = files.length;

  // Output stats
  core.info(`SDK generated for ${apiName} in ${duration.toFixed(2)} seconds with ${fileCount} files.`);
  
  // Update the version file with the new content hash
  storeNewSdkVersion(outputDir, versionFilePath);
  
  return fileCount;
}

/**
 * Organizes the generated files for an API and moves them to the desired directory structure.
 * @param apiName - The name of the API.
 * @param outputDir - The directory where the generated SDK is located.
 */
export async function organizeGeneratedFiles(apiName: string, outputDir: string): Promise<void> {
  core.info(`Organizing generated files for ${apiName}...`);
  try {
    const srcFile = path.join(outputDir, LIB_DIR, `${apiName}.rb`);
    const destFile = path.join(LIB_DIR, `${apiName}.rb`);

    if (await pathExists(srcFile)) {
      await move(srcFile, destFile, { overwrite: true });
    } else {
      core.warning(`Source file does not exist: ${srcFile}`);
    }

    const apiLibDir = path.join(outputDir, LIB_DIR, apiName);
    if (await pathExists(apiLibDir)) {
      const apiFiles = await readdir(apiLibDir);

      for (const file of apiFiles) {
        const srcPath = path.join(apiLibDir, file);
        const destPath = path.join(outputDir, file);
        await move(srcPath, destPath, { overwrite: true });
      }
    } else {
      core.warning(`API library directory does not exist: ${apiLibDir}`);
    }

    await remove(path.join(outputDir, LIB_DIR));
    await removeGemspecFiles(outputDir);
    core.info(`Files organized for ${apiName}.`);
  } catch (error: any) {
    core.error(`Error organizing files for ${apiName}: ${error.message}`);
    throw error;
  }
}

/**
 * Prepares the configuration file for code generation.
 * @param apiName - The name of the API.
 * @param outputDir - The directory where the generated SDK will be placed.
 * @param configTemplate - The path to the configuration template.
 * @returns The path to the prepared configuration file.
 */
export async function prepareConfig(
  apiName: string,
  outputDir: string,
  configTemplate: string
): Promise<string> {
  await ensureDir(outputDir);
  const configFilePath = path.join(outputDir, 'config.json');
  await copyFile(configTemplate, configFilePath);

  let configData = await readFile(configFilePath, 'utf8');

  // Generate the actual gemName and moduleName
  const gemName = apiName;
  const moduleName = `AmzSpApi::${apiName.replace(
    /(^|-)(\w)/g,
    (_: string, __: string, letter: string) => letter.toUpperCase()
  )}`;

  // Replace placeholders
  configData = configData.replace(/GEMNAME/g, gemName).replace(/MODULENAME/g, moduleName);

  // Write the updated config
  await writeFile(configFilePath, configData);

  return configFilePath;
}

/**
 * Removes gemspec files from the specified directory.
 * @param dir - The directory from which to remove gemspec files.
 */
async function removeGemspecFiles(dir: string): Promise<void> {
  const filesInDir = await readdir(dir);
  const gemspecFiles = filesInDir.filter((file) => file.endsWith('.gemspec'));

  for (const file of gemspecFiles) {
    const filePath = path.join(dir, file);
    if (await pathExists(filePath)) {
      await remove(filePath);
    }
  }
}
