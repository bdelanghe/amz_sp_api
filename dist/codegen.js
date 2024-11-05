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
const core = __importStar(require("@actions/core"));
const child_process_1 = require("child_process");
const fs = __importStar(require("fs-extra"));
const path = __importStar(require("path"));
// Helper function to execute shell commands
function runCommand(command, options = {}) {
    try {
        return (0, child_process_1.execSync)(command, { stdio: 'inherit', ...options }).toString().trim();
    }
    catch (error) {
        const errorMessage = options.errorMessage ? `${options.errorMessage}: ${error.message}` : `Error executing command '${command}': ${error.message}`;
        core.setFailed(errorMessage);
        throw error;
    }
}
// Function to update the submodule
function updateSubmodule() {
    core.info('Updating submodule...');
    runCommand('git submodule update --remote --merge', {
        errorMessage: 'Failed to update submodule.',
    });
    core.info('Submodule updated successfully.');
}
// Function to check for changes in the models submodule
function hasModelsChanged(modelsDir) {
    try {
        const diffOutput = (0, child_process_1.execSync)(`git diff HEAD@{1} HEAD || true`, { cwd: modelsDir }).toString().trim();
        if (!diffOutput) {
            core.info('No changes in models.');
            return false;
        }
        core.info('Models have changed.');
        return true;
    }
    catch (error) {
        core.setFailed(`Failed to check for model changes: ${error.message}`);
        throw error;
    }
}
// Rest of your functions with core.info/core.error as appropriate
// Main function to orchestrate all tasks
async function main() {
    try {
        const MODELS_DIR = 'models';
        updateSubmodule();
        if (!hasModelsChanged(MODELS_DIR)) {
            return;
        }
        const modelsPath = path.join(MODELS_DIR, 'models');
        const apiFolders = await fs.readdir(modelsPath);
        for (const apiFolder of apiFolders) {
            const apiFolderPath = path.join(modelsPath, apiFolder);
            const isDirectory = (await fs.stat(apiFolderPath)).isDirectory();
            if (!isDirectory) {
                continue;
            }
            const jsonFiles = (await fs.readdir(apiFolderPath)).filter((file) => file.endsWith('.json'));
            for (const jsonFile of jsonFiles) {
                const filePath = path.join(apiFolderPath, jsonFile);
                const outputDir = path.join('lib', apiFolder);
                const configFile = await prepareConfig(apiFolder, outputDir);
                generateSdk(apiFolder, filePath, configFile, outputDir);
                await organizeGeneratedFiles(apiFolder, outputDir);
            }
        }
        commitChanges();
    }
    catch (error) {
        core.setFailed(`Action failed with error: ${error}`);
    }
}
// Execute the main function
main();
