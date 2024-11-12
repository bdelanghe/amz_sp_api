import json
import os
from glob import glob
import re

def read_models_json(file_path: str) -> dict:
    """
    Read the models from a JSON file.

    Args:
        file_path (str): Path to the models JSON file.

    Returns:
        dict: A dictionary with model identifiers and their versions.
    """
    if not os.path.exists(file_path) or os.path.getsize(file_path) == 0:
        return {}
    try:
        with open(file_path, 'r') as file:
            return json.load(file)
    except json.JSONDecodeError:
        print(f"Warning: Failed to parse JSON from {file_path}. Initializing as empty.")
        return {}

def process_api_files(api_files_dict: dict) -> tuple:
    """
    Process each API and prepare data structures for versioned models for all versions.

    Args:
        api_files_dict (dict): Dictionary mapping API names to lists of JSON file paths.

    Returns:
        tuple: A tuple containing the list of models to generate and the current models dictionary.
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
                "version": version,
                "api_name": api_name,
                "is_latest": is_latest,
                "has_multiple_versions": has_multiple_versions
            })

    return models_to_generate, current_models_dict

def generate_dry_run_report(models_to_generate: list, previous_models_dict: dict, current_models_dict: dict, gem_version: str, config_info: dict) -> None:
    """
    Generate a dry-run report summarizing the changes.

    Args:
        models_to_generate (list): List of models to generate with their details.
        previous_models_dict (dict): Dictionary of previous model identifiers and versions.
        current_models_dict (dict): Dictionary of current model identifiers and versions.
        gem_version (str): The gem version.
        config_info (dict): Configuration information to display.
    """
    from utils.interactive_utils import print_colored

    # Print configuration information
    print_colored("\nConfiguration Information:", color='cyan')
    for key, value in config_info.items():
        if key != 'MODULENAME':
            print_colored(f"{key}: {value}", color='white')

    # Compare models to find new, updated, and removed models
    new_models, removed_models, changed_defaults = compare_model_versions(previous_models_dict, current_models_dict)

    # Organize models by status
    models_status = {
        'added': [],
        'updated': [],
        'removed': []
    }

    # Use a set to avoid duplicates
    added_models_set = set()

    # Determine added and updated models
    for model in models_to_generate:
        model_identifier = f"{model['api_name']} V{model['version']}"
        if model_identifier in new_models and model_identifier not in added_models_set:
            models_status['added'].append(model)
            added_models_set.add(model_identifier)
        elif model_identifier in changed_defaults:
            models_status['updated'].append(model)

    # Sort the added models by API name and version
    models_status['added'].sort(key=lambda x: (x['api_name'], int(x['version'])))

    # Determine removed models
    for model_identifier in removed_models:
        api_name, version = model_identifier.rsplit(' V', 1)
        models_status['removed'].append({
            'api_name': api_name,
            'version': version
        })

    # Print the report
    print_colored("\nSDK Upgrade Summary", color='cyan')
    print_colored("===================", color='cyan')

    if models_status['added']:
        print_colored("\nNew Models Added:", color='green')
        last_api_name = None
        for model in models_status['added']:
            if model['api_name'] != last_api_name:
                print_colored(f"\nAPI Name: {model['api_name']}", color='cyan')
                last_api_name = model['api_name']
            version_info = f"Version: {model['version']}"
            if model['has_multiple_versions'] and model['is_latest']:
                version_info += " [latest]"
            print_colored(f"- {version_info}", color='white')
            print_colored(f"  Module Name: {model['module_name']}", color='white')
        print_colored(f"\nTotal New Models: {len(models_status['added'])}", color='green')
    else:
        print_colored("\nNo New Models Added.", color='green')

    if models_status['updated']:
        print_colored("\nModels Updated:", color='yellow')
        for model in models_status['updated']:
            version_info = f"Updated to Version {model['version']}"
            if model['has_multiple_versions'] and model['is_latest']:
                version_info += " [latest]"
            print_colored(f"- {model['api_name']} ({version_info})", color='white')
        print_colored(f"Total Updated Models: {len(models_status['updated'])}", color='yellow')
    else:
        print_colored("\nNo Models Updated.", color='yellow')

    if models_status['removed']:
        print_colored("\nModels Removed:", color='red')
        for model in models_status['removed']:
            print_colored(f"- {model['api_name']} (Version {model['version']})", color='white')
        print_colored(f"Total Removed Models: {len(models_status['removed'])}", color='red')
    else:
        print_colored("\nNo Models Removed.", color='red')

    print_colored(f"\nGem Version: {gem_version}", color='cyan')

def write_models_json(models_dict: dict, file_path: str) -> None:
    """
    Write the models to a JSON file with sorted keys.

    Args:
        models_dict (dict): A dictionary with model identifiers and their versions.
        file_path (str): Path to the output file.
    """
    with open(file_path, 'w') as file:
        json.dump(models_dict, file, indent=4, sort_keys=True)

# Utility functions used in process_api_files
def extract_module_name(api_name: str) -> str:
    return ''.join(word.capitalize() for word in re.split('[-_]', api_name))

def extract_version_from_filename(file_name: str) -> str:
    match_v = re.search(r'V(\d+)$', file_name)
    match_date = re.search(r'(\d{4}-\d{2}-\d{2})$', file_name)

    if match_v:
        return match_v.group(1)
    elif match_date:
        return match_date.group(1).replace('-', '')
    return '0'

def get_latest_version(api_file_list: list) -> str:
    def version_key(file_path):
        version = extract_version_from_filename(os.path.basename(file_path))
        return int(version)
    return max(api_file_list, key=version_key)

def compare_model_versions(previous_models_dict: dict, current_models_dict: dict) -> tuple:
    new_models = set(current_models_dict.keys()) - set(previous_models_dict.keys())
    removed_models = set(previous_models_dict.keys()) - set(current_models_dict.keys())
    changed_defaults = {
        model for model in current_models_dict
        if model in previous_models_dict and current_models_dict[model] != previous_models_dict[model]
    }
    return new_models, removed_models, changed_defaults
