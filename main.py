#!/usr/bin/env python3

import os
from config.config import Config
from utils.codegen_utils import check_dependencies, process_and_generate_models
from utils.models_utils import Models
from utils.interactive_utils import print_error, print_info, prompt_confirmation, print_model_overview

def main() -> None:
    # Parse command-line arguments
    import argparse
    parser = argparse.ArgumentParser(description='Generate API clients from Swagger JSON files.')
    parser.add_argument('--overview', action='store_true', help='Print the model overview and exit.')
    parser.add_argument('--interactive', action='store_true', help='Run interactively, prompting for user confirmation.')
    parser.add_argument('--print-config', action='store_true', help='Display the current configuration and exit.')
    parser.add_argument('--dry-run', action='store_true', help='List models to be generated without actually generating them.')
    parser.add_argument('--json', action='store_true', help='Output results in JSON format.')
    args = parser.parse_args()

    show_overview = args.overview
    is_interactive = args.interactive
    show_config = args.print_config
    json_output = args.json
    is_dry_run = args.dry_run

    # Check for dependencies before starting
    check_dependencies()

    # Load Configurations using Singleton
    config = Config()

    # Create Models instance
    models = Models(config.get('modelsSourceDirectory'), config.get('libDirectory'), config.get('configTemplateFilename'))

    if show_config:
        config.print_config(format_type='json' if json_output else 'pretty')
        return

    if show_overview:
        models.print_overview(format_type='json' if json_output else 'pretty')
        return

    # Step 4: Dry Run or Generate Models
    process_and_generate_models(models.get_overview(), config, is_dry_run, is_interactive)

if __name__ == '__main__':
    main()
