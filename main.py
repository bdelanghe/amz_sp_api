#!/usr/bin/env python3

import os
import tempfile
from config.config import read_config_file, get_env_or_default
from utils.git_utils import get_git_config_value
from utils.github_utils import get_github_repo_url
from utils.codegen_utils import check_dependencies, generate_model
from utils.models_utils import collect_api_files
from utils.version_utils import get_latest_git_tag, increment_version
from utils.interactive_utils import print_colored, prompt_confirmation

def main() -> None:
    """
    Main function to orchestrate code generation and model tracking.
    """
    # Parse command-line arguments
    import argparse
    parser = argparse.ArgumentParser(description='Generate API clients from Swagger JSON files.')
    parser.add_argument('--dry-run', action='store_true', help='Perform a dry run without making any changes.')
    parser.add_argument('--interactive', action='store_true', help='Run the script in interactive mode, prompting for confirmation at each step.')
    args = parser.parse_args()

    is_dry_run = args.dry_run
    is_interactive = args.interactive

    # Ensure dry-run and interactive aren't used together
    if is_dry_run and is_interactive:
        print_colored("Error: --dry-run and --interactive cannot be used together.", color='red')
        return

    check_dependencies()

    # Read configurations
    config_data = read_config_file('config.json')

    # Collect API files
    api_files_dict = collect_api_files('selling-partner-api-models/models')

    # Determine GEMVERSION using Git tags
    latest_git_tag = get_latest_git_tag()
    current_version = latest_git_tag.lstrip('v') if latest_git_tag else '0.1.0'
    gem_version = increment_version(current_version)

    # Get git config values
    gem_author = get_env_or_default('GEMAUTHOR', config_data.get('gemAuthor')) or get_git_config_value('user.name')
    gem_author_email = get_env_or_default('GEMAUTHOREMAIL', config_data.get('gemAuthorEmail')) or get_git_config_value('user.email')

    if not gem_author or not gem_author_email:
        print_colored("Git user.name and user.email are not set. Please configure them.", color='red')
        return

    # Get GitHub repo URL
    github_repo_url = get_github_repo_url() or 'https://github.com/yourusername/yourrepo'

    # Allow config to be overwritten by environment variables
    config_info = {
        'GEMNAME': get_env_or_default('GEMNAME', config_data.get('gemName')),
        # 'MODULENAME' will be set per model
        'GEMVERSION': get_env_or_default('GEMVERSION', gem_version),
        'GEMAUTHOR': gem_author,
        'GEMAUTHOREMAIL': gem_author_email,
        'GEMHOMEPAGE': get_env_or_default('GEMHOMEPAGE', github_repo_url),
        'GEMLICENSE': get_env_or_default('GEMLICENSE', config_data.get('gemLicense')),
        'HTTPCLIENTTYPE': get_env_or_default('HTTPCLIENTTYPE', config_data.get('httpClientType')),
        'MODELPACKAGE': get_env_or_default('MODELPACKAGE', config_data.get('modelPackage')),
        'APIPACKAGE': get_env_or_default('APIPACKAGE', config_data.get('apiPackage'))
    }

    if is_dry_run:
        # Print configuration information
        print_colored("\nConfiguration Information:", color='cyan')
        for key, value in config_info.items():
            if key != 'MODULENAME':
                print_colored(f"{key}: {value}", color='white')

        # Generate dry-run report for models
        with tempfile.NamedTemporaryFile() as previous_models_filename, tempfile.NamedTemporaryFile() as current_models_filename:
            from utils.models_utils import read_models_json, process_api_files, generate_dry_run_report, write_models_json

            previous_models_dict = read_models_json(previous_models_filename.name)
            models_to_generate, current_models_dict = process_api_files(api_files_dict)

            generate_dry_run_report(
                models_to_generate=models_to_generate,
                previous_models_dict=previous_models_dict,
                current_models_dict=current_models_dict,
                gem_version=gem_version,
                config_info=config_info
            )

    else:
        # Print configuration information for non-dry-run scenario
        print_colored("\nConfiguration Information:", color='cyan')
        for key, value in config_info.items():
            if key != 'MODULENAME':
                print_colored(f"{key}: {value}", color='white')

        if is_interactive:
            if not prompt_confirmation("Proceed with this configuration?"):
                print_colored("Operation cancelled by user.", color='red')
                return

        # Generate models in a temporary directory
        with tempfile.TemporaryDirectory() as temp_dir:
            for api_name, api_files in api_files_dict.items():
                print_colored(f"Generating model for API: {api_name}", color='blue')
                generate_model(api_files[0], 'config/config.json', os.path.join(temp_dir, 'output'))

if __name__ == '__main__':
    main()
