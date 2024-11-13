#!/usr/bin/env python3

import tempfile
import os
from config.config import Config
from utils.codegen_utils import check_dependencies, generate_model
from utils.models_utils import Models
from utils.interactive_utils import print_error, print_info, prompt_confirmation, print_model_overview

def main() -> None:
    """
    Main function to orchestrate code generation and model tracking.
    """
    # Parse command-line arguments
    import argparse
    parser = argparse.ArgumentParser(description='Generate API clients from Swagger JSON files.')
    parser.add_argument('--overview', action='store_true', help='Print the model overview and exit.')
    parser.add_argument('--interactive', action='store_true', help='Run interactively, prompting for user confirmation.')
    parser.add_argument('--print-config', action='store_true', help='Display the current configuration and exit.')
    parser.add_argument('--json', action='store_true', help='Output results in JSON format.')
    parser.add_argument('--dry-run', action='store_true', help='Simulate model generation without making any changes.')
    args = parser.parse_args()

    show_overview = args.overview
    is_interactive = args.interactive
    show_config = args.print_config
    json_output = args.json
    is_dry_run = args.dry_run

    # Step 1: Check dependencies
    check_dependencies()
    if is_interactive and not prompt_confirmation("Dependencies check completed. Proceed?"):
        print_error("Operation cancelled by user.")
        return

    # Step 2: Load Configurations
    config = Config()
    if show_config:
        config.print_config(format_type='json' if json_output else 'pretty')
        return  # Exit after printing the configuration

    # Step 3: Load Models using Singleton
    models = Models(config.get('modelsSourceDirectory'), config.get('libDirectory'), config.get('configTemplateFilename'))
    if show_overview:
        overview = models.get_overview()
        print_model_overview(overview, format_type='json' if json_output else 'pretty')
        return  # Exit after printing the model overview

    # Step 4: Dry Run or Generate Models
    if is_dry_run:
        print_info("Dry run mode: Listing models to be generated...")
        for model in models.models_to_generate:
            print_info(f"Would generate model: {model['api_name']} V{model['version']} - Output directory: {model['lib_dir']}")
        if is_interactive and not prompt_confirmation("Dry run completed. Proceed to actual generation?"):
            print_error("Operation cancelled by user.")
            return
    else:
        with tempfile.TemporaryDirectory() as temp_dir:
            for api_name, api_files in models.api_files.items():
                print_info(f"Generating model for API: {api_name}")
                generate_model(api_files[0], config.get('configTemplateFilename'), os.path.join(temp_dir, 'output'))
                if is_interactive and not prompt_confirmation(f"Model for API {api_name} generated. Proceed to the next?"):
                    print_error("Operation cancelled by user.")
                    return

if __name__ == '__main__':
    main()
