#!/usr/bin/env node

import { execSync } from 'child_process';
import * as fs from 'fs-extra';
import * as path from 'path';

// Helper function to run shell commands
function runCommand(command: string, options = {}) {
  return execSync(command, { stdio: 'inherit', ...options });
}

async function main() {
  const MODELS_DIR = 'models';

  // Update the submodule to the latest commit
  runCommand('git submodule update --remote --merge');

  // Check for changes in the models submodule
  const diffOutput = execSync('git diff HEAD@{1} HEAD || true', { cwd: MODELS_DIR }).toString().trim();

  if (!diffOutput) {
    console.log('No changes in models.');
    process.exit(0);
  } else {
    console.log('Models have changed.');
  }

  // Proceed with code generation
  const modelsPath = path.join(MODELS_DIR, 'models');
  const jsonFiles = await fs.readdir(modelsPath);

  for (const apiFolder of jsonFiles) {
    const apiFolderPath = path.join(modelsPath, apiFolder);
    const stats = await fs.stat(apiFolderPath);
    if (stats.isDirectory()) {
      const files = await fs.readdir(apiFolderPath);
      for (const file of files) {
        if (file.endsWith('.json')) {
          const filePath = path.join(apiFolderPath, file);
          const API_NAME = apiFolder;
          const MODULE_NAME = API_NAME.replace(/(^|-)(\w)/g, (_, __, letter) => letter.toUpperCase());

          const OUTPUT_DIR = path.join('lib', API_NAME);
          const CONFIG_FILE = path.join(OUTPUT_DIR, 'config.json');

          // Clean up previous generation
          await fs.remove(OUTPUT_DIR);
          await fs.ensureDir(OUTPUT_DIR);

          // Prepare configuration
          await fs.copyFile('config.json', CONFIG_FILE);
          let configData = await fs.readFile(CONFIG_FILE, 'utf8');
          configData = configData.replace(/GEMNAME/g, API_NAME).replace(/MODULENAME/g, MODULE_NAME);
          await fs.writeFile(CONFIG_FILE, configData);

          // Run Swagger Codegen
          const command = `swagger-codegen generate -i "${filePath}" -l ruby -c "${CONFIG_FILE}" -o "${OUTPUT_DIR}"`;
          runCommand(command);

          // Move generated files to the appropriate locations
          const sourceRb = path.join(OUTPUT_DIR, 'lib', `${API_NAME}.rb`);
          const destRb = path.join('lib', `${API_NAME}.rb`);
          await fs.move(sourceRb, destRb, { overwrite: true });

          const generatedFiles = await fs.readdir(path.join(OUTPUT_DIR, 'lib', API_NAME));
          for (const generatedFile of generatedFiles) {
            const src = path.join(OUTPUT_DIR, 'lib', API_NAME, generatedFile);
            const dst = path.join(OUTPUT_DIR, generatedFile);
            await fs.move(src, dst, { overwrite: true });
          }

          // Clean up unnecessary directories and files
          await fs.remove(path.join(OUTPUT_DIR, 'lib'));
          const filesInOutputDir = await fs.readdir(OUTPUT_DIR);
          for (const gemspecFile of filesInOutputDir.filter(f => f.endsWith('.gemspec'))) {
            await fs.remove(path.join(OUTPUT_DIR, gemspecFile));
          }
        }
      }
    }
  }

  // Commit the updated submodule and generated code
  try {
    runCommand('git add models');
    runCommand('git add lib');
    runCommand('git commit -m "Update SDKs based on latest models"');
  } catch (error) {
    console.log('No changes to commit.');
  }
}

main().catch(error => {
  console.error('An error occurred:', error);
  process.exit(1);
});
