#!/usr/bin/env python3

import tempfile
import os
from config.config import Config
from utils.codegen_utils import check_dependencies, generate_model
from utils.models_utils import collect_api_files
from utils.interactive_utils import print_error, print_info, prompt_confirmation, print_dry_run_report

def main() -> None:
    """
    Main function to orchestrate code generation and model tracking.
    """
    # Parse command-line arguments
    import argparse
    parser = argparse.ArgumentParser(description='Generate API clients from Swagger JSON files.')
    parser.add_argument('--dry-run', action='store_true', help='Perform a dry run without making any changes.')
    parser.add_argument('--interactive', action='store_true', help='Run the script in interactive mode, prompting for confirmation at each step.')
    parser.add_argument('--print-config', action='store_true', help='Print the configuration and exit.')
    args = parser.parse_args()

    is_dry_run = args.dry_run
    is_interactive = args.interactive
    print_config = args.print_config

    # Ensure dry-run and interactive aren't used together
    if is_dry_run and is_interactive:
        print_error("--dry-run and --interactive cannot be used together.")
        return

    check_dependencies()

    # Load Configurations using Singleton
    config = Config()

    # Print configuration if flag is set
    if print_config:
        config.print_config()
        return

    # Collect API files
    models_source_directory = config.get('modelsSourceDirectory')
    api_files_dict = collect_api_files(models_source_directory)

    if is_dry_run:
        # Generate dry-run report for models
        with tempfile.NamedTemporaryFile() as previous_models_filename:
            from utils.models_utils import read_models_json, generate_dry_run_report

            previous_models_dict = read_models_json(previous_models_filename.name)
            report = generate_dry_run_report(
                api_files_dict=api_files_dict,
                previous_models_dict=previous_models_dict,
                gem_version=config.get('gemVersion'),
                config_info=config.get_all(),
                lib_directory=config.get('libDirectory'),
                config_template_filename=config.get('configTemplateFilename')
            )
            print_dry_run_report(report)

    else:
        # Print configuration information for non-dry-run scenario
        config.print_config()

        if is_interactive:
            if not prompt_confirmation("Proceed with this configuration?"):
                print_error("Operation cancelled by user.")
                return

        # Generate models in a temporary directory
        with tempfile.TemporaryDirectory() as temp_dir:
            for api_name, api_files in api_files_dict.items():
                print_info(f"Generating model for API: {api_name}")
                generate_model(api_files[0], config.get('configTemplateFilename'), os.path.join(temp_dir, 'output'))

if __name__ == '__main__':
    main()
