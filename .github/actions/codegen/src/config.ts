import * as core from '@actions/core';
import { ensureDir, copyFile, readFile, writeFile, pathExists } from 'fs-extra';
import * as path from 'path';

/**
 * Prepares the configuration file for code generation.
 * @param apiName - The name of the API.
 * @param outputDir - The directory where the generated SDK will be placed.
 * @param configTemplate - Path to the configuration template.
 * @param modulePrefix - Prefix for the module name (e.g., "AmzSpApi::").
 * @param gemAuthor - Author of the gem.
 * @param gemAuthorEmail - Email of the gem author.
 * @param gemHomepage - Homepage URL of the gem.
 * @param gemLicense - License type of the gem.
 * @returns The path to the prepared configuration file.
 */
export async function prepareConfig(
  apiName: string,
  outputDir: string,
  configTemplate: string,
  modulePrefix: string,
  gemAuthor: string,
  gemAuthorEmail: string,
  gemHomepage: string,
  gemLicense: string
): Promise<string> {
  core.info(`Preparing configuration for API: ${apiName}`);
  
  await ensureDir(outputDir);
  const configFilePath = path.join(outputDir, 'config.json');

  if (!(await pathExists(configTemplate))) {
    throw new Error(`Configuration template not found at ${configTemplate}. Ensure config.json is available.`);
  }
  core.info(`Found configuration template at ${configTemplate}`);
  
  await copyFile(configTemplate, configFilePath);
  core.info(`Copied configuration template to ${configFilePath}`);

  let configData = await readFile(configFilePath, 'utf8');
  
  const gemName = apiName;
  const moduleName = `${modulePrefix}${apiName.replace(/(^|-)(\w)/g, (_: string, __: string, letter: string) => letter.toUpperCase())}`;

  // Replace placeholders with provided values
  configData = configData
    .replace(/GEMNAME/g, gemName)
    .replace(/MODULENAME/g, moduleName)
    .replace(/GEMAUTHOR/g, gemAuthor)
    .replace(/GEMAUTHOREMAIL/g, gemAuthorEmail)
    .replace(/GEMHOMEPAGE/g, gemHomepage)
    .replace(/GEMLICENSE/g, gemLicense);

  await writeFile(configFilePath, configData);
  core.info(`Configured gemName as ${gemName}, moduleName as ${moduleName}`);
  core.info(`Configuration prepared successfully for ${apiName}`);

  return configFilePath;
}
