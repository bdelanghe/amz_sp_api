#!/usr/bin/env python3

import os
import re
import shutil
import subprocess
import argparse
from glob import glob

# Constants
MODELS_DIRECTORY = os.path.join('..', 'selling-partner-api-models', 'models')
LIB_DIRECTORY = 'lib'
CONFIG_TEMPLATE_FILENAME = 'config.json'
PREVIOUS_MODELS_FILENAME = 'models_previous.txt'
CURRENT_MODELS_FILENAME = 'models_current.txt'
SWAGGER_CODEGEN_COMMAND = 'swagger-codegen'

# Define default versions for each API
DEFAULT_VERSIONS = {
    'orders-api-model': 'ordersV0.json',
    'fulfillment-inbound-api-model': 'fulfillmentInboundV0.json',
    'fulfillment-outbound-api-model': 'fulfillmentOutbound_2020-07-01.json',
    'product-pricing-api-model': 'productPricingV0.json',
    'finances-api-model': 'financesV0.json',
    'feeds-api-model': 'feeds_2021-06-30.json',
    'reports-api-model': 'reports_2021-06-30.json',
    # Add other APIs and their default versions here
}

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

def read_models_list(file_path):
    """
    Read the list of models from a file.

    Args:
        file_path (str): Path to the models list file.

    Returns:
        set: A set of model identifiers.
    """
    if not os.path.exists(file_path):
        return set()
    with open(file_path, 'r') as file:
        models = set(file.read().splitlines())
    return models

def write_models_list(models_set, file_path):
    """
    Write the list of models to a file.

    Args:
        models_set (set): A set of model identifiers.
        file_path (str): Path to the output file.
    """
    with open(file_path, 'w') as file:
        file.write('\n'.join(sorted(models_set)))

def compare_model_sets(previous_models_set, current_models_set):
    """
    Compare previous and current models to find new and removed models.

    Args:
        previous_models_set (set): Set of previous model identifiers.
        current_models_set (set): Set of current model identifiers.

    Returns:
        tuple: A tuple containing sets of new models and removed models.
    """
    new_models = current_models_set - previous_models_set
    removed_models = previous_models_set - current_models_set
    return new_models, removed_models

def process_api_files(api_files_dict, is_dry_run, previous_models_set, current_models_set):
    """
    Process each API and generate code for default and versioned models.

    Args:
        api_files_dict (dict): Dictionary mapping API names to lists of JSON file paths.
        is_dry_run (bool): Flag indicating whether to perform a dry run.
        previous_models_set (set): Set of previous model identifiers.
        current_models_set (set): Set to store current model identifiers.
    """
    for api_name, api_file_list in api_files_dict.items():
        module_name = extract_module_name(api_name)

        # Determine the default version for this API
        default_version_filename = DEFAULT_VERSIONS.get(api_name, None)

        # Process files
        for api_file in api_file_list:
            file_name = os.path.basename(api_file)
            version = extract_version_from_filename(file_name)
            version_clean = version

            # Determine if this is the default version
            is_default_version = (file_name == default_version_filename)

            if is_default_version:
                # Generate unversioned model
                unversioned_api_lib_dir = os.path.join(LIB_DIRECTORY, api_name)
                unversioned_config_path = os.path.join(unversioned_api_lib_dir, CONFIG_TEMPLATE_FILENAME)

                if is_dry_run:
                    print(f"Would generate unversioned model for {api_name}, version {version_clean}")
                    print(f"MODULE_NAME: AmzSpApi::{module_name}")
                else:
                    recreate_directory(unversioned_api_lib_dir)
                    copy_and_modify_config_template(CONFIG_TEMPLATE_FILENAME, unversioned_config_path, api_name, f"AmzSpApi::{module_name}")
                    generate_model(api_file, unversioned_config_path, unversioned_api_lib_dir, is_default_version=True)
            else:
                # Generate versioned model
                versioned_module_name = f"{module_name}::V{version_clean}"
                versioned_api_name = f"{api_name}_V{version_clean}"
                model_identifier = f"{api_name} V{version_clean}"
                current_models_set.add(model_identifier)

                if is_dry_run:
                    print(f"Would generate versioned model for {versioned_api_name}")
                    print(f"MODULE_NAME: AmzSpApi::{versioned_module_name}")
                else:
                    versioned_lib_dir = os.path.join(LIB_DIRECTORY, api_name, f"v{version_clean}")
                    versioned_config_path = os.path.join(versioned_lib_dir, CONFIG_TEMPLATE_FILENAME)
                    recreate_directory(versioned_lib_dir)
                    copy_and_modify_config_template(CONFIG_TEMPLATE_FILENAME, versioned_config_path, versioned_api_name, f"AmzSpApi::{module_name}::V{version_clean}")
                    generate_model(api_file, versioned_config_path, versioned_lib_dir, is_default_version=False)

            # Add model identifier to current models set
            model_identifier = f"{api_name} V{version_clean}"
            current_models_set.add(model_identifier)

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

def recreate_directory(directory_path):
    """
    Remove and recreate a directory.

    Args:
        directory_path (str): Path to the directory.
    """
    if os.path.exists(directory_path):
        shutil.rmtree(directory_path)
    os.makedirs(directory_path)

def copy_and_modify_config_template(source_config_path, destination_config_path, gem_name, module_name):
    """
    Copy the config template and replace placeholders.

    Args:
        source_config_path (str): Path to the source config template.
        destination_config_path (str): Path to the destination config file.
        gem_name (str): The gem name to replace in the config.
        module_name (str): The module name to replace in the config.
    """
    shutil.copy(source_config_path, destination_config_path)
    replace_placeholder_in_file(destination_config_path, 'GEMNAME', gem_name)
    replace_placeholder_in_file(destination_config_path, 'MODULENAME', module_name)

def replace_placeholder_in_file(file_path, placeholder, replacement):
    """
    Replace a placeholder string with the replacement in a file.

    Args:
        file_path (str): Path to the file.
        placeholder (str): The placeholder string to replace.
        replacement (str): The replacement string.
    """
    with open(file_path, 'r') as file:
        content = file.read()
    content = content.replace(placeholder, replacement)
    with open(file_path, 'w') as file:
        file.write(content)

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
    lib_directory = os.path.join(output_directory, 'lib')
    if os.path.exists(lib_directory):
        shutil.rmtree(lib_directory, ignore_errors=True)
    gemspec_files = [f for f in os.listdir(output_directory) if f.endswith('.gemspec')]
    for gemspec_file in gemspec_files:
        os.remove(os.path.join(output_directory, gemspec_file))

def main():
    """
    Main function to orchestrate code generation and model tracking.
    """
    check_dependencies()
    args = parse_command_line_arguments()
    is_dry_run = args.dry_run

    api_files_dict = collect_api_files(MODELS_DIRECTORY)

    previous_models_set = read_models_list(PREVIOUS_MODELS_FILENAME)
    current_models_set = set()

    process_api_files(api_files_dict, is_dry_run, previous_models_set, current_models_set)

    if is_dry_run:
        new_models_set, removed_models_set = compare_model_sets(previous_models_set, current_models_set)
        print("\n********** Model Comparison **********")
        print("New models:")
        for model_identifier in sorted(new_models_set):
            print(model_identifier)
        print("\nRemoved models:")
        for model_identifier in sorted(removed_models_set):
            print(model_identifier)
        print("**************************************")
    else:
        write_models_list(current_models_set, PREVIOUS_MODELS_FILENAME)
        if os.path.exists(CURRENT_MODELS_FILENAME):
            os.remove(CURRENT_MODELS_FILENAME)

if __name__ == '__main__':
    main()
