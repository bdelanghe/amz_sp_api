#!/usr/bin/env python3

import tempfile
import os
from config.config import Config
from utils.codegen_utils import check_dependencies, generate_model
from utils.models_utils import collect_api_files
from utils.version_utils import get_latest_git_tag, increment_version
from utils.interactive_utils import print_colored, prompt_confirmation, print_dry_run_report

import tempfile
import os
from config.config import Config
from utils.codegen_utils import check_dependencies, generate_model
from utils.models_utils import collect_api_files
from utils.version_utils import get_latest_git_tag, increment_version
from utils.interactive_utils import print_colored, prompt_confirmation, print_dry_run_report

def main() -> None:
    """
    Main function to orchestrate code generation and model tracking.
    """
    # Parse command-line arguments
    import argparse
    parser = argparse.ArgumentParser(description='Generate API clients from Swagger JSON files.')
    parser.add_argument('--dry-run', action='store_true', help='Perform a dry run without making any changes.')
    parser.add_argument('--interactive', action='store_true', help='Run the script in interactive mode, prompting for confirmation at each step.')
    parser.add_argument('--print-config', action='store_true', help='Print the current configuration and exit.')
    args = parser.parse_args()

    is_dry_run = args.dry_run
    is_interactive = args.interactive
    is_print_config = args.print_config

    # Ensure dry-run and interactive aren't used together
    if is_dry_run and is_interactive:
        print_colored("Error: --dry-run and --interactive cannot be used together.", color='red')
        return

    # Load Configurations using Singleton
    config = Config()

    # Determine GEMVERSION using Git tags
    latest_git_tag = get_latest_git_tag()
    current_version = latest_git_tag.lstrip('v') if latest_git_tag else '0.1.0'
    gem_version = increment_version(current_version)

    config_info = {
        key: config.get(key.lower()) for key in [
            'gemName', 'moduleName', 'gemVersion', 'gemAuthor', 'gemAuthorEmail',
            'gemHomepage', 'gemLicense', 'httpClientType', 'modelPackage', 'apiPackage'
        ]
    }
    config_info['gemVersion'] = gem_version

    if is_print_config:
        # Print configuration information
        print_colored("\nCurrent Configuration Information:", color='cyan')
        for key, value in config_info.items():
            if key == 'moduleName':
                print_colored(f"{key}: {value} (dynamically set per model)", color='yellow')
            elif key == 'gemVersion':
                print_colored(f"{key}: {value} (dynamically set from latest Git tag)", color='yellow')
            else:
                print_colored(f"{key}: {value}", color='white')
        return

    check_dependencies()

    # Collect API files
    api_files_dict = collect_api_files(config.get('libDirectory'))

    if is_dry_run:
        # Print configuration information
        print_colored("\nConfiguration Information:", color='cyan')
        for key, value in config_info.items():
            if key == 'moduleName':
                print_colored(f"{key}: {value} (dynamically set per model)", color='yellow')
            elif key == 'gemVersion':
                print_colored(f"{key}: {value} (dynamically set from latest Git tag)", color='yellow')
            else:
                print_colored(f"{key}: {value}", color='white')

        # Generate dry-run report for models
        with tempfile.NamedTemporaryFile() as previous_models_filename:
            from utils.models_utils import read_models_json, generate_dry_run_report

            previous_models_dict = read_models_json(previous_models_filename.name)
            report = generate_dry_run_report(
                api_files_dict=api_files_dict,
                previous_models_dict=previous_models_dict,
                gem_version=gem_version,
                config_info=config_info
            )
            print_dry_run_report(report)

    else:
        # Print configuration information for non-dry-run scenario
        print_colored("\nConfiguration Information:", color='cyan')
        for key, value in config_info.items():
            if key == 'moduleName':
                print_colored(f"{key}: {value} (dynamically set per model)", color='yellow')
            elif key == 'gemVersion':
                print_colored(f"{key}: {value} (dynamically set from latest Git tag)", color='yellow')
            else:
                print_colored(f"{key}: {value}", color='white')

        if is_interactive:
            if not prompt_confirmation("Proceed with this configuration?"):
                print_colored("Operation cancelled by user.", color='red')
                return

        # Generate models in a temporary directory
        with tempfile.TemporaryDirectory() as temp_dir:
            for api_name, api_files in api_files_dict.items():
                print_colored(f"Generating model for API: {api_name}", color='blue')
                generate_model(api_files[0], config.get('configTemplateFilename'), os.path.join(temp_dir, 'output'))

if __name__ == '__main__':
    main()
