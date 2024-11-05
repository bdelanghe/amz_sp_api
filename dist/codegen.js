#!/usr/bin/env node
"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const fs = __importStar(require("fs-extra"));
const path = __importStar(require("path"));
// Helper function to run shell commands
function runCommand(command, options = {}) {
    return (0, child_process_1.execSync)(command, { stdio: 'inherit', ...options });
}
async function main() {
    const MODELS_DIR = 'models';
    // Update the submodule to the latest commit
    runCommand('git submodule update --remote --merge');
    // Check for changes in the models submodule
    const diffOutput = (0, child_process_1.execSync)('git diff HEAD@{1} HEAD || true', { cwd: MODELS_DIR }).toString().trim();
    if (!diffOutput) {
        console.log('No changes in models.');
        process.exit(0);
    }
    else {
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
    }
    catch (error) {
        console.log('No changes to commit.');
    }
}
main().catch(error => {
    console.error('An error occurred:', error);
    process.exit(1);
});
