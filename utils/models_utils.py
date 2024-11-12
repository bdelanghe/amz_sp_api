import os
import re
import json
from glob import glob
from config.config import read_config_file

# Load configuration
config_data = read_config_file('config.json')
LIB_DIRECTORY = config_data.get('libDirectory', 'lib')

CONFIG_TEMPLATE_FILENAME = 'config.json'

def process_api_files_core(api_files_dict):
    """
    Core logic for processing each API and preparing data structures for versioned models for all versions.

    Args:
        api_files_dict (dict): Dictionary mapping API names to lists of JSON file paths.

    Returns:
        tuple: A tuple containing:
            - list of models to generate
            - current models dictionary for tracking versions
    """
    models_to_generate = []
    current_models_dict = {}

    for api_name, api_file_list in api_files_dict.items():
        module_name = extract_module_name(api_name)

        # Determine the latest version
        latest_version_file = get_latest_version(api_file_list)
        latest_version = extract_version_from_filename(os.path.basename(latest_version_file))

        processed_versions = set()
        has_multiple_versions = len(api_file_list) > 1

        for api_file in api_file_list:
            file_name = os.path.basename(api_file)
            version = extract_version_from_filename(file_name)

            if version in processed_versions:
                continue  # Avoid processing the same version multiple times
            processed_versions.add(version)

            versioned_module_name = f"AmzSpApi::{module_name}::V{version}"
            versioned_api_name = f"{api_name}_V{version}"
            model_identifier = f"{api_name} V{version}"
            current_models_dict[model_identifier] = version

            is_latest = version == latest_version

            # Collect information for versioned model
            models_to_generate.append({
                "api_file": api_file,
                "gem_name": versioned_api_name,
                "module_name": versioned_module_name,
                "lib_dir": os.path.join(LIB_DIRECTORY, api_name, f"v{version}"),
                "config_path": os.path.join(LIB_DIRECTORY, api_name, f"v{version}", CONFIG_TEMPLATE_FILENAME),
                "version": version,
                "api_name": api_name,
                "is_latest": is_latest,
                "has_multiple_versions": has_multiple_versions
            })

    return models_to_generate, current_models_dict

def process_api_files(api_files_dict):
    """
    Wrapper around the core processing logic to generate models and track current model versions.

    Args:
        api_files_dict (dict): Dictionary mapping API names to lists of JSON file paths.

    Returns:
        tuple: A tuple containing:
            - list of models to generate
            - current models dictionary
    """
    return process_api_files_core(api_files_dict)

def generate_dry_run_report(api_files_dict, previous_models_dict, gem_version, config_info):
    """
    Generate a dry-run report summarizing the changes.

    Args:
        api_files_dict: Dictionary mapping API names to lists of JSON file paths.
        previous_models_dict: Dictionary of previous model identifiers and versions.
        gem_version: The gem version.
        config_info: Configuration information to display.

    Returns:
        A dictionary summarizing the changes for dry-run purposes.
    """
    # Use the core processing logic to get models to generate and the current model versions.
    models_to_generate, current_models_dict = process_api_files_core(api_files_dict)

    report = {
        "config_info": {key: value for key, value in config_info.items() if key != 'MODULENAME'},
        "sdk_upgrade_summary": {
            "added": [],
            "updated": [],
            "removed": []
        },
        "gem_version": gem_version
    }

    # Compare models to find new, updated, and removed models
    new_models = set(current_models_dict.keys()) - set(previous_models_dict.keys())
    removed_models = set(previous_models_dict.keys()) - set(current_models_dict.keys())
    changed_defaults = {
        model for model in current_models_dict
        if model in previous_models_dict and current_models_dict[model] != previous_models_dict[model]
    }

    # Determine added and updated models
    for model in models_to_generate:
        model_identifier = f"{model['api_name']} V{model['version']}"
        if model_identifier in new_models:
            report["sdk_upgrade_summary"]["added"].append(model)
        elif model_identifier in changed_defaults:
            report["sdk_upgrade_summary"]["updated"].append(model)

    # Determine removed models
    for model_identifier in removed_models:
        api_name, version = model_identifier.rsplit(' V', 1)
        report["sdk_upgrade_summary"]["removed"].append({
            'api_name': api_name,
            'version': version
        })

    return report

# Helper functions

def collect_api_files(models_directory: str) -> dict:
    """
    Collect JSON files grouped by API name.

    Args:
        models_directory: Path to the models directory.

    Returns:
        A dictionary mapping API names to lists of JSON file paths.
    """
    json_file_paths = glob(os.path.join(models_directory, '**', '*.json'), recursive=True)
    api_files = {}
    for json_file_path in json_file_paths:
        api_name = extract_api_name_from_path(json_file_path)
        if api_name is None:
            continue
        api_files.setdefault(api_name, []).append(json_file_path)
    return api_files

def extract_api_name_from_path(file_path: str) -> str | None:
    """
    Extract the API name from the file path.

    Args:
        file_path: The path to the JSON file.

    Returns:
        The extracted API name, or None if not found.
    """
    path_parts = file_path.split(os.sep)
    if 'models' not in path_parts:
        return None
    models_index = path_parts.index('models')
    if models_index + 1 >= len(path_parts):
        return None
    return path_parts[models_index + 1]

def read_models_json(file_path: str) -> dict:
    """
    Read the models from a JSON file.

    Args:
        file_path: Path to the models JSON file.

    Returns:
        A dictionary with model identifiers and their versions.
    """
    if not os.path.exists(file_path) or os.path.getsize(file_path) == 0:
        return {}
    try:
        with open(file_path, 'r') as file:
            return json.load(file)
    except json.JSONDecodeError:
        print(f"Warning: Failed to parse JSON from {file_path}. Initializing as empty.")
        return {}

def extract_module_name(api_name: str) -> str:
    """
    Convert the API name to a module name by capitalizing letters after hyphens or underscores.

    Args:
        api_name: The API name.

    Returns:
        The module name.
    """
    return ''.join(word.capitalize() for word in re.split('[-_]', api_name))

def get_latest_version(api_file_list: list) -> str:
    """
    Get the latest version from a list of API files based on date or version.

    Args:
        api_file_list: List of JSON file paths.

    Returns:
        The path to the file with the most recent version.
    """
    def version_key(file_path):
        version = extract_version_from_filename(os.path.basename(file_path))
        return int(version)  # Assumes all versions can be compared numerically

    return max(api_file_list, key=version_key)

def extract_version_from_filename(file_name: str) -> str:
    """
    Extract the version from the file name.

    Args:
        file_name: The JSON file name.

    Returns:
        The extracted version number as a string.
    """
    match_date = re.search(r'(\d{4}-\d{2}-\d{2})$', file_name)

    if match_date:
        version = match_date.group(1).replace('-', '')  # Remove dashes
    else:
        version = '0'  # Default version number
    return version
