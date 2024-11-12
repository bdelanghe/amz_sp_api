#!/usr/bin/env python3

import argparse
import json
import os
import re
import shutil
import subprocess
import tempfile
from glob import glob

# Constants
MODELS_DIRECTORY = os.path.join('..', 'selling-partner-api-models', 'models')
LIB_DIRECTORY = 'lib'
CONFIG_TEMPLATE_FILENAME = 'config.json'
SWAGGER_CODEGEN_COMMAND = 'swagger-codegen'

def create_temp_file(initial_content="{}"):
    """
    Create a temporary file, write initial JSON content, and return its path.
    """
    temp_file = tempfile.NamedTemporaryFile(delete=False, mode='w')
    temp_file.write(initial_content)
    temp_file.close()
    return temp_file.name

# Initialize temporary files with empty JSON content
PREVIOUS_MODELS_FILENAME = create_temp_file()
CURRENT_MODELS_FILENAME = create_temp_file()

def print_colored(message, color=None):
    """
    Print the message in color if the color argument is provided.

    Args:
        message (str): The message to print.
        color (str, optional): The color for the text (e.g., 'red', 'green', 'blue').
    """
    colors = {
        'red': '\033[91m',
        'green': '\033[92m',
        'yellow': '\033[93m',
        'blue': '\033[94m',
        'magenta': '\033[95m',
        'cyan': '\033[96m',
        'white': '\033[97m'
    }
    end_color = '\033[0m'
    if color in colors:
        print(f"{colors[color]}{message}{end_color}")
    else:
        print(message)

def check_dependencies():
    """
    Check if external dependencies are available.
    """
    if not shutil.which(SWAGGER_CODEGEN_COMMAND):
        raise EnvironmentError(f"{SWAGGER_CODEGEN_COMMAND} is not installed or not found in PATH.")

def parse_command_line_arguments():
    """
    Parse command-line arguments.
    """
    parser = argparse.ArgumentParser(description='Generate API clients from Swagger JSON files.')
    parser.add_argument('--dry-run', action='store_true', help='Perform a dry run without making any changes.')
    return parser.parse_args()

def read_models_json(file_path):
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

def write_models_json(models_dict, file_path):
    """
    Write the models to a JSON file with sorted keys.

    Args:
        models_dict (dict): A dictionary with model identifiers and their versions.
        file_path (str): Path to the output file.
    """
    with open(file_path, 'w') as file:
        json.dump(models_dict, file, indent=4, sort_keys=True)

def compare_model_versions(previous_models_dict, current_models_dict):
    """
    Compare previous and current models to find changes, including if the default has changed.

    Args:
        previous_models_dict (dict): Dictionary of previous model versions.
        current_models_dict (dict): Dictionary of current model versions.

    Returns:
        tuple: A tuple containing sets of new models, removed models, and changed defaults.
    """
    new_models = set(current_models_dict.keys()) - set(previous_models_dict.keys())
    removed_models = set(previous_models_dict.keys()) - set(current_models_dict.keys())
    changed_defaults = {
        model for model in current_models_dict
        if model in previous_models_dict and current_models_dict[model] != previous_models_dict[model]
    }
    return new_models, removed_models, changed_defaults

def collect_api_files(models_directory):
    """
    Collect JSON files grouped by API name.

    Args:
        models_directory (str): Path to the models directory.

    Returns:
        dict: A dictionary mapping API names to lists of JSON file paths.
    """
    json_file_paths = glob(os.path.join(models_directory, '**', '*.json'), recursive=True)
    api_files = {}
    for json_file_path in json_file_paths:
        api_name = extract_api_name_from_path(json_file_path)
        if api_name is None:
            continue
        api_files.setdefault(api_name, []).append(json_file_path)
    return api_files

def extract_api_name_from_path(file_path):
    """
    Extract the API name from the file path.

    Args:
        file_path (str): The path to the JSON file.

    Returns:
        str: The extracted API name, or None if not found.
    """
    path_parts = file_path.split(os.sep)
    if 'models' not in path_parts:
        return None
    models_index = path_parts.index('models')
    if models_index + 1 >= len(path_parts):
        return None
    return path_parts[models_index + 1]

def extract_module_name(api_name):
    """
    Convert the API name to a module name by capitalizing letters after hyphens or underscores.

    Args:
        api_name (str): The API name.

    Returns:
        str: The module name.
    """
    return ''.join(word.capitalize() for word in re.split('[-_]', api_name))

def extract_version_from_filename(file_name):
    """
    Extract the version from the file name.

    Args:
        file_name (str): The JSON file name.

    Returns:
        str: The extracted version number as a string, without the 'V' prefix.
    """
    # Remove file extension
    file_name = os.path.splitext(file_name)[0]

    # Try to match 'V' followed by digits at the end of the filename
    match_v = re.search(r'V(\d+)$', file_name)
    # Try to match date format YYYY-MM-DD at the end of the filename
    match_date = re.search(r'(\d{4}-\d{2}-\d{2})$', file_name)

    if match_v:
        version = match_v.group(1)  # Extract digits after 'V'
    elif match_date:
        version = match_date.group(1).replace('-', '')  # Remove dashes
    else:
        version = '0'  # Default version number
    return version

def get_latest_version(api_file_list):
    """
    Get the latest version from a list of API files based on date or version.

    Args:
        api_file_list (list): List of JSON file paths.

    Returns:
        str: The path to the file with the most recent version.
    """
    def version_key(file_path):
        version = extract_version_from_filename(os.path.basename(file_path))
        return int(version)  # Assumes all versions can be compared numerically

    return max(api_file_list, key=version_key)

def process_api_files(api_files_dict):
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

        for api_file in api_file_list:
            file_name = os.path.basename(api_file)
            version = extract_version_from_filename(file_name)

            versioned_module_name = f"{module_name}::V{version}"
            versioned_api_name = f"{api_name}_V{version}"
            model_identifier = f"{api_name} V{version}"
            current_models_dict[model_identifier] = version

            # Collect information for versioned model
            models_to_generate.append({
                "api_file": api_file,
                "gem_name": versioned_api_name,
                "module_name": f"AmzSpApi::{versioned_module_name}",
                "lib_dir": os.path.join(LIB_DIRECTORY, api_name, f"v{version}"),
                "config_path": os.path.join(LIB_DIRECTORY, api_name, f"v{version}", CONFIG_TEMPLATE_FILENAME),
                "is_default_version": False,
                "version": version,
                "api_name": api_name
            })

        # Collect information for unversioned model (latest version)
        unversioned_api_name = api_name
        unversioned_module_name = f"AmzSpApi::{module_name}"
        model_identifier = f"{api_name} V{latest_version}"
        current_models_dict[model_identifier] = latest_version

        models_to_generate.append({
            "api_file": latest_version_file,
            "gem_name": unversioned_api_name,
            "module_name": unversioned_module_name,
            "lib_dir": os.path.join(LIB_DIRECTORY, api_name),
            "config_path": os.path.join(LIB_DIRECTORY, api_name, CONFIG_TEMPLATE_FILENAME),
            "is_default_version": True,
            "version": latest_version,
            "api_name": api_name
        })

    return models_to_generate, current_models_dict

def generate_dry_run_report(models_to_generate, previous_models_dict, current_models_dict):
    """
    Generate a dry-run report summarizing the changes.

    Args:
        models_to_generate (list): List of models to generate with their details.
        previous_models_dict (dict): Dictionary of previous model identifiers and versions.
        current_models_dict (dict): Dictionary of current model identifiers and versions.
    """
    # Compare models to find new, updated, and removed models
    new_models, removed_models, changed_defaults = compare_model_versions(previous_models_dict, current_models_dict)

    # Organize models by status
    models_status = {
        'added': [],
        'updated': [],
        'removed': []
    }

    # Determine added and updated models
    for model in models_to_generate:
        model_identifier = f"{model['api_name']} V{model['version']}"
        if model_identifier in new_models:
            models_status['added'].append(model)
        elif model_identifier in changed_defaults:
            models_status['updated'].append(model)

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
        for model in models_status['added']:
            print_colored(f"- {model['api_name']} (Version {model['version']})", color='white')
    else:
        print_colored("\nNo New Models Added.", color='green')

    if models_status['updated']:
        print_colored("\nModels Updated:", color='yellow')
        for model in models_status['updated']:
            print_colored(f"- {model['api_name']} (Updated to Version {model['version']})", color='white')
    else:
        print_colored("\nNo Models Updated.", color='yellow')

    if models_status['removed']:
        print_colored("\nModels Removed:", color='red')
        for model in models_status['removed']:
            print_colored(f"- {model['api_name']} (Version {model['version']})", color='white')
    else:
        print_colored("\nNo Models Removed.", color='red')

    print_colored("\nDetailed Model Information:", color='cyan')
    print_colored("---------------------------", color='cyan')

    for status, models in models_status.items():
        if models:
            status_color = {'added': 'green', 'updated': 'yellow', 'removed': 'red'}.get(status, 'white')
            print_colored(f"\n{status.capitalize()} Models:", color=status_color)
            for model in models:
                if status != 'removed':
                    print_colored(f"API Name: {model['api_name']}", color='white')
                    print_colored(f"Version: {model['version']}", color='white')
                    print_colored(f"Module Name: {model['module_name']}\n", color='magenta')
                else:
                    print_colored(f"API Name: {model['api_name']}", color='white')
                    print_colored(f"Version: {model['version']}\n", color='white')

def recreate_directory(directory_path):
    """
    Remove and recreate a directory.

    Args:
        directory_path (str): Path to the directory.
    """
    if os.path.exists(directory_path):
        shutil.rmtree(directory_path)
    os.makedirs(directory_path)

def copy_and_modify_config_template(source_config_path, destination_config_path, config_replacements):
    """
    Copy the config template and replace placeholders.

    Args:
        source_config_path (str): Path to the source config template.
        destination_config_path (str): Path to the destination config file.
        config_replacements (dict): Dictionary of placeholders and their replacements.
    """
    with open(source_config_path, 'r') as file:
        content = file.read()

    for placeholder, replacement in config_replacements.items():
        content = content.replace(placeholder, replacement)

    with open(destination_config_path, 'w') as file:
        file.write(content)

def generate_model(api_file_path, config_file_path, output_directory, is_default_version):
    """
    Generate the API model.

    Args:
        api_file_path (str): Path to the API JSON file.
        config_file_path (str): Path to the config file.
        output_directory (str): Output directory for generated files.
        is_default_version (bool): Flag indicating whether this is the default version.
    """
    run_swagger_codegen(api_file_path, config_file_path, output_directory)
    organize_generated_files(output_directory, is_default_version)

def run_swagger_codegen(input_spec_path, config_file_path, output_directory):
    """
    Run the swagger-codegen command.

    Args:
        input_spec_path (str): Path to the input specification (API JSON file).
        config_file_path (str): Path to the configuration file.
        output_directory (str): Output directory for generated code.
    """
    subprocess.run([
        SWAGGER_CODEGEN_COMMAND, 'generate',
        '-i', input_spec_path,
        '-l', 'ruby',
        '-c', config_file_path,
        '-o', output_directory
    ], check=True)

def organize_generated_files(output_directory, is_default_version):
    """
    Organize the generated files by moving and cleaning up unnecessary files.

    Args:
        output_directory (str): The directory containing generated files.
        is_default_version (bool): Flag indicating whether this is the default version.
    """
    api_name = os.path.basename(output_directory)
    if is_default_version:
        # Move {API_NAME}.rb to lib/
        move_api_rb_file(output_directory, api_name, move_rb_to=LIB_DIRECTORY)
        move_api_lib_contents(output_directory, api_name, destination_dir=os.path.join(LIB_DIRECTORY, api_name))
    else:
        # Keep files within the versioned directory
        move_api_rb_file(output_directory, api_name, move_rb_to=output_directory)
        move_api_lib_contents(output_directory, api_name, destination_dir=output_directory)
    clean_up_generated_files(output_directory)

def move_api_rb_file(output_directory, api_name, move_rb_to=None):
    """
    Move the {API_NAME}.rb file to the specified destination directory.

    Args:
        output_directory (str): The directory containing the .rb file.
        api_name (str): The API name.
        move_rb_to (str, optional): The destination directory.
    """
    source_rb_file = os.path.join(output_directory, 'lib', f"{api_name}.rb")
    if os.path.exists(source_rb_file):
        if move_rb_to:
            destination_rb_file = os.path.join(move_rb_to, f"{api_name}.rb")
        else:
            destination_rb_file = os.path.join(output_directory, f"{api_name}.rb")
        shutil.move(source_rb_file, destination_rb_file)

def move_api_lib_contents(output_directory, api_name, destination_dir):
    """
    Move the contents of lib/{API_NAME} to the specified destination directory.

    Args:
        output_directory (str): The directory containing the lib/{API_NAME} directory.
        api_name (str): The API name.
        destination_dir (str): The destination directory for the contents.
    """
    source_lib_api_dir = os.path.join(output_directory, 'lib', api_name)
    if os.path.exists(source_lib_api_dir):
        os.makedirs(destination_dir, exist_ok=True)
        for item_name in os.listdir(source_lib_api_dir):
            source_item_path = os.path.join(source_lib_api_dir, item_name)
            destination_item_path = os.path.join(destination_dir, item_name)
            if os.path.exists(destination_item_path):
                remove_existing_item(destination_item_path)
            shutil.move(source_item_path, destination_item_path)

def remove_existing_item(item_path):
    """
    Remove an existing file or directory.

    Args:
        item_path (str): Path to the file or directory to remove.
    """
    if os.path.isdir(item_path):
        shutil.rmtree(item_path)
    else:
        os.remove(item_path)

def clean_up_generated_files(output_directory):
    """
    Remove unnecessary files and directories from the output directory.

    Args:
        output_directory (str): The directory to clean up.
    """
    # Remove the lib directory if it exists
    lib_directory = os.path.join(output_directory, 'lib')
    if os.path.exists(lib_directory):
        shutil.rmtree(lib_directory, ignore_errors=True)

    # Remove unnecessary files like gemspec and others
    files_to_remove = [f for f in os.listdir(output_directory) if f.endswith('.gemspec') or f == '.swagger-codegen-ignore']
    for filename in files_to_remove:
        os.remove(os.path.join(output_directory, filename))

def main():
    """
    Main function to orchestrate code generation and model tracking.
    """
    check_dependencies()
    args = parse_command_line_arguments()
    is_dry_run = args.dry_run

    api_files_dict = collect_api_files(MODELS_DIRECTORY)

    previous_models_dict = read_models_json(PREVIOUS_MODELS_FILENAME)
    models_to_generate, current_models_dict = process_api_files(api_files_dict)

    if is_dry_run:
        # Generate the dry-run report
        generate_dry_run_report(models_to_generate, previous_models_dict, current_models_dict)
    else:
        # Perform the actual code generation
        for model in models_to_generate:
            # Read and prepare config replacements
            config_replacements = {
                'GEMNAME': model['gem_name'],
                'MODULENAME': model['module_name']
            }

            # Read the extended config.json
            with open(CONFIG_TEMPLATE_FILENAME, 'r') as config_file:
                config_data = json.load(config_file)

            # Update config data with replacements
            config_data['gemName'] = model['gem_name']
            config_data['moduleName'] = model['module_name']

            # Write the updated config.json
            os.makedirs(os.path.dirname(model['config_path']), exist_ok=True)
            with open(model['config_path'], 'w') as config_file:
                json.dump(config_data, config_file, indent=4)

            recreate_directory(model['lib_dir'])
            generate_model(model['api_file'], model['config_path'], model['lib_dir'], model['is_default_version'])

        write_models_json(current_models_dict, PREVIOUS_MODELS_FILENAME)
        write_models_json(current_models_dict, CURRENT_MODELS_FILENAME)

    # Clean up temporary files after use
    os.remove(PREVIOUS_MODELS_FILENAME)
    os.remove(CURRENT_MODELS_FILENAME)

if __name__ == '__main__':
    main()
