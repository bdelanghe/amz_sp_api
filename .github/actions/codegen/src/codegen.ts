// codegen.ts

import * as core from '@actions/core';
import * as fs from 'fs-extra';
import * as path from 'path';
import { runCommand } from './utils';

export async function prepareConfig(apiName: string, outputDir: string): Promise<string> {
  const configTemplatePath = 'config.json'; // Adjust path if necessary
  const configFilePath = path.join(outputDir, 'config.json');

  await fs.ensureDir(outputDir);
  await fs.copyFile(configTemplatePath, configFilePath);

  let configData = await fs.readFile(configFilePath, 'utf8');

  // Generate the actual gemName and moduleName
  const gemName = apiName;
  const moduleName = `AmzSpApi::${apiName.replace(/(^|-)(\w)/g, (_: string, __: string, letter: string) => letter.toUpperCase())}`;

  // Replace placeholders
  configData = configData
    .replace(/GEMNAME/g, gemName)
    .replace(/MODULENAME/g, moduleName);

  // Write the updated config
  await fs.writeFile(configFilePath, configData);

  return configFilePath;
}

export async function generateSdk(apiName: string, filePath: string, configFile: string, outputDir: string, language: string): Promise<void> {
  core.info(`Generating SDK for ${apiName}...`);
  runCommand('swagger-codegen', ['generate', '-i', filePath, '-l', language, '-c', configFile, '-o', outputDir], { errorMessage: `Failed to generate SDK for ${apiName}` });
  core.info(`SDK generated for ${apiName}.`);
}

export async function organizeGeneratedFiles(apiName: string, outputDir: string): Promise<void> {
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

async function removeGemspecFiles(dir: string): Promise<void> {
  const filesInDir = await fs.readdir(dir);
  const gemspecFiles = filesInDir.filter((file) => file.endsWith('.gemspec'));

  for (const file of gemspecFiles) {
    await fs.remove(path.join(dir, file));
  }
}
