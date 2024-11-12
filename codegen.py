#!/usr/bin/env python3

import argparse
import json
import os
import re
import shutil
import subprocess
import tempfile
from glob import glob
from contextlib import contextmanager

# Constants
MODELS_DIRECTORY = os.path.join('..', 'selling-partner-api-models', 'models')
LIB_DIRECTORY = 'lib'
CONFIG_TEMPLATE_FILENAME = 'config.json'
GEMSPEC_TEMPLATE_FILENAME = 'amz_sp_api.gemspec.erb'
SWAGGER_CODEGEN_COMMAND = 'swagger-codegen'
VERSION_FILE = 'version.txt'  # File to keep track of GEMVERSION

def get_git_config_value(key):
    """
    Get a value from git config.
    """
    try:
        return subprocess.check_output(['git', 'config', '--get', key]).decode('utf-8').strip()
    except subprocess.CalledProcessError:
        return None

def get_github_repo_url():
    """
    Get the GitHub repository URL using git.
    """
    try:
        url = subprocess.check_output(['git', 'config', '--get', 'remote.origin.url']).decode('utf-8').strip()
        # Convert git@github.com:user/repo.git to https://github.com/user/repo
        if url.startswith('git@'):
            url = url.replace(':', '/')
            url = url.replace('git@', 'https://')
            url = url.rstrip('.git')
        elif url.startswith('https://') and url.endswith('.git'):
            url = url.rstrip('.git')
        return url
    except subprocess.CalledProcessError:
        return None

def get_github_repo_description():
    """
    Get the GitHub repository description using gh CLI.
    """
    try:
        description = subprocess.check_output(
            ['gh', 'repo', 'view', '--json', 'description', '--jq', '.description']
        ).decode('utf-8').strip()
        return description
    except (subprocess.CalledProcessError, FileNotFoundError):
        return None

def get_env_or_default(env_var, default_value):
    """
    Get the value from environment variable or return default.
    """
    return os.environ.get(env_var, default_value)

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
    if not shutil.which('git'):
        raise EnvironmentError("git is not installed or not found in PATH.")
    if not shutil.which('gh'):
        raise EnvironmentError("GitHub CLI 'gh' is not installed or not found in PATH.")

def parse_command_line_arguments():
    """
    Parse command-line arguments.
    """
    parser = argparse.ArgumentParser(description='Generate API clients from Swagger JSON files.')
    parser.add_argument('--dry-run', action='store_true', help='Perform a dry run without making any changes.')
    parser.add_argument('--interactive', action='store_true', help='Run the script in interactive mode, prompting for confirmation at each step.')
    parser.add_argument('--prerelease', action='store_true', help='Mark the release as a prerelease.')
    parser.add_argument('--prerelease-label', type=str, default='', help='Label for the prerelease (e.g., alpha, beta).')
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

def generate_dry_run_report(models_to_generate, previous_models_dict, current_models_dict, gem_version, config_info):
    """
    Generate a dry-run report summarizing the changes.

    Args:
        models_to_generate (list): List of models to generate with their details.
        previous_models_dict (dict): Dictionary of previous model identifiers and versions.
        current_models_dict (dict): Dictionary of current model identifiers and versions.
        gem_version (str): The gem version.
        config_info (dict): Configuration information to display.
    """
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
            print_colored(f"\nAPI Name: {model['api_name']}", color='cyan')
            print_colored(f"Updated to Version: {model['version']}", color='white')
            print_colored(f"Module Name: {model['module_name']}", color='white')
        print_colored(f"\nTotal Updated Models: {len(models_status['updated'])}", color='yellow')
    else:
        print_colored("\nNo Models Updated.", color='yellow')

    if models_status['removed']:
        print_colored("\nModels Removed:", color='red')
        for model in models_status['removed']:
            print_colored(f"\nAPI Name: {model['api_name']}", color='cyan')
            print_colored(f"Version: {model['version']}", color='white')
        print_colored(f"\nTotal Removed Models: {len(models_status['removed'])}", color='red')
    else:
        print_colored("\nNo Models Removed.", color='red')

    print_colored(f"\nGem Version: {gem_version}", color='cyan')

def get_latest_git_tag():
    """
    Get the latest Git tag that matches semantic versioning.
    """
    try:
        tags = subprocess.check_output(['git', 'tag']).decode('utf-8').strip().split('\n')
        version_tags = [tag for tag in tags if re.match(r'^v\d+\.\d+\.\d+(-\w+(\.\d+)?)?$', tag)]
        if version_tags:
            # Sort the tags based on version numbers
            def version_key(s):
                s = s.lstrip('v')
                main_version, *prerelease = s.split('-')
                nums = list(map(int, main_version.split('.')))
                if prerelease:
                    prerelease = prerelease[0]
                    label, *pre_num = prerelease.split('.')
                    pre_num = int(pre_num[0]) if pre_num else 0
                    nums.append(pre_num)
                else:
                    nums.append(float('inf'))  # Non-prerelease versions come after prereleases
                return nums
            version_tags.sort(key=version_key)
            return version_tags[-1]
        else:
            return None
    except subprocess.CalledProcessError:
        return None

def increment_version(current_version, prerelease_label=None):
    """
    Increment the version number.

    Args:
        current_version (str): The current version string.
        prerelease_label (str): The prerelease label (e.g., 'alpha', 'beta').

    Returns:
        str: The next version string.
    """
    # Parse current version
    match = re.match(r'^(\d+)\.(\d+)\.(\d+)(?:-(\w+)(?:\.(\d+))?)?$', current_version)
    if not match:
        raise ValueError(f"Invalid version format: {current_version}")
    major, minor, patch, label, pre_num = match.groups()
    major, minor, patch = int(major), int(minor), int(patch)
    pre_num = int(pre_num) if pre_num else 0

    if prerelease_label:
        # If it's already a prerelease with the same label, increment prerelease number
        if label == prerelease_label:
            pre_num += 1
        else:
            pre_num = 1
        new_version = f"{major}.{minor}.{patch}-{prerelease_label}.{pre_num}"
    else:
        # Increment patch version
        patch += 1
        new_version = f"{major}.{minor}.{patch}"

    return new_version

def copy_and_modify_template(source_path, destination_path, replacements):
    """
    Copy the template and replace placeholders.

    Args:
        source_path (str): Path to the source template.
        destination_path (str): Path to the destination file.
        replacements (dict): Dictionary of placeholders and their replacements.
    """
    with open(source_path, 'r') as file:
        content = file.read()

    for placeholder, replacement in replacements.items():
        content = content.replace(f"<{placeholder}>", replacement)

    with open(destination_path, 'w') as file:
        file.write(content)

def is_no_reply_email(email):
    """
    Check if the email is a GitHub no-reply email.

    Args:
        email (str): The email address to check.

    Returns:
        bool: True if it's a no-reply email, False otherwise.
    """
    return 'noreply' in email

def prompt_confirmation(message):
    """
    Prompt the user for confirmation.

    Args:
        message (str): The message to display.

    Returns:
        bool: True if the user confirms, False otherwise.
    """
    while True:
        response = input(f"{message} [y/n]: ").lower()
        if response in ('y', 'yes'):
            return True
        elif response in ('n', 'no'):
            return False

def read_config_file(config_filename):
    """
    Read configuration from config.json file.

    Args:
        config_filename (str): Path to the config.json file.

    Returns:
        dict: Configuration dictionary.
    """
    if not os.path.exists(config_filename):
        raise FileNotFoundError(f"Configuration file {config_filename} not found.")
    with open(config_filename, 'r') as file:
        return json.load(file)

def create_swagger_codegen_ignore(destination_path):
    """
    Create or update the .swagger-codegen-ignore file with specified patterns.

    Args:
        destination_path (str): The path where the .swagger-codegen-ignore file should be placed.
    """
    ignore_patterns = [
        'Gemfile',
        'LICENSE',
        'README.md',
        'Rakefile',
        'amz_sp_api.gemspec.erb',
        'codegen.py',
        'config.json',
        'git_push.sh',
        '*.gemspec',
        '*.md',
        'lib/**/*_spec.rb',
        'spec/',
        'test/'
    ]

    ignore_file_content = '\n'.join(ignore_patterns)

    with open(destination_path, 'w') as ignore_file:
        ignore_file.write(ignore_file_content)

def main():
    """
    Main function to orchestrate code generation and model tracking.
    """
    check_dependencies()
    args = parse_command_line_arguments()
    is_dry_run = args.dry_run
    is_interactive = args.interactive
    is_prerelease = args.prerelease
    prerelease_label = args.prerelease_label

    api_files_dict = collect_api_files(MODELS_DIRECTORY)

    previous_models_filename = 'models_previous.json'
    current_models_filename = 'models_current.json'

    previous_models_dict = read_models_json(previous_models_filename)
    models_to_generate, current_models_dict = process_api_files(api_files_dict)

    # Determine GEMVERSION using Git tags
    latest_git_tag = get_latest_git_tag()
    if latest_git_tag:
        current_version = latest_git_tag.lstrip('v')
    else:
        current_version = '0.1.0'  # Default initial version

    # Check if there are changes
    new_models, removed_models, changed_defaults = compare_model_versions(previous_models_dict, current_models_dict)
    if new_models or removed_models or changed_defaults:
        gem_version = increment_version(current_version, prerelease_label if is_prerelease else None)
    else:
        gem_version = current_version

    # Read config.json
    config_data = read_config_file(CONFIG_TEMPLATE_FILENAME)

    # Get gem author and email
    gem_author = get_env_or_default('GEMAUTHOR', get_git_config_value('user.name'))
    gem_author_email = get_env_or_default('GEMAUTHOREMAIL', get_git_config_value('user.email'))

    # Validate gem author and email
    if not gem_author or not gem_author_email:
        print_colored("Gem author name and email are not set. Please set them via environment variables or config.json.", color='red')
        return

    # Avoid using GitHub no-reply email
    if is_no_reply_email(gem_author_email):
        print_colored("Your gem author email is a no-reply email. Please set a valid email.", color='red')
        return

    # Get GitHub repo URL and description
    github_repo_url = get_github_repo_url()
    if not github_repo_url:
        print_colored("Unable to determine GitHub repository URL.", color='red')
        return

    gem_description = get_github_repo_description() or "No description available."

    # Allow config to be overwritten by environment variables
    config_info = {
        'GEMNAME': get_env_or_default('GEMNAME', config_data.get('gemName')),
        # 'MODULENAME' will be set per model
        'GEMVERSION': get_env_or_default('GEMVERSION', gem_version),
        'GEMAUTHOR': gem_author,
        'GEMAUTHOREMAIL': gem_author_email,
        'GEMHOMEPAGE': get_env_or_default('GEMHOMEPAGE', config_data.get('gemHomepage')) or github_repo_url,
        'GEMLICENSE': get_env_or_default('GEMLICENSE', config_data.get('gemLicense')),
        'HTTPCLIENTTYPE': get_env_or_default('HTTPCLIENTTYPE', config_data.get('httpClientType')),
        'MODELPACKAGE': get_env_or_default('MODELPACKAGE', config_data.get('modelPackage')),
        'APIPACKAGE': get_env_or_default('APIPACKAGE', config_data.get('apiPackage'))
    }

    if is_interactive:
        print_colored("\nConfiguration Information:", color='cyan')
        for key, value in config_info.items():
            if key != 'MODULENAME':
                print_colored(f"{key}: {value}", color='white')
        if not prompt_confirmation("Do you want to proceed with these settings?"):
            print_colored("Operation cancelled by user.", color='red')
            return

    if is_dry_run:
        generate_dry_run_report(models_to_generate, previous_models_dict, current_models_dict, gem_version, config_info)
    else:
        # Generate models in a temporary directory
        with tempfile.TemporaryDirectory() as temp_dir:
            success = True
            for model in models_to_generate:
                model_config = config_info.copy()
                model_config['GEMNAME'] = model['gem_name']
                model_config['MODULENAME'] = model['module_name']
                model_config['GEMVERSION'] = config_info['GEMVERSION']

                # Prepare config replacements
                config_replacements = model_config

                # Paths in temp directory
                temp_lib_dir = os.path.join(temp_dir, model['lib_dir'])
                temp_config_path = os.path.join(temp_dir, model['config_path'])
                temp_gemspec_path = os.path.join(temp_lib_dir, f"{model['gem_name']}.gemspec")

                # Copy and modify config template
                os.makedirs(os.path.dirname(temp_config_path), exist_ok=True)
                copy_and_modify_template(CONFIG_TEMPLATE_FILENAME, temp_config_path, config_replacements)

                # Copy and modify gemspec template
                gemspec_replacements = {
                    'GEM_NAME': model['gem_name'],
                    'MODULE_NAME': model['module_name'],
                    'GEM_VERSION': config_info['GEMVERSION'],
                    'GEM_AUTHOR': config_info['GEMAUTHOR'],
                    'GEM_AUTHOR_EMAIL': config_info['GEMAUTHOREMAIL'],
                    'GEM_HOMEPAGE': config_info['GEMHOMEPAGE'],
                    'GEM_SUMMARY': gem_description,
                    'GEM_LONG_DESCRIPTION': gem_description,
                    'GEM_LICENSE': config_info['GEMLICENSE'],
                    'CHANGELOG_URI': f"{config_info['GEMHOMEPAGE']}/releases",
                    'OPENAPI_VERSION': model['version'],
                    'GENERATOR_INFO': "https://github.com/swagger-api/swagger-codegen.git\nSwagger Codegen version: 3.0.24"
                }
                copy_and_modify_template(GEMSPEC_TEMPLATE_FILENAME, temp_gemspec_path, gemspec_replacements)

                # Create .swagger-codegen-ignore
                ignore_file_destination = os.path.join(os.path.dirname(temp_config_path), '.swagger-codegen-ignore')
                create_swagger_codegen_ignore(ignore_file_destination)

                if is_interactive:
                    latest_tag = ' [latest]' if model['has_multiple_versions'] and model['is_latest'] else ''
                    print_colored(f"\nAbout to generate model: {model['gem_name']}", color='cyan')
                    print_colored(f"Module Name: {model['module_name']}{latest_tag}", color='white')
                    if not prompt_confirmation("Proceed with this model?"):
                        print_colored(f"Skipping model: {model['gem_name']}", color='yellow')
                        continue

                try:
                    # Generate the model
                    generate_model(model['api_file'], temp_config_path, temp_lib_dir)
                except subprocess.CalledProcessError as e:
                    print_colored(f"Error generating model {model['gem_name']}: {e}", color='red')
                    success = False
                    break

            # Move generated code to lib directory if successful
            if success:
                if is_interactive:
                    if not prompt_confirmation("All models generated successfully. Proceed to move files to final destination?"):
                        print_colored("Operation cancelled by user. No changes have been made.", color='red')
                        return

                for model in models_to_generate:
                    temp_lib_dir = os.path.join(temp_dir, model['lib_dir'])
                    final_lib_dir = model['lib_dir']
                    # Remove existing directory if it exists
                    if os.path.exists(final_lib_dir):
                        shutil.rmtree(final_lib_dir)
                    # Create parent directories if needed
                    os.makedirs(os.path.dirname(final_lib_dir), exist_ok=True)
                    # Move from temp to final location
                    shutil.move(temp_lib_dir, final_lib_dir)

                # Write updated models and version
                write_models_json(current_models_dict, previous_models_filename)
                write_models_json(current_models_dict, current_models_filename)

                with open(VERSION_FILE, 'w') as vf:
                    vf.write(gem_version)

                print_colored("Code generation completed successfully.", color='green')

                if is_interactive:
                    print_colored("\nPlease create your release notes following your preferred structure.", color='cyan')

            else:
                print_colored("Generation failed. No changes have been made.", color='red')

if __name__ == '__main__':
    main()
